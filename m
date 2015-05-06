From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 06 May 2015 21:05:36 +0200
Subject: BCM2836 (Raspberry Pi 2) port
In-Reply-To: <87a8xh1qve.fsf@eliezer.anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <5540443C.8070604@wwwdotorg.org> <87a8xh1qve.fsf@eliezer.anholt.net>
Message-ID: <2558204.3mfpuqFHUt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 May 2015 11:51:33 Eric Anholt wrote:
> 2836 SMP is now booting on my branch.  Big thanks to Andrea Merello for
> doing most of the work on it.  Not-cleaned-up series is available at:
> 
> https://github.com/anholt/linux/tree/bcm2836-smp
> 
> There's a bunch of stuff in here I'm not sure about:
> 
> How do we like the way I'm inheriting 2835 stuff with the includes now?
> (It's been a lot less merging work than my initial post had been, but
> the /delete-node/ lines for 2386's changes are gross).

It's probably better to rename the original dtsi file to bcm283x.dtsi
then and move the parts that are different into bcm2835.dts and bcm2836.dtsi.

> How do people feel about putting the 2386 local IRQ handling in the 2835
> irqchip code?  Do we like the code sharing for GPU IRQs, or would we
> rather have a separate driver?  Could we separate the 2836 local irqs
> From 2835, and have it just call into 2835 for GPU IRQ handling?

I haven't looked in too much detail, but unless the file grows too
large, having all the code in one file is probably best. I'm guessing
that most users will want to enable both at the same time anyway.
 
> Where do people think the arch timer frequency initialization should go
> (commit "ARM: BCM2835: Set up the local timer frequency on 2836.")?  On
> 2709 it's in init_time(), but I hear we've been trying to move away from
> these hooks.

My first intuition would be to have the clk driver handle setting up
the registers, as long as the arch_timer_of_init() requests the clock
correctly, that should do the right thing.

> Is there a sensible way to share our mapping of the local regs between
> the driver and platform bits that need to access them?  (see
> arch/arm/mach-bcm/bcm2836_platsmp.c for what we're doing currently)

What is the split between those registers? If you have multiple drivers
that all want just a few registers from one shared area, a "syscon"
node would work best.

If the registers are all owned by a single driver, but you need to access
a few of the registers during early boot, it may be better to do an
ad-hoc mapping in the smp code by finding the device node manually.

	Arnd
