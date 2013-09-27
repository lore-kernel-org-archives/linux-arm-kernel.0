From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Sep 2013 23:44:01 +0200
Subject: [PATCH v2] ARM: new platform for Energy Micro's EFM32 Cortex-M3
 SoCs
In-Reply-To: <20130926094251.GK16106@pengutronix.de>
References: <1379447884-14025-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201309172245.25367.arnd@arndb.de> <20130926094251.GK16106@pengutronix.de>
Message-ID: <201309272344.01386.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 September 2013, Uwe Kleine-K?nig wrote:
> I made that work now and can prepare a patch. I had to drop "depends on
> !ARCH_MULTIPLATFORM" from XIP_KERNEL. That's because my machine only
> works with XIP_KERNEL as it only has 4 MiB of RAM.

Ok, cool. We might run into a few problems with 'make randconfig' and
'make allyesconfig' when it becomes possible to enable XIP_KERNEL then.
IIRC, there is no fundamental reason to disallow XIP_KERNEL with
ARCH_MULTIPLATFORM, but I added the dependency because it causes
build errors in combination with other options.

> Also note that for !MMU you need to specify the base address and size of
> your RAM (DRAM_BASE, DRAM_SIZE) and flash (FLASH_MEM_BASE, FLASH_SIZE).
> So the resulting image is hardly runnable on different machines. (I
> don't know off-hand why these are needed though, maybe this can be
> discussed away.)
> 
> So ARCH_MULTIPLATFORM is only good as it allows to simplify a few
> things, but the result isn't really multi-platform.

Yes, that's understood. We can probably remove the need to know the size
of flash and dram at compile time, but we definitely need to know the
location of the kernel in physical memory.

Of course, in a lot of platforms, you can't even have the same XIP kernel
across multiple boards, when they have RAM or NOR flash at a different
location, but in theory you could have two boards of different platforms
that both have RAM starting at 0 and run the same kernel. I don't think
anyone would want to run such a kernel in practice, but it shows that
multiplatform is really orthogonal to building MMU or NOMMU kernels.

A few questions from my side, out of curiosity:

* Do you need any other patches (unrelated to EFM32) to run NOMMU on a
recent kernel? When I last tried, I could not get any NOMMU build to work
at all.

* Do you think 4MB is now a strict lower bound for running a modern
kernel? It would be a good data point if we could show that any target
with less than that is by definition broken and could get removed
from the kernel. What is the size of your kernel and user space?

* What user space are you running? Anything that's easy to build
for testing? Should that run with a mach-virt kernel built for
ARMv7-A NOMMU?

* An ARMv7-M kernel cannot run on either ARMv4/v5 nor ARMv6/v7-A, right?
Do you prevent building such a kernel in Kconfig?

	Arnd
