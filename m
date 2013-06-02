From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 2 Jun 2013 22:48:54 +0800
Subject: [PATCH] arm: prima2: move to generic reset controller driver
 framework
In-Reply-To: <20130601052239.GF5189@quad.lixom.net>
References: <1369710386-23303-1-git-send-email-Baohua.Song@csr.com>
 <20130601052239.GF5189@quad.lixom.net>
Message-ID: <CAGsJ_4zzcJBuEqusAdAssms4UhaA+KmBfysY64mM2sfCV=uAPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

2013/6/1 Olof Johansson <olof@lixom.net>:
> Hi,
>
> On Tue, May 28, 2013 at 11:06:26AM +0800, Barry Song wrote:
>> this moves to generic IP module reset framework, and make other drivers
>> use common device_reset() API.
>>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  arch/arm/boot/dts/atlas6.dtsi |  3 +-
>>  arch/arm/boot/dts/marco.dtsi  |  3 +-
>>  arch/arm/boot/dts/prima2.dtsi |  3 +-
>>  arch/arm/mach-prima2/rstc.c   | 71 ++++++++++++++++++++++++++-----------------
>>  4 files changed, 49 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
>> index 7d1a279..ffe5203 100644
>> --- a/arch/arm/boot/dts/atlas6.dtsi
>> +++ b/arch/arm/boot/dts/atlas6.dtsi
>> @@ -56,9 +56,10 @@
>>                               #clock-cells = <1>;
>>                       };
>>
>> -                     reset-controller at 88010000 {
>> +                     rstc: reset-controller at 88010000 {
>>                               compatible = "sirf,prima2-rstc";
>>                               reg = <0x88010000 0x1000>;
>> +                             #reset-cells = <1>;
>>                       };
>>
>>                       rsc-controller at 88020000 {
>> diff --git a/arch/arm/boot/dts/marco.dtsi b/arch/arm/boot/dts/marco.dtsi
>> index 1579c34..0c9647d 100644
>> --- a/arch/arm/boot/dts/marco.dtsi
>> +++ b/arch/arm/boot/dts/marco.dtsi
>> @@ -58,9 +58,10 @@
>>                       #size-cells = <1>;
>>                       ranges = <0xc2000000 0xc2000000 0x1000000>;
>>
>> -                     reset-controller at c2000000 {
>> +                     rstc: reset-controller at c2000000 {
>>                               compatible = "sirf,marco-rstc";
>>                               reg = <0xc2000000 0x10000>;
>> +                             #reset-cells = <1>;
>>                       };
>>               };
>>
>> diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
>> index 3329719..5ecf1f9 100644
>> --- a/arch/arm/boot/dts/prima2.dtsi
>> +++ b/arch/arm/boot/dts/prima2.dtsi
>> @@ -65,9 +65,10 @@
>>                               #clock-cells = <1>;
>>                       };
>>
>> -                     reset-controller at 88010000 {
>> +                     rstc: reset-controller at 88010000 {
>>                               compatible = "sirf,prima2-rstc";
>>                               reg = <0x88010000 0x1000>;
>> +                             #reset-cells = <1>;
>>                       };
>>
>>                       rsc-controller at 88020000 {
>> diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
>> index 435019c..a4d77eb 100644
>> --- a/arch/arm/mach-prima2/rstc.c
>> +++ b/arch/arm/mach-prima2/rstc.c
>> @@ -13,44 +13,24 @@
>>  #include <linux/device.h>
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>> +#include <linux/reset-controller.h>
>> +
>> +#define SIRFSOC_RSTBIT_NUM   64
>>
>>  void __iomem *sirfsoc_rstc_base;
>>  static DEFINE_MUTEX(rstc_lock);
>>
>> -static struct of_device_id rstc_ids[]  = {
>> -     { .compatible = "sirf,prima2-rstc" },
>> -     { .compatible = "sirf,marco-rstc" },
>> -     {},
>> -};
>> -
>> -static int __init sirfsoc_of_rstc_init(void)
>> -{
>> -     struct device_node *np;
>> -
>> -     np = of_find_matching_node(NULL, rstc_ids);
>> -     if (!np)
>> -             panic("unable to find compatible rstc node in dtb\n");
>> -
>> -     sirfsoc_rstc_base = of_iomap(np, 0);
>> -     if (!sirfsoc_rstc_base)
>> -             panic("unable to map rstc cpu registers\n");
>> -
>> -     of_node_put(np);
>> -
>> -     return 0;
>> -}
>> -early_initcall(sirfsoc_of_rstc_init);
>> -
>> -int sirfsoc_reset_device(struct device *dev)
>> +static int sirfsoc_reset_module(struct reset_controller_dev *rcdev,
>> +                                     unsigned long sw_reset_idx)
>>  {
>> -     u32 reset_bit;
>> +     u32 reset_bit = sw_reset_idx;
>>
>> -     if (of_property_read_u32(dev->of_node, "reset-bit", &reset_bit))
>> +     if (reset_bit >= SIRFSOC_RSTBIT_NUM)
>>               return -EINVAL;
>>
>>       mutex_lock(&rstc_lock);
>>
>> -     if (of_device_is_compatible(dev->of_node, "sirf,prima2-rstc")) {
>> +     if (of_device_is_compatible(rcdev->of_node, "sirf,prima2-rstc")) {
>>               /*
>>                * Writing 1 to this bit resets corresponding block. Writing 0 to this
>>                * bit de-asserts reset signal of the corresponding block.
>> @@ -80,6 +60,41 @@ int sirfsoc_reset_device(struct device *dev)
>>       return 0;
>>  }
>>
>> +static struct reset_control_ops sirfsoc_rstc_ops = {
>> +     .reset = sirfsoc_reset_module,
>> +};
>> +
>> +static struct reset_controller_dev sirfsoc_reset_controller = {
>> +     .ops = &sirfsoc_rstc_ops,
>> +     .nr_resets = SIRFSOC_RSTBIT_NUM,
>> +};
>> +
>> +static struct of_device_id rstc_ids[]  = {
>> +     { .compatible = "sirf,prima2-rstc" },
>> +     { .compatible = "sirf,marco-rstc" },
>> +     {},
>> +};
>> +
>> +static int __init sirfsoc_of_rstc_init(void)
>> +{
>> +     struct device_node *np = of_find_matching_node(NULL, rstc_ids);
>> +     if (!np)
>> +             goto out;
>
> Return -ENODEV?

after appling Srinivas's "[PATCH v1 1/2] ARM:prima2: move
sirfsoc_of_rstc_init to .init_early", we will avoid this execution
branch.
i will send v2 based on applied Srinivas's patches.

>
>> +     sirfsoc_rstc_base = of_iomap(np, 0);
>> +     if (!sirfsoc_rstc_base)
>> +             panic("unable to map rstc cpu registers\n");
>
> Is this really panic-worthy? Would it be sufficient to report error and
> continue booting?

i am thinking reset controller is an infrastructure component as many
other modules need it to reset their hardware IP. if this one fails,
letting the system crash earlier should make problems more visible and
don't defer faults to later. so i took it as an assert.

>
>> +
>> +     sirfsoc_reset_controller.of_node = np;
>> +
>> +     if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
>> +             reset_controller_register(&sirfsoc_reset_controller);
>> +
>> +out:
>> +     return 0;
>> +}
>> +arch_initcall(sirfsoc_of_rstc_init);
>

-barry
