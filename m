From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 May 2013 00:54:20 +0200
Subject: [PATCH] ARM: mach-moxart: platform port for MOXA ART SoC
In-Reply-To: <20130515133237.GK18614@n2100.arm.linux.org.uk>
References: <CACmBeS1NLFUYHBOVL28aCCzRrgXYGPZF9t3qj6AdcgaMkrPGoQ@mail.gmail.com>
 <201305151516.52389.arnd@arndb.de>
 <20130515133237.GK18614@n2100.arm.linux.org.uk>
Message-ID: <201305160054.21064.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 May 2013, Russell King - ARM Linux wrote:
> Actually, that's probably the whole point of this - to do nothing.
> This changes the behaviour of the idle loop from using the WFI to
> just spinning instead with no wait-for-interrupt or anything else.
> We just keep reading the need_resched flag.
> 
> That's much better than the commented out code which opens a mighty
> big race condition which will then give bad scheduling behaviour,
> allowing the idle task to sleep in WFI until the next interrupt while
> the need_resched flag may be set.
> 
> Sure, there's better ways to do this, via the disable_hlt() stuff,
> and whatever its replacement implementation is now called.  But
> ultimately this workaround really is about "doing nothing" when
> idle!

Ah, I see. I also read the mach-gemini version of the idle code,
which is apparently the same thing as the code that was commented
out here, so that has the wakeup race.

Since it seems that WFI is broken on all fa526 cores, or at least
all the ones we want to support in Linux, maybe it's better to
not call WFI at all there?

	Arnd
