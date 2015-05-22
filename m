From: stefan@agner.ch (Stefan Agner)
Date: Fri, 22 May 2015 10:54:48 +0200
Subject: [PATCH soc] ARM: use =?UTF-8?Q?ARM=5FSINGLE=5FARMV=37M=20for?=
 =?UTF-8?Q?=20ARMv=37-M=20platforms?=
In-Reply-To: <3824169.vxchxyBt3o@wuerfel>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>
 <3824169.vxchxyBt3o@wuerfel>
Message-ID: <170b7522fb120f3afcc4b7aa1f90e341@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-22 09:53, Arnd Bergmann wrote:
> On Thursday 21 May 2015 00:35:44 Stefan Agner wrote:
<snip>
>> +# ARMv7-M architecture
>> +config ARCH_EFM32
>> +	bool "Energy Micro efm32"
>> +	depends on ARM_SINGLE_ARMV7M
>> +	select ARCH_REQUIRE_GPIOLIB
>> +	help
>> +	  Support for Energy Micro's (now Silicon Labs) efm32 Giant Gecko
>> +	  processors.
>> +
>> +config ARCH_LPC18XX
>> +	bool "NXP LPC18xx/LPC43xx"
>> +	depends on ARM_SINGLE_ARMV7M
>> +	select ARCH_HAS_RESET_CONTROLLER
>> +	select ARM_AMBA
>> +	select CLKSRC_LPC32XX
>> +	select PINCTRL
>> +	help
>> +	  Support for NXP's LPC18xx Cortex-M3 and LPC43xx Cortex-M4
>> +	  high performance microcontrollers.
>> +
>> +config ARCH_STM32
>> +	bool "STMicrolectronics STM32"
>> +	depends on ARM_SINGLE_ARMV7M
>> +	select ARCH_HAS_RESET_CONTROLLER
>> +	select ARMV7M_SYSTICK
>> +	select RESET_CONTROLLER
>> +	help
>> +	  Support for STMicroelectronics STM32 processors.
>> +
> 
> Should we move those options into the respective subdirectories,
> for consistency with the other platforms?
> 
> The current top-level Kconfig file is much too large at the moment,
> so that would reduce the clutter a bit, but then again, all three
> of these currently don't need a Kconfig file for themselves, so
> that might be a bit silly as well.

But their machine folder is there anyway, so it wouldn't clutter
arch/arm/ more than it is today.

> Another option might be to consolidate these three into a single
> directory, if someone can come up with a good name. The machine
> files are all trivial, so they could even be merged into one as
> far as I can tell, we just need slightly different 'select'
> statements above.
> 
> If we do that, is it possible to merge Vybrid into that as well?
> I guess the main question here is how much other infrastructure
> (if any) from mach-imx is used on vf610, and if there is some other
> way to do that.

I think it is nice today to use the same Kconfig symbol (SOC_VF610) as
we use for the primary Cortex-A5 processor. After all, the kernel is
running on the same SoC... Its just a different processor we are running
on.

Today, I rely on several config symbols set by ARCH_MXC or SOC_VF610,
some of that quite SoC specific (PINCTRL_VF610). However, after the move
of the clock stuff which is in imx-next, there is really almost no
machine specific code required from mach-imx. However, I plan to add PM
support, which probably still will land in the machine folder?

I also think that it would a bit risky to do this for that release. So
maybe as first step, simply split out the machines in individual Kconfig
files?

What do you think about the defconfig dependency Uwe pointed out? Shall
I create a single patch on-top of a soc/defconfig merged branch?

--
Stefan
