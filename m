From: edubezval@gmail.com (Eduardo Valentin)
Date: Wed, 16 Nov 2016 18:21:56 -0800
Subject: [PATCH V8 0/6] thermal: bcm2835: add thermal driver
In-Reply-To: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <20161117022154.GA3184@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
On Wed, Nov 02, 2016 at 10:18:20AM +0000, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add a thermal driver for the TSENSE device of the bcm2835/6/7 SOC.
> 
> If the firmware enables the HW, then the configuration is not touched.
> In case the firmware has not enabled the device, then we try to set
> it up correctly (which unfortunately can not get tested).
> 
> It exposes temperature and a critical trip point
> (using a hardcoded default of 80C or the temperature configured
> in the control register by the firmware, which reads as
> 407C currently)
> 
> The calibrations are (potentially) different for bcm2835, bcm2836
> and bcm2837 and can get selected by the compatible property
> in the device tree.
> 
> The driver also exposes the registers via debugfs.
> 
> Possible future enhancements:
> * the device has the ability to trigger interrupts on reaching
>   the programmed critical temperature.
>   I have no knowledge which interrupt could be responsible
>   for this on the ARM side, so if we get to know which irq
>   it is we can implement that.
>   Instead the driver right now implements polling in 1 second intervals
> * the device can also reset the HW after the trip point
>   has been reached (also with some delay, so that corrective
>   actions can get taken) - this is currently not enabled by the
>   firmware, but could.
> * we could define more trip points for THERMAL_TRIP_HOT
> * make the trip point limits modifiable (ops.set_trip_temp)
> 
> Note:
>   No support for 32-bit arm bcm2837, as there is no
>   arch/arm/boot/dts/bcm2836.dtsi upstream as of now.
>   64-bit arm support is not tested
> 
> Changelog:
>  V1 -> V2: renamed dt-binding documentation file
>        	   added specific settings depending on compatible
> 	   added trip point based on register
> 	   setting up ctrl-register if HW is not enabled by firmware
> 	     as per recommendation of Eric (untested)
> 	   check that clock frequency is in range
> 	     (1.9 - 5MHz - as per comment in clk-bcm2835.c)
>  	   added driver to multi_v7_defconfig
>  V2 -> V3: made a module in multi_v7_defconfig
>            fixed typo in dt-binding document
>  V3 -> V4: moved driver back to thermal (not using bcm sub-directory)
>        	   set polling interval to 1second (was 0ms, so interrupt driven)
>  V4 -> V5: use correct compatiblity for different soc versions in dt
>        	   support ARM64 for bcm2837 in devicetree and defconfig
>  V5 -> V6: incorporated changes recommended by Stefan Wahren
>  V6 -> V7: removed depends on ARCH_BCM2836 || ARCH_BCM2837 in Kconfig
>  V7 -> V8: rebased
> 

Despite the minor questions on patch 2, specially on the request to use
existing slope and offset properties, I am ok with the other DT changes.
