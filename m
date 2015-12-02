From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 20:51:04 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151202192825.GF8644@n2100.arm.linux.org.uk>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <3059482.yN34NFeWWY@wuerfel> <20151202192825.GF8644@n2100.arm.linux.org.uk>
Message-ID: <4984219.tZoFdLBDNB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 19:28:25 Russell King - ARM Linux wrote:
> 
> As I said above, that's not the problem, the problem is merging it into
> the rest of my tree.
> 
> Having done most of that merge, I'm now tripping up on:
> 
> arch/arm/mach-dove/common.c: In function 'dove_wdt_init':
> arch/arm/mach-dove/common.c:538:2: error: implicit declaration of function 'orion_wdt_init' [-Werror=implicit-function-declaration]
> 
> which I guess is because you've deleted the legacy orion watchdog stuff.
> So I'm going to have to revert that.  That then gives me:
> 
> arch/arm/mach-dove/clock.c:19:21: fatal error: mach/pm.h: No such file or directory
> arch/arm/mach-dove/clock.c:20:27: fatal error: mach/hardware.h: No such file or directory
> 
> The first is easy to solve, and the second by replacing it with dove.h.
> The next problem is this:
> 
> arch/arm/plat-orion/common.c:25:30: fatal error: mach/bridge-regs.h: No such file or directory
> 
> which is impossible to solve, because plat-orion/common.c wants
> mach-dove/bridge-regs.h.

Ok, I can try to work around that, either by duplicating the device definition,
or passing the address into orion_wdt_init.

> I also have arch/arm/mach-dove/include/mach/sdhci.h to pass the GPIO
> for card detection to the SDHCI driver, which is going to break unless
> it's moved to include/linux/platform-data.

Right, a platform_data file seems the right approach there. Possibly just
passing the gpio number by casting it to a pointer, though that's a bit
ugly.

> Everything else seems mostly happy, but I've no way to tell whether
> what would be the resulting kernel would work as it's impossible to
> know without fixing the wreckage above.
> 
> I'm sure I don't have to repeat my position over what I'm going to do if
> these petty mainline changes which are totally unnecessary break the only
> setup I have which works.  Making mach-dove multi-platform is a "wouldn't
> it be nice if", it's not an absolute necessity.

I'm mostly interested in it because it's the only ARMv7 platform that is
left after my other patches, and I just want to be done with it after
spending 5 years on it ;-)

	Arnd
