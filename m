From: b.brezillon@overkiz.com (boris brezillon)
Date: Fri, 15 Nov 2013 19:27:06 +0100
Subject: [PATCH 02/11] ARM: at91: switch 1arm to DT
In-Reply-To: <20131115174134.GA14627@ns203013.ovh.net>
References: <20131115143855.GR28304@ns203013.ovh.net>
 <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
 <1384527006-9040-2-git-send-email-plagnioj@jcrosoft.com>
 <5286477E.8060606@overkiz.com> <20131115174134.GA14627@ns203013.ovh.net>
Message-ID: <5286677A.8020104@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/2013 18:41, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:10 Fri 15 Nov     , boris brezillon wrote:
>> On 15/11/2013 15:49, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>>> ---
>>>   arch/arm/boot/dts/Makefile            |  1 +
>>>   arch/arm/boot/dts/at91-1arm.dts       | 70 +++++++++++++++++++++++++
>>>   arch/arm/configs/at91rm9200_defconfig |  1 -
>>>   arch/arm/mach-at91/Kconfig.non_dt     |  6 ---
>>>   arch/arm/mach-at91/Makefile           |  1 -
>>>   arch/arm/mach-at91/board-1arm.c       | 99 -----------------------------------
>>>   6 files changed, 71 insertions(+), 107 deletions(-)
>>>   create mode 100644 arch/arm/boot/dts/at91-1arm.dts
>>>   delete mode 100644 arch/arm/mach-at91/board-1arm.c
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index 802720e..f1fb6d7 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -3,6 +3,7 @@ ifeq ($(CONFIG_OF),y)
>>>   # Keep at91 dtb files sorted alphabetically for each SoC
>>>   # rm9200
>>>   dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
>>> +dtb-$(CONFIG_ARCH_AT91) += at91-1arm.dtb
>>>   dtb-$(CONFIG_ARCH_AT91) += mpa1600.dtb
>>>   # sam9260
>>>   dtb-$(CONFIG_ARCH_AT91) += animeo_ip.dtb
>>> diff --git a/arch/arm/boot/dts/at91-1arm.dts b/arch/arm/boot/dts/at91-1arm.dts
>>> new file mode 100644
>>> index 0000000..39b0c56
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/at91-1arm.dts
>>> @@ -0,0 +1,70 @@
>>> +/*
>>> + * at91-1arm.dts - Device Tree file for Ajeco 1ARM single board computer
>>> + *
>>> + * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>> + *
>>> + * Licensed under GPLv2 only
>>> + */
>>> +/dts-v1/;
>>> +#include "at91rm9200_pqfp.dtsi"
>>> +
>>> +/ {
>>> +	model = "Ajeco 1ARM single board computer";
>>> +	compatible = "ajeco,1arm", "atmel,at91rm9200-pqfp", "atmel,at91rm9200";
>>> +
>>> +	clocks {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		ranges;
>>> +
>>> +		main_clock: clock at 0 {
>>> +			compatible = "atmel,osc", "fixed-clock";
>>> +			clock-frequency = <18432000>;
>>> +		};
>>> +	};
>>> +
>>> +	ahb {
>>> +		apb {
>>> +			dbgu: serial at fffff200 {
>>> +				status = "okay";
>>> +			};
>>> +
>>> +			usart0: serial at fffc0000 {
>>> +				pinctrl-0 =
>>> +						<&pinctrl_uart0
>>> +						 &pinctrl_uart0_rts
>>> +						 &pinctrl_uart0_cts>;
>>> +
>>> +				status = "okay";
>>> +			};
>>> +
>>> +			usart1: serial at fffc4000 {
>>> +				pinctrl-0 =
>>> +						<&pinctrl_uart1
>>> +						 &pinctrl_uart1_rts
>>> +						 &pinctrl_uart1_cts
>>> +						 &pinctrl_uart1_dtr_dsr
>>> +						 &pinctrl_uart1_dcd
>>> +						 &pinctrl_uart1_ri>;
>>> +				status = "okay";
>>> +			};
>>> +
>>> +			macb0: ethernet at fffbc000 {
>>> +				phy-mode = "rmii";
>>> +				/* phy irq PC4 */
>>> +				status = "okay";
>>> +			};
>>
>> Could you add a phy node in macb0 node (see
>> https://lkml.org/lkml/2013/8/28/183) ?
>> In this node you can describe phy irq and even phy id (if it is hardcoded).
>>
>> The same goes for all rm9200 boards except rm9200ek (I already
>> posted a series for this one).
> I did not do this as this code was never tested on those board as the driver
> was not supporting it so as I can not test it I do not want to do it

How could this be a valid argument ?
I'm not telling that this should be mainlined without any tests, but 
IMHO dropping
new features because we don't have time to test it is not a good approach.

Moreover, the non-dt versions of these boards provide phy irq 
functionality and I think
we should at least provide the same level of functionality when 
migrating to dt.

I implemented the phy dt definition support for macb (and implicitely for
at91_ether) ethernet drivers, and I think this should be used for all 
new dt boards.

Anyway, this is not my decision, and let at91 maintainers (including 
you) decide wether
this should be dropped for this version.

Best Regards,

Boris

>
> Best Regards,
> J.
