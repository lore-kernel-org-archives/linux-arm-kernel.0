From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 May 2013 09:57:11 +0100
Subject: [PATCH] ARM: mach-moxart: platform port for MOXA ART SoC
In-Reply-To: <201305160054.21064.arnd@arndb.de>
References: <CACmBeS1NLFUYHBOVL28aCCzRrgXYGPZF9t3qj6AdcgaMkrPGoQ@mail.gmail.com>
 <201305151516.52389.arnd@arndb.de>
 <20130515133237.GK18614@n2100.arm.linux.org.uk>
 <201305160054.21064.arnd@arndb.de>
Message-ID: <20130516085711.GP18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 12:54:20AM +0200, Arnd Bergmann wrote:
> Ah, I see. I also read the mach-gemini version of the idle code,
> which is apparently the same thing as the code that was commented
> out here, so that has the wakeup race.
> 
> Since it seems that WFI is broken on all fa526 cores, or at least
> all the ones we want to support in Linux, maybe it's better to
> not call WFI at all there?

Well, if its a CPU core thing, then it's even easier - the proc-*.S
file can handle it just fine (because that's where the WFI code is.)
Just delete the contents of the processor specific idle function, IOW:

/*
 * cpu_fa526_do_idle()
 */
        .align  4
ENTRY(cpu_fa526_do_idle)
        mcr     p15, 0, r0, c7, c0, 4           @ Wait for interrupt
        mov     pc, lr

remove the WFI from there.
