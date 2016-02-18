From: romain.perier@gmail.com (Romain Perier)
Date: Thu, 18 Feb 2016 13:20:00 +0100
Subject: [PATCH 1/2] ARM: meson: Adding support to retrieve serial and SoC
 revision
In-Reply-To: <CAOQ7t2b8N+w33zKMfedtQqJ+-u1=kGn0pK4cBXhXB8LGx6qrtQ@mail.gmail.com>
References: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
 <1455730114-2547-2-git-send-email-romain.perier@gmail.com>
 <CAOQ7t2b8N+w33zKMfedtQqJ+-u1=kGn0pK4cBXhXB8LGx6qrtQ@mail.gmail.com>
Message-ID: <CABgxDoKOUd_k4kmrcswnUCaKAN8KQ11f8dUTMXDisySp_SVcMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

2016-02-17 21:34 GMT+01:00 Carlo Caione <carlo@caione.org>:
> On Wed, Feb 17, 2016 at 6:28 PM, Romain Perier <romain.perier@gmail.com> wrote:
>> This path adds support to get the revision and the serial of the running
>> SoC, on Meson8. On these plaforms, these informations can be found into
>
> no Meson8b or Meson6?

Well, I only tested on Meson8b, I don't know if it works in the same
way on older Meson, however I can take a look to the vendor kernel
probably...

>
>> CBUS registers. To do so, we instanciate a syscon register, then create
>
> What you mean with syscon register?


I mean that we use a syscon regmap to access these registers.


>
>> a soc_device, and finally we expose everything to the system.
>>
>> Signed-off-by: Romain Perier <romain.perier@gmail.com>
>> ---
>>  arch/arm/mach-meson/meson.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>
>> diff --git a/arch/arm/mach-meson/meson.c b/arch/arm/mach-meson/meson.c
>> index 4e23571..2816e30 100644
>> --- a/arch/arm/mach-meson/meson.c
>> +++ b/arch/arm/mach-meson/meson.c
>> @@ -13,8 +13,16 @@
>>   *
>>   */
>>
>> +#include <linux/of_address.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/sys_soc.h>
>>  #include <asm/mach/arch.h>
>> +#include <asm/system_info.h>
>> +
>> +#define MESON_REVISION_REG (0x45c)
>>
>>  static const char * const meson_common_board_compat[] = {
>>         "amlogic,meson6",
>> @@ -23,7 +31,54 @@ static const char * const meson_common_board_compat[] = {
>>         NULL,
>>  };
>>
>> +static void __init meson_init_machine(void)
>> +{
>> +       struct soc_device_attribute *soc_dev_attr;
>> +       struct soc_device *soc_dev;
>> +       struct regmap *hwrev;
>> +       unsigned int val;
>> +       int ret;
>> +
>> +       hwrev = syscon_regmap_lookup_by_compatible("amlogic,meson8b-hwrev");
>
> Is this specific only for Meson8b?


For now, yes. However, As I said, I can to do something generic. What
do you think ?


>
>> +       if (IS_ERR(hwrev)) {
>> +               pr_err("hwrev node not found\n");
>> +               return;
>> +       }
>> +
>> +       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>> +       if (!soc_dev_attr)
>> +               return;
>
> Missing blank line
>
>> +       ret = regmap_read(hwrev, 0, &val);
>> +       if (ret < 0) {
>> +               pr_err("Could not get SoC id\n");
>
> kfree(soc_dev_attr)
>
>> +               return;
>> +       }
>> +       system_serial_high = val << 24;
>> +
>> +       ret = regmap_read(hwrev, MESON_REVISION_REG, &val);
>> +       if (ret < 0) {
>> +               pr_err("Could not get SoC revision\n");
>
> ditto
>
>> +               return;
>> +       }
>> +       system_rev = val == 0x11111111 ? 0xA : 0xB;
>> +
>> +       soc_dev_attr->family = "Amlogic Meson";
>> +       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "0x%x", system_rev);
>> +       soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "0x%x", system_serial_high);
>> +
>> +       soc_dev = soc_device_register(soc_dev_attr);
>> +       if (IS_ERR(soc_dev)) {
>> +               pr_err("Could not register soc device\n");
>> +               kfree(soc_dev_attr);
>
> leaking soc_dev_attr->revision and  soc_dev_attr->soc_id also any
> reason why you are not kasprintf-ing also family?
>

My problem is that I cannot use a devm allocation there, right ? I
mean I have no device... Well, I will think about it.

>> +               return;
>> +       }
>> +
>> +       pr_info("Amlogic Meson SoC Rev%X (%X:%X)\n", system_rev, system_serial_high, system_rev);
>> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
>
> Compiling I got:
>
>   CC      arch/arm/mach-meson/meson.o
> arch/arm/mach-meson/meson.c: In function 'meson_init_machine':
> arch/arm/mach-meson/meson.c:77:63: warning: passing argument 4 of
> 'of_platform_populate' from incompatible pointer type
>   of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
>                                                                ^
> In file included from arch/arm/mach-meson/meson.c:17:0:
> include/linux/of_platform.h:71:12: note: expected 'struct device *'
> but argument is of type 'struct soc_device *'
>  extern int of_platform_populate(struct device_node *root,
>             ^
>

Ah, good catch ! I build everything using yocto, so I did not see
these warnings ^^

>> +}
>> +
>>  DT_MACHINE_START(MESON, "Amlogic Meson platform")
>> +       .init_machine   = meson_init_machine,
>
> Uhm, you are assuming that this code is valid for Meson8, Meson8b and
> also Meson6. Are you sure about that?

No, you're right.

Thanks,
Romain
