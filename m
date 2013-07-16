From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Tue, 16 Jul 2013 20:13:09 +0200
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC
 with ARM CPU
In-Reply-To: <51E56942.8030801@hauke-m.de>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716151435.GB3871@linaro.org> <51E56942.8030801@hauke-m.de>
Message-ID: <51E58D35.4060602@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2013 05:39 PM, Hauke Mehrtens wrote:
> On 07/16/2013 05:14 PM, Matt Porter wrote:
>> Hi Hauke,
>>
>> On Tue, Jul 16, 2013 at 03:52:07PM +0200, Hauke Mehrtens wrote:
>>> This patch adds support for the BCM5301/BCM470X SoCs with an ARM CPU.
>>> Currently just booting to a shell is working and nothing else, no
>>> Ethernet, wifi, flash, ...
>>>
>>> This SoC uses a Dual core CPU, but this is currently not implemented.
>>> More information about this SoC can be found here:
>>> http://www.anandtech.com/show/5925/broadcom-announces-bcm4708x-and-bcm5301x-socs-for-80211ac-routers
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>> ---

....

>>> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
>>> new file mode 100644
>>> index 0000000..638350d
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
>>> @@ -0,0 +1,72 @@
>>> +/*
>>> + * Broadcom BCM47XX / BCM53XX ARM platform code.
>>> + *
>>> + * Copyright 2013 Hauke Mehrtens <hauke@hauke-m.de>
>>> + *
>>> + * Licensed under the GNU/GPL. See COPYING for details.
>>> + */
>>> +
>>> +/include/ "skeleton.dtsi"
>>> +
>>> +/ {
>>> +	compatible = "brcm,bcm5301x";
>>
>> Ok, this was nagging at me before I went on my very long vacation. I see
>> the "brcm" vendor prefix as a real consistency problem. I noticed on the
>> bcm281xx/kona family, we have been using "bcm" which is not logged in
>> vendor-prefixes.txt as a legitimate prefix. I see that bcm2835 had
>> already established use of "brcm" before any of the bcm281xx support
>> came in. Ideally, the vendor prefix should change to "bcm" since every
>> reference in the family names is BCM. However, if others want the least
>> amount of churn in making this consistent, we might have to go with
>> "brcm" across the board.
>>
>> Arnd, any thoughts here?
> 
> I have no problem with bcm or with brcm. This is a Broadcom Chip and
> their names are starting with bcm.
> 
>> Another thing is that this is missing a binding definition for this
>> compatible string. See Documentation/devicetree/bindings/arm/bcm2835.txt
>> for an example. You should split this patch out separately as the DT
>> maintainers generally want to see bindings as a separate patch for easy
>> independent review.
> 
> Ok I will do that. This will then be merged by Linus in the 3.12 merge
> window into a working version or how does this work?
> 
> Currently I have based this patch on top of 3.11-rc1 on which tree
> should I base my changes?

Should I split out the *.dts files in arch/arm/boot/dts/ and the
documentation for brcm,bcm4708 into an other patch?

>> Last thing, compatible strings are not to have wildcards in them. See
>> http://devicetree.org/Device_Tree_Usage#Understanding_the_compatible_Property
>> and note the Warning at the bottom. Also see how bcm2835.txt and
>> bcm11351.txt use a specific model.
> 
> Ok will do that.

Do I understand this right that I should currently name it exactly like
the SoC I know and when a new SoC pops up I should make it compatible to
this SoC?

I would change this to:
compatible = "brcm,bcm4708";

If I find a BCM4709 SoC I will add this like to its dts file, assuming
they are mostly the same?
compatible = "brcm,bcm4709", "brcm,bcm4708";

> 
>>> +	model = "BCM5301X/BCM4707/BCM4708/BCM4709 SoC";
>>> +	interrupt-parent = <&gic>;
>>> +
>>> +	chosen {
>>> +		bootargs = "console=ttyS0,115200 earlyprintk debug";
>>> +	};
>>> +
>>> +	cpus {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		cpu at 0 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a9";
>>> +			reg = <0>;
>>> +		};
>>> +	};
>>> +
>>> +	clocks {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		clk_periph: periph {
>>> +			compatible = "fixed-clock";
>>> +			#clock-cells = <0>;
>>> +			clock-frequency = <400000000>;
>>> +		};
>>> +	};
>>> +
>>> +	uart at 18000300 {
>>> +		compatible = "ns16550";
>>> +		reg = <0x18000300 0x100>;
>>> +		interrupts = <0 85 4>;
>>
>> The DT files should be switched to use the C preprocessor like several
>> other machines have already done (see bcm11351.dtsi, for example), you
>> can use the existing GIC includes and have human-redable defines for the
>> edge/level values here and throughout all interrupt properties.
> 
> Ok I will read that and change it.
> 
>>> +		clock-frequency = <100000000>;
>>> +	};
>>> +
>>> +	uart at 18000400 {
>>> +		compatible = "ns16550";
>>> +		reg = <0x18000400 0x100>;
>>> +		interrupts = <0 85 4>;
>>> +		clock-frequency = <100000000>;
>>> +	};
>>> +
>>> +	gic: interrupt-controller at 19021000 {
>>> +		compatible = "arm,cortex-a9-gic";
>>> +		#interrupt-cells = <3>;
>>> +		#address-cells = <0>;
>>> +		interrupt-controller;
>>> +		reg = <0x19021000 0x1000>,
>>> +		      <0x19020100 0x100>;
>>> +	};
>>> +
>>> +	timer at 19020200 {
>>> +		compatible = "arm,cortex-a9-global-timer";
>>> +		reg = <0x19020200 0x100>;
>>> +		interrupts = <1 11 0xf04>;
>>> +		clocks = <&clk_periph>;
>>> +		#clock-cells = <0>;
>>> +	};
>>> +};
>>> diff --git a/arch/arm/include/debug/bcm53xx.S b/arch/arm/include/debug/bcm53xx.S
>>> new file mode 100644
>>> index 0000000..98c836b
>>> --- /dev/null
>>> +++ b/arch/arm/include/debug/bcm53xx.S
>>> @@ -0,0 +1,19 @@
>>> +/*
>>> + * Macros used for EARLY_PRINTK, in low-level UART debug console
>>> + *
>>> + * Copyright 2013 Hauke Mehrtens <hauke@hauke-m.de>
>>> + *
>>> + * Licensed under the GNU/GPL. See COPYING for details.
>>> + */
>>> +
>>> +#define BCM53XX_UART1_PHYS	0x18000300
>>> +#define BCM53XX_UART1_VIRT	0xf1000300
>>> +#define BCM53XX_UART1_SH	0
>>> +
>>> +	.macro	addruart, rp, rv, tmp
>>> +	ldr	\rp, =BCM53XX_UART1_PHYS 	@ MMU off, Physical
>>> +	ldr	\rv, =BCM53XX_UART1_VIRT 	@ MMU on, Virtual
>>> +	.endm
>>> +
>>> +#define UART_SHIFT	BCM53XX_UART1_SH
>>> +#include <asm/hardware/debug-8250.S>
>>> diff --git a/arch/arm/mach-bcm53xx/Kconfig b/arch/arm/mach-bcm53xx/Kconfig
>>> new file mode 100644
>>> index 0000000..1e16e87
>>> --- /dev/null
>>> +++ b/arch/arm/mach-bcm53xx/Kconfig
>>> @@ -0,0 +1,10 @@
>>> +config ARCH_BCM53XX
>>> +	bool "Broadcom BCM47XX / BCM53XX ARM SoC"
>>> +	select CPU_V7
>>> +	select ARM_GIC
>>> +	select HAVE_CLK
>>> +	select GENERIC_CLOCKEVENTS
>>> +	select GENERIC_TIME
>>> +	select ARM_GLOBAL_TIMER
>>> +	help
>>> +	  Support for Broadcom BCM47XX and BCM53XX SoCs with ARM CPU cores.
>>> diff --git a/arch/arm/mach-bcm53xx/Makefile b/arch/arm/mach-bcm53xx/Makefile
>>> new file mode 100644
>>> index 0000000..88da84d
>>> --- /dev/null
>>> +++ b/arch/arm/mach-bcm53xx/Makefile
>>> @@ -0,0 +1 @@
>>> +obj-y += bcm53xx.o
>>> diff --git a/arch/arm/mach-bcm53xx/bcm53xx.c b/arch/arm/mach-bcm53xx/bcm53xx.c
>>> new file mode 100644
>>> index 0000000..aa5bd397
>>> --- /dev/null
>>> +++ b/arch/arm/mach-bcm53xx/bcm53xx.c
>>> @@ -0,0 +1,68 @@
>>> +/*
>>> + * Broadcom BCM47XX / BCM53XX ARM platform code.
>>> + *
>>> + * Copyright 2013 Hauke Mehrtens <hauke@hauke-m.de>
>>> + *
>>> + * Licensed under the GNU/GPL. See COPYING for details.
>>> + */
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/irqchip.h>
>>> +#include <linux/clocksource.h>
>>> +#include <linux/clk-provider.h>
>>> +
>>> +#include <asm/mach/arch.h>
>>> +#include <asm/mach/map.h>
>>> +#include <asm/signal.h>
>>> +
>>> +static int bcm53xx_abort_handler(unsigned long addr, unsigned int fsr,
>>> +				 struct pt_regs *regs)
>>> +{
>>> +	/*
>>> +	 * These happen for no good reason
>>> +	 * possibly left over from CFE
>>> +	 */
>>> +	pr_warn("External imprecise Data abort at addr=%#lx, fsr=%#x ignored.\n",
>>> +		addr, fsr);
>>> +
>>> +	/* Returning non-zero causes fault display and panic */
>>> +	return 0;
>>> +}
>>> +
>>> +static void bcm53xx_aborts_enable(void)
>>> +{
>>> +	/* Install our hook */
>>> +	hook_fault_code(16 + 6, bcm53xx_abort_handler, SIGBUS, 0,
>>> +			"imprecise external abort");
>>> +}
>>> +
>>> +static void __init bcm53xx_timer_init(void)
>>> +{
>>> +	of_clk_init(NULL);
>>> +	clocksource_of_init();
>>> +}
>>> +
>>> +void __init bcm53xx_map_io(void)
>>> +{
>>> +	debug_ll_io_init();
>>> +	bcm53xx_aborts_enable();
>>> +}
>>> +
>>> +static void __init bcm53xx_dt_init(void)
>>> +{
>>> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>> +}
>>> +
>>> +static const char const *bcm53xx_dt_compat[] = {
>>> +	"brcm,bcm5301x",
>>> +	"netgear,r6250v1",
>>> +	NULL,
>>> +};
>>> +
>>> +DT_MACHINE_START(BCM53XX, "BCM53XX")
>>> +	.init_machine = bcm53xx_dt_init,
>>> +	.map_io = bcm53xx_map_io,
>>> +	.init_irq = irqchip_init,
>>> +	.init_time = bcm53xx_timer_init,
>>> +	.dt_compat = bcm53xx_dt_compat,
>>> +MACHINE_END
>>> -- 
>>> 1.7.10.4
>>>
> 
