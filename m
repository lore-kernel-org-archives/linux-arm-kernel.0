From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 May 2012 08:54:18 +0000
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <201205051317.40357.arnd@arndb.de>
References: <201205031350.35476.arnd@arndb.de>
 <20120505080936.GP4141@pengutronix.de> <201205051317.40357.arnd@arndb.de>
Message-ID: <201205140854.18335.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 05 May 2012, Arnd Bergmann wrote:

> From the statements made so far, I can see no clear policy that we can
> apply to everyone. My take on this is that for any work I spend on
> multiplatform kernel, I concentrate on the DT-based board files and
> get them to work together first, but leave it up to the individual
> subarch maintainers whether they want to add other board files into
> the mix.

A small update that I already posted as a comment in the lwn article
covering this discussion:

| Over the last week, I've actually tried out building kernels for
| multiple platforms combined to get a better feeling for the remaining
| problems. The result is in the testing/multiplatform branch of
| git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git and it
| can build arbitrary combinations of four of the five subarchitectures
| that the Linaro organization is most interested in (imx, omap, ux500 and
| vexpress, but not exynos for now). Most other platforms should actually
| be simpler to convert.
| 
| However, this kernel is not yet going to be useful on real hardware
| because I had to disable or add hacks for a number of features (SMP,
| sparseirq, clocks) that are still being worked on, but as soon as one
| oatform has all that work done, we can actually build a kernel with
| everything enabled and run on that particular platform and see what
| else breaks.
|
| Unlike I suggested earlier, this kernel at the moment actually allows
| enabling all the board files including non-DT ones because that was
| easier to do with the Kconfig dependencies, but I found two real technical
| issues that would be solved by making the combined kernel DT-only:
|
| 1. The exynos platform defines static platform devices from files
| shared with five other Samsung platforms that are mutually exclusive
| because the device definitions depend on platform specific compile-time
| constants. Using DT probing we can just drop those static platform device
| definitions and make the conflict go away.
|
| 2. With sparse IRQs, a lot of the hardcoded interrupt numbers in static
| platform device definitions are broken, while the definitions from DT
| still work. Sparse IRQs are currently needed to build multiplatform
| kernels and I expect that requirement to stay.

	Arnd
