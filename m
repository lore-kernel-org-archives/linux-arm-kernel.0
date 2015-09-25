From: slash.tmp@free.fr (Mason)
Date: Fri, 25 Sep 2015 15:35:36 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <2210529.vnGEGUl8Dr@wuerfel>
References: <56001B78.2090001@free.fr> <144297172.JfjI0hNJ9J@wuerfel>
 <560546D8.1010407@free.fr> <2210529.vnGEGUl8Dr@wuerfel>
Message-ID: <56054DA8.4050903@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/2015 15:17, Arnd Bergmann wrote:
> On Friday 25 September 2015 15:06:32 Mason wrote:
>> On 22/09/2015 16:51, Arnd Bergmann wrote:
>>
>>> Move this to the platform Kconfig file. Also, drop all the
>>> 'select' statements that are implied by ARCH_MULTIPLATFORM
>>> and ARCH_MULTI_V7
>>
>> I've trimmed my platform Kconfig down to:
>>
>> config ARCH_TANGO4
>>         bool "Sigma Designs Tango4 (SMP87xx)"
>>         default y
> 
> drop the default
> 
> add
> 	depends on CPU_MULTI_V7

I've done this higher up.

menuconfig ARCH_TANGOX
	bool "Sigma Designs Tango" if ARCH_MULTI_V7
	help
	  something useful

if ARCH_TANGOX
config ARCH_TANGO4
...
endif

So 'default y' enables ARCH_TANGO4 only if ARCH_TANGOX is selected,
right?

>>         select ARCH_HAS_HOLES_MEMORYMODEL
>>         select ARM_ERRATA_754322
>>         select ARM_ERRATA_764369
> 
> 	add 'if SMP'
> 
>>         select ARM_GIC
>>         select CACHE_L2X0
> 
> remove CACHE_L2X0, we want to be able to turn this off.

Some people run with L2 disabled? That's a strange thing to do.

>>         select CLKSRC_MMIO
>>         select GENERIC_IRQ_CHIP
>>         select HAVE_ARM_SCU
>>         select HAVE_ARM_TWD
> 
> 	'if SMP'
> 
>>         select NEON
>>         select SMP
> 
> These should be user-selectable as well, so drop the 'select'
> and make sure the kernel builds with them turned off.

It will build, but it won't run! My port uses the TWD for clockevents,
and smp_twd.c is only compiled if HAVE_ARM_TWD. So I must set SMP.

>> Didn't find much documentation on ARCH_HAS_HOLES_MEMORYMODEL.
>> What is it used for?
> 
> You need this if the RAM is not physically contiguous, e.g. 256MB at one
> address and another 256MB somewhere else.
> 
>> Is it OK to select CACHE_L2X0, NEON, and SMP?
> 
> no

Then I have a major problem... my port requires SMP.

Regards.
