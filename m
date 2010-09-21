From: gerg@snapgear.com (Greg Ungerer)
Date: Tue, 21 Sep 2010 20:38:29 +1000
Subject: [PATCH] arm: fix use of clock disable on idle for simple AT91
	devices
In-Reply-To: <20100920151511.GE32018@game.jcrosoft.org>
References: <201009080122.o881MCXi015409@goober.internal.moreton.com.au>
	<20100920081448.GC32018@game.jcrosoft.org>
	<20100920151511.GE32018@game.jcrosoft.org>
Message-ID: <4C988B25.6020501@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/10 01:15, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:14 Mon 20 Sep     , Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 11:22 Wed 08 Sep     , Greg Ungerer wrote:
>>>
>>> Not all types of AT91 device have the PMC hardware unit. Don't do a
>>> clock disable at idle on those family members that don't have it.
>>>
>>> Signed-off-by: Greg Ungerer<gerg@uclinux.org>
>>> ---
>>>   arch/arm/mach-at91/include/mach/system.h |    2 +-
>>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-at91/include/mach/system.h b/arch/arm/mach-at91/include/mach/system.h
>>> index c80e090..0bc497f 100644
>>> --- a/arch/arm/mach-at91/include/mach/system.h
>>> +++ b/arch/arm/mach-at91/include/mach/system.h
>>> @@ -28,7 +28,7 @@
>>>
>>>   static inline void arch_idle(void)
>>>   {
>>> -#ifndef CONFIG_DEBUG_KERNEL
>>> +#if defined(AT91_PMC)&&  !defined(CONFIG_DEBUG_KERNEL)
>> we can do this on at91x40 also
> cf PS Control Register
> p52 of the datasheet

Personally I see no problem with the old functionality (not using
the clock disable) for the AT91x40 devices. But then I don't run
on real hardware, only emulators.

A patch follows using the PS CPU clock disable bit. I think it
is more ugly than the first patch. Of course I can only test it
in an emulator (skyeye), works on that.

Regards
Greg
