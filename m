From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Oct 2011 16:57:32 +0200
Subject: Add support for the SPMP8000 SoC and Letcool board
In-Reply-To: <1318178172-7965-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
Message-ID: <201110111657.32545.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 October 2011, Zoltan Devai wrote:
> This series adds support for the Sunplus SPMP8000 SoC, an ARM926EJ-S based
> MCU, which is most commonly found in handheld game consoles and digital cams.
> Most of the work was done during GSoC 2011, with Greg KH as my mentor.
> 
> The board I'm using for development is the Letcool N350JP handheld.
> 
> The patches are based on Arnds for-next branch with Jamie Iles' vic-dt patches
> on top.
> 
> No static platform devices are used, everything is inited from DT, with some
> hacks for drivers that don't have any bindings yet.
> (Documentation for own, custom bindings will follow in next version.)
> 
> So far, these peripherals are supported, with drivers not submitted yet:
> gpio, fb, cpufreq, slave-dma, mmc, ASoC (i2s, codec, pcm, card).
> 
> Reviews, instructions for mainlining it are very welcome.

Hi Zoltan,

Looks basically ok, but there are the usual smaller things I found that
are worth improving. I like very much seeing an ARM926 port done in the
new style, especially since these tend to be much simpler than the
cortex-a9 platforms that most people are working on these days. This
gives us the chance to experiment with a complete port without having
to do heaps of new device tree bindings etc. It will also be valuable
to have this when working on single-zimage patches for ARMv5.

I would however prefer to leave the port for linux-3.3 at this point,
since we are close to the merge window and there are a lot of details
for you to work on still.
In particular, I would hope that by the time of the 3.3 merge window
we will have a proper common clockdev layer that can simplify a
significant portion of your code.

As Linus Walleij mentioned already, it would be good to move the
device drivers out of the platform directory into subsystems
below drivers/ and I hope that by 3.3 that also includes the pinmux,
clkdev, and timer drivers, possibly also pwm and adc.

My hope is that in the long run, a relatively simple platform like
this can become a single core.c file plus the optional debug_ll
support, after all the header files are consolidated and the drivers
are moved out. You won't have to wait for that though: If the code
looks ok, we can merge it in whatever the closest is we get to
the ideal at the time.

	Arnd
