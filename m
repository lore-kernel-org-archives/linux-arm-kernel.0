From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 26 Apr 2016 11:57:38 +0100
Subject: [PATCH 0/3] ARM: nommu: R-class fixes
In-Reply-To: <6943381.tLU1c7RclQ@wuerfel>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
 <55296515.n2D97kIgVc@wuerfel> <571F240A.9030404@arm.com>
 <6943381.tLU1c7RclQ@wuerfel>
Message-ID: <571F49A2.3000706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/16 10:10, Arnd Bergmann wrote:
> On Tuesday 26 April 2016 09:17:14 Vladimir Murzin wrote:
>> On 25/04/16 13:59, Arnd Bergmann wrote:
>>> On Monday 25 April 2016 08:55:57 Vladimir Murzin wrote:
>>>> On 23/04/16 07:54, Afzal Mohammed wrote:
>>>>> Hi,
>>>>>
>>>>> On Fri, Apr 22, 2016 at 12:43:33PM +0100, Vladimir Murzin wrote:
>>>>>
>>>>>> Small set of fixes discovered with R-class cores.
>>>>>
>>>>> just curious, is Cortex-R supported on mainline ?, thought it was not
>>>>> supported, but subject & changelogs gave such a feeling.
>>>>
>>>> Hi,
>>>>
>>>> I believe it is supported since c90ad5c "ARM: add Cortex-R7 Processor
>>>> Info" although overtime it got blocked (at least for Vexpress) with
>>>> Kconfig changes. There was attempt [1] to sort it out, but looks like
>>>> these patches went nowhere, so I'm trying to re-start with the fixes
>>>> coming first.
>>>>
>>>> [1]
>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/174256.html
>>>
>>> Good to know, thanks for working on this!
>>
>> Since you are in a thread, just want to confirm if the following is
>> still the right (only?) way how we want to support R-class?
>>
>> -----8<-------
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index a7f066e..ead2b25 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -289,8 +289,7 @@ choice
>>
>>   config ARCH_MULTIPLATFORM
>>          bool "Allow multiple platforms to be selected"
>> -       depends on MMU
>> -       select ARM_PATCH_PHYS_VIRT
>> +       select ARM_PATCH_PHYS_VIRT if MMU
>>          select AUTO_ZRELADDR
>>          select COMMON_CLK
>>          select MULTI_IRQ_HANDLER
>> ----->8--------
>>
>> I have separate Kconfig entry to represent R-class Vexpress platform
>> locally, but I guess it is noway, right? ;)
> 
> I think we should discuss this first. It's not necessarily wrong

I'm open ;)

> or right, but I have taken a slightly different approach in my
> randconfig test tree:
> 

I'll play with this, thanks!

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 107d2868706c..8745f84932af 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -314,9 +314,11 @@ source "kernel/Kconfig.freezer"
>  
>  menu "System Type"
>  
> +config NOMMU
> +	bool
> +
>  config MMU
> -	bool "MMU-based Paged Memory Management Support"
> -	default y
> +	def_bool !NOMMU
>  	help
>  	  Select if you want MMU-based virtualised addressing space
>  	  support by paged memory management. If unsure, say 'Y'.
> @@ -335,12 +337,10 @@ config ARCH_MMAP_RND_BITS_MAX
>  #
>  choice
>  	prompt "ARM system type"
> -	default ARM_SINGLE_ARMV7M if !MMU
> -	default ARCH_MULTIPLATFORM if MMU
> +	default ARCH_MULTIPLATFORM
>  
>  config ARCH_MULTIPLATFORM
>  	bool "Allow multiple platforms to be selected"
> -	depends on MMU
>  	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select ARM_HAS_SG_CHAIN
>  	select ARM_PATCH_PHYS_VIRT
> @@ -355,7 +355,6 @@ config ARCH_MULTIPLATFORM
>  
>  config ARM_SINGLE_ARMV7M
>  	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
> -	depends on !MMU
>  	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select ARM_NVIC
>  	select AUTO_ZRELADDR
> @@ -364,6 +363,7 @@ config ARM_SINGLE_ARMV7M
>  	select CPU_V7M
>  	select GENERIC_CLOCKEVENTS
>  	select NO_IOPORT_MAP
> +	select NOMMU
>  	select SPARSE_IRQ
>  	select USE_OF
>  
> @@ -434,7 +434,6 @@ config ARCH_NETX
>  
>  config ARCH_IOP13XX
>  	bool "IOP13xx-based"
> -	depends on MMU
>  	select CPU_XSC3
>  	select NEED_MACH_MEMORY_H
>  	select NEED_RET_TO_USER
> @@ -447,7 +446,6 @@ config ARCH_IOP13XX
>  
>  config ARCH_IOP32X
>  	bool "IOP32x-based"
> -	depends on MMU
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CPU_XSCALE
>  	select GPIO_IOP
> @@ -460,7 +458,6 @@ config ARCH_IOP32X
>  
>  config ARCH_IOP33X
>  	bool "IOP33x-based"
> -	depends on MMU
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CPU_XSCALE
>  	select GPIO_IOP
> @@ -472,7 +469,6 @@ config ARCH_IOP33X
>  
>  config ARCH_IXP4XX
>  	bool "IXP4xx-based"
> -	depends on MMU
>  	select ARCH_HAS_DMA_SET_COHERENT_MASK
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARCH_SUPPORTS_BIG_ENDIAN
> @@ -531,7 +527,6 @@ config ARCH_LPC32XX
>  
>  config ARCH_PXA
>  	bool "PXA2xx/PXA3xx-based"
> -	depends on MMU
>  	select ARCH_MTD_XIP
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_CPU_SUSPEND if PM
> @@ -554,7 +549,6 @@ config ARCH_PXA
>  
>  config ARCH_RPC
>  	bool "RiscPC"
> -	depends on MMU
>  	select ARCH_ACORN
>  	select ARCH_MAY_HAVE_PC_FDC
>  	select ARCH_SPARSEMEM_ENABLE
> @@ -629,7 +623,6 @@ config ARCH_DAVINCI
>  
>  config ARCH_OMAP1
>  	bool "TI OMAP1"
> -	depends on MMU
>  	select ARCH_HAS_HOLES_MEMORYMODEL
>  	select ARCH_OMAP
>  	select ARCH_REQUIRE_GPIOLIB
> 
> The main question here is how explicit we want to make the selection
> of MMU support per platform. Today, CONFIG_MMU is a top-level option
> that decides which platforms are visible, based on whether they can
> work with or without an MMU or both.
> 
> This works fine, but means we probably have to add a lot of 'depends
> on MMU' with your patch to all the platforms that we want to only build
> with MMU enabled for some reason.

I've just checked my local branch and it seems not much "depend on"
(although I'm not dare to claim randconfig stays happy with that), but
some noMMU stubs and a few Kconfig changes across platform.

> 
> Turning it around would limit the platforms to the ones that
> explictly turn on NOMMU support. In order to make ARMv7-R support
> work, we need either another top-level platform option next to
> ARCH_MULTIPLATFORM and ARM_SINGLE_ARMV7M, or add ARMv7-R in
> the CPU selection phase as an alternative to ARMv4/5 and ARMv6/7-A.
> 

It depends if we what NOMMU represented (apart from M-class) R-class
only or R-class + A-class without MMU.

>>> What hardware platform do you use? It would be nice to make it a little
>>> more explicit which platforms can use the ARMv7-R, or an ARMv7-A with
>>> the MMU disabled.
>>
>> Currently I'm dealing mostly with ARMv7-R FVP models which represents
>> Vexpress with R-class tile (it is why this mini series have MPU
>> patches). I've never tried ARMv7-A with the MMU disabled and I'm quite
>> in doubt if it is feasible.
> 
> What is the difference? I always assumed that ARMv7-R and ARMv7-A are
> sufficiently close that you can run the same kernel on both as long
> as you use neither the MMU nor the MPU.

Right they are quite close and shares a lot of code except MMU and MPU,
and I'd think without MMU/MPU such configurations are limited with UP
only. I've not though of such option before, so I'd need to try and see.

On the other hand assumption that NOMMU == ARMv7-A - MMU, makes me think
that any ARMv7 platform should be available for selection if CONFIG_MMU
is deselected. At least such approach gives better build coverage and if
there are platforms which suffer from such assumption runtime they can
be guarded with COMPILE_TEST.

> The other question here is the usefulness of doing it. I think it would
> be mainly used for testing, as real Cortex-R type CPUs are rather rare,
> but a lot of people have cheap ARMv7-A hardware that they can use for
> testing NOMMU kernels if they want to.

Yes, Cortex-R is extremely rare, it is why I've looked at another
alternative - reuse R-class features (MPU only at the moment) from the
feature-closest M-class - MPU got unlocked for M-class in the same way
as it's done for caches [1].

[1] http://www.spinics.net/lists/arm-kernel/msg498910.html

> 
> 	Arnd
> 
> 
