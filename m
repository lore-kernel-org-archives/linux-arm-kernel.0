From: stigge@antcom.de (Roland Stigge)
Date: Fri, 14 Sep 2012 11:52:00 +0200
Subject: [GIT PULL] ARM: LPC32xx: core update
In-Reply-To: <201209131155.16756.arnd@arndb.de>
References: <50488FD6.4080402@antcom.de> <201209131155.16756.arnd@arndb.de>
Message-ID: <5052FE40.2030305@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 13/09/12 13:55, Arnd Bergmann wrote:
> On Thursday 06 September 2012, Roland Stigge wrote:
>>       ARM: LPC32xx: Provide DMA filter callbacks via platform data
> 
> This patch results in build errors in the for-next branch with lpc32xx_defconfig:
> 
> arch/arm/mach-lpc32xx/phy3250.c:40:35: fatal error: linux/mtd/lpc32xx_slc.h: No such file or directory
> arch/arm/mach-lpc32xx/phy3250.c:41:35: fatal error: linux/mtd/lpc32xx_mlc.h: No such file or directory
> arch/arm/mach-lpc32xx/phy3250.c:226:15: error: variable 'lpc32xx_slc_data' has initializer but incomplete type
> arch/arm/mach-lpc32xx/phy3250.c:227:2: error: unknown field 'dma_filter' specified in initializer
> arch/arm/mach-lpc32xx/phy3250.c:227:2: error: excess elements in struct initializer [-Werror]
> arch/arm/mach-lpc32xx/phy3250.c:227:2: error: (near initialization for 'lpc32xx_slc_data') [-Werror]
> arch/arm/mach-lpc32xx/phy3250.c:230:15: error: variable 'lpc32xx_mlc_data' has initializer but incomplete type
> arch/arm/mach-lpc32xx/phy3250.c:231:2: error: unknown field 'dma_filter' specified in initializer
> arch/arm/mach-lpc32xx/phy3250.c:231:2: error: excess elements in struct initializer [-Werror]
> arch/arm/mach-lpc32xx/phy3250.c:231:2: error: (near initialization for 'lpc32xx_mlc_data') [-Werror]
> 
> It seems that we're missing a dependency. Which tree did the patch to add
> these go through? Can we add that to the same branch in arm-soc?

Right - there is a dependency on l2-mtd.git here.

Since they didn't request pull for 3.6, there is quite some stuff
pending in their tree (but I wonder why it isn't already part of
linux-next, so the above error at least shouldn't occur in linux-next).

So we have several alternative options here:

* If it is possible, include l2-mtd.git as a dependency in arm-soc.git
* Merge the following 2 patches as minimal dependency:
http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commitdiff/c47bc5c84a65c31f41a555706363f9e350ca6338
http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commitdiff/f5e87dd7350c98a34aa7041264c337f0f33c02ff
You actually only need the two .h files, ignore the patches for yet
non-existing .c mtd driver files in arm-soc.git.
* Defer the above (single) patch in arm-soc until l2-mtd is merged
linux-next or mainline. Maybe l2-mtd.git will appear in linux-next soon,
otherwise we will need to defer the above patch for lpc32xx/core for 3.8?

Sorry for the confusion,

Roland
