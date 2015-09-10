From: andy.yan@rock-chips.com (Andy Yan)
Date: Thu, 10 Sep 2015 18:48:33 +0800
Subject: [PATCH] ARM: rockchip: add reboot notifier
In-Reply-To: <CALW4P+JpP1EEaa3_H4uFzFcTnBW8XPNa7shCNLDQ=z7=3ZmnKA@mail.gmail.com>
References: <1441716187-29446-1-git-send-email-andy.yan@rock-chips.com>
 <CALW4P+JpP1EEaa3_H4uFzFcTnBW8XPNa7shCNLDQ=z7=3ZmnKA@mail.gmail.com>
Message-ID: <55F16001.3000100@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexey:

On 2015?09?09? 05:50, Alexey Klimov wrote:
> Hi Andy,
>
> On Tue, Sep 8, 2015 at 3:43 PM, Andy Yan <andy.yan@rock-chips.com> wrote:
>> rockchip platform have a protocol to pass the the kernel
> Double 'the'?
    this is will be removed.
>
>> reboot mode to bootloader by some special registers when
>> system reboot. By this way the bootloader can take different
>> action according to the different kernel reboot mode, for
>> example, command "reboot loader" will reboot the board to
>> rockusb mode, this is a very convenient way to get the board
>> to download mode.
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>> ---
>>
>>   arch/arm/mach-rockchip/Makefile |   2 +-
>>   arch/arm/mach-rockchip/loader.h |  22 +++++++++
>>   arch/arm/mach-rockchip/reboot.c | 103 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 126 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/mach-rockchip/loader.h
>>   create mode 100644 arch/arm/mach-rockchip/reboot.c
>>
>> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
>> index 5c3a9b2..cd291e3 100644
>> --- a/arch/arm/mach-rockchip/Makefile
>> +++ b/arch/arm/mach-rockchip/Makefile
>> @@ -1,5 +1,5 @@
>>   CFLAGS_platsmp.o := -march=armv7-a
>>
>> -obj-$(CONFIG_ARCH_ROCKCHIP) += rockchip.o
>> +obj-$(CONFIG_ARCH_ROCKCHIP) += rockchip.o reboot.o
>>   obj-$(CONFIG_PM_SLEEP) += pm.o sleep.o
>>   obj-$(CONFIG_SMP) += headsmp.o platsmp.o
>> diff --git a/arch/arm/mach-rockchip/loader.h b/arch/arm/mach-rockchip/loader.h
>> new file mode 100644
>> index 0000000..bf51baa
>> --- /dev/null
>> +++ b/arch/arm/mach-rockchip/loader.h
>> @@ -0,0 +1,22 @@
>> +#ifndef __MACH_ROCKCHIP_LOADER_H
>> +#define __MACH_ROCKCHIP_LOADER_H
>> +
>> +/*high 24 bits is tag, low 8 bits is type*/
>> +#define SYS_LOADER_REBOOT_FLAG   0x5242C300
>> +
>> +enum {
>> +       BOOT_NORMAL = 0, /* normal boot */
>> +       BOOT_LOADER,     /* enter loader rockusb mode */
>> +       BOOT_MASKROM,    /* enter maskrom rockusb mode (not support now) */
>> +       BOOT_RECOVER,    /* enter recover */
>> +       BOOT_NORECOVER,  /* do not enter recover */
>> +       BOOT_SECONDOS,   /* boot second OS (not support now)*/
>> +       BOOT_WIPEDATA,   /* enter recover and wipe data. */
>> +       BOOT_WIPEALL,    /* enter recover and wipe all data. */
>> +       BOOT_CHECKIMG,   /* check firmware img with backup part*/
>> +       BOOT_FASTBOOT,   /* enter fast boot mode */
>> +       BOOT_SECUREBOOT_DISABLE,
>> +       BOOT_CHARGING,   /* enter charge mode */
>> +       BOOT_MAX         /* MAX VALID BOOT TYPE.*/
> Looks like you only implemented NORMAL, RECOVER, LOADER and CHARGING.
> Are you keeping other entries for keeping right order and keep
> consistency?
> Or have plans for future?
    to keep the right order,some of them maybe implemented in
    the future.
>
>> +};
>> +#endif
>> diff --git a/arch/arm/mach-rockchip/reboot.c b/arch/arm/mach-rockchip/reboot.c
>> new file mode 100644
>> index 0000000..704bc16
>> --- /dev/null
>> +++ b/arch/arm/mach-rockchip/reboot.c
>> @@ -0,0 +1,103 @@
>> +#include <linux/init.h>
> Usually people place in the beginning copyright and GPL license header info.
>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/reboot.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>> +#include "loader.h"
>> +
>> +#define RK3188_PMU_SYS_REG0             0x40
>> +#define RK3288_PMU_SYS_REG0             0x94
>> +
>> +struct regmap *regmap;
>> +int flag_reg;
>> +
>> +static int rockchip_get_pmu_regmap(void)
>> +{
>> +       struct device_node *node;
>> +
>> +       node = of_find_node_by_path("/cpus");
> Is it critical not to check node for NULL here?
    ok, I will add a check here
>
>> +       regmap = syscon_regmap_lookup_by_phandle(node, "rockchip,pmu");
>> +       of_node_put(node);
>> +       if (!IS_ERR(regmap))
>> +               return 0;
>> +
>> +       regmap = syscon_regmap_lookup_by_compatible("rockchip,rk3066-pmu");
>> +       of_node_put(node);
>> +       if (!IS_ERR(regmap))
>> +               return 0;
>> +
>> +       return -ENODEV;
>> +}
> This double of_node_put(node) confuses me. Could you please guide me over it?
>
> After I tried to re-create it by myself looking to code I think that
> second of_node_put() is not needed.

    the second of_node_put is not needed, it will be removed.
>> +static int rockchip_get_reboot_flag_regmap(void)
>> +{
>> +       int ret = rockchip_get_pmu_regmap();
>> +
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       if (of_machine_is_compatible("rockchip,rk3288")) {
>> +               flag_reg = RK3288_PMU_SYS_REG0;
>> +               return 0;
>> +       } else if (of_machine_is_compatible("rockchip,rk3066a") ||
>> +                  of_machine_is_compatible("rockchip,rk3066b") ||
>> +                  of_machine_is_compatible("rockchip,rk3188")) {
>> +               flag_reg = RK3188_PMU_SYS_REG0;
>> +               return 0;
>> +       }
>> +
>> +       return -ENODEV;
> [..]
>
>> +
>> +static int __init rockchip_reboot_init(void)
>> +{
>> +       int ret = 0;
>> +
>> +       if (!rockchip_get_reboot_flag_regmap()) {
>> +               ret = register_restart_handler(&rockchip_reboot_handler);
>> +               if (ret)
>> +                       pr_err("%s: cannot register reboot handler, %d\n",
>> +                              __func__, ret);
>> +       }
>> +
>> +return ret;
> Please align this correctly.
    OK, this will be aligned next version
>
> Thanks,
> Alexey Klimov
>
>
>
   Thanks for your review.
