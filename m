From: slash.tmp@free.fr (Mason)
Date: Fri, 25 Sep 2015 17:28:54 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <7559792.th4E1kM5gi@wuerfel>
References: <56001B78.2090001@free.fr> <2210529.vnGEGUl8Dr@wuerfel>
 <56054DA8.4050903@free.fr> <7559792.th4E1kM5gi@wuerfel>
Message-ID: <56056836.4060307@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/2015 16:11, Arnd Bergmann wrote:
> On Friday 25 September 2015 15:35:36 Mason wrote:
>> On 25/09/2015 15:17, Arnd Bergmann wrote:
>>> On Friday 25 September 2015 15:06:32 Mason wrote:
>>>
>>>> I've trimmed my platform Kconfig down to:
>>>>
>>>> config ARCH_TANGO4
>>>>         bool "Sigma Designs Tango4 (SMP87xx)"
>>>>         default y
>>>
>>> drop the default
>>>
>>> add
>>> 	depends on CPU_MULTI_V7
>>
>> I've done this higher up.
>>
>> menuconfig ARCH_TANGOX
>> 	bool "Sigma Designs Tango" if ARCH_MULTI_V7
>> 	help
>> 	  something useful
>>
>> if ARCH_TANGOX
>> config ARCH_TANGO4
>> ...
>> endif
>>
>> So 'default y' enables ARCH_TANGO4 only if ARCH_TANGOX is selected,
>> right?
> 
> You should really only have one of the two.

I plan to add ARCH_TANGO5 in a few weeks. So I copied the layout used
by Samsung for EXYNOSx and TI for OMAPx.

>>>>         select ARCH_HAS_HOLES_MEMORYMODEL
>>>>         select ARM_ERRATA_754322
>>>>         select ARM_ERRATA_764369
>>>
>>> 	add 'if SMP'
>>>
>>>>         select ARM_GIC
>>>>         select CACHE_L2X0
>>>
>>> remove CACHE_L2X0, we want to be able to turn this off.
>>
>> Some people run with L2 disabled? That's a strange thing to do.
> 
> I can help for testing. Most importantly, we currently allow that
> configuration today, and it's not up to you to forbid other platforms
> from doing it.

As far as I can tell, I'm running with L2 disabled anyway, since
Linux is running in non-secure mode, and I didn't provide the ABI
to talk to the secure OS.

> If you can prove that we never need to disable that option, send
> another patch to make it unconditional.

CACHE_L2X0 defaults to y. That's good enough for me.

>>>>         select CLKSRC_MMIO
>>>>         select GENERIC_IRQ_CHIP
>>>>         select HAVE_ARM_SCU
>>>>         select HAVE_ARM_TWD
>>>
>>> 	'if SMP'
>>>
>>>>         select NEON
>>>>         select SMP
>>>
>>> These should be user-selectable as well, so drop the 'select'
>>> and make sure the kernel builds with them turned off.

About NEON. I had 'select VFP' but I see that CPU_V7 enables VFPv3 and VFP.
Isn't NEON required to support user-space programs using NEON instructions?
arch/arm/kernel/entry-armv.S

>> It will build, but it won't run! My port uses the TWD for clockevents,
>> and smp_twd.c is only compiled if HAVE_ARM_TWD. So I must set SMP.
> 
> I think this has come up before and should be fixed. Could you
> send a patch that allows using TWD in uniprocessor configurations?

This was discussed here:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/389931/focus=15737

I can re-post the same patch.

Regards.
