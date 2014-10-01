From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 1 Oct 2014 07:24:19 -0300
Subject: [PATCH] nand: omap2: fix building with CONFIG_MTD_NAND_OMAP_BCH=m
In-Reply-To: <1943672.dOtqDNIvT0@wuerfel>
References: <1811108.CcWEs0vKNL@wuerfel> <542BCA19.8050603@ti.com>
 <1943672.dOtqDNIvT0@wuerfel>
Message-ID: <20141001102419.GA2085@arch.hh.imgtec.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01 Oct 11:56 AM, Arnd Bergmann wrote:
> On Wednesday 01 October 2014 12:32:09 Roger Quadros wrote:
> > 
> > With this patch NAND probe on DRA7xx fails like so
> > 
> > [    2.077313] omap-gpmc 50000000.gpmc: GPMC revision 6.0
> > [    2.083842] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xca
> > [    2.090524] nand: Micron MT29F2G16ABAEAWP
> > [    2.094728] nand: 256MiB, SLC, page size: 2048, OOB size: 64
> > [    2.100745] nand: using OMAP_ECC_BCH8_CODE_HW ECC scheme
> > [    2.109764] omap2-nand: probe of omap2-nand.0 failed with error -38
> > 
> > OMAP NAND driver is the only user of the ELM module and we want it
> > to be usable in all possible configurations when enabled.
> 
> I don't understand. Is the BCH driver optional or not?
> 
> The help text says:
> 
>           This config enables the ELM hardware engine, which can be used to
>           locate and correct errors when using BCH ECC scheme. This offloads
>           the cpu from doing ECC error searching and correction. However some
>           legacy OMAP families like OMAP2xxx, OMAP3xxx do not have ELM engine
>           so they should not enable this config symbol.
> 
> which adds more to the confusion. The help text sounds like everything should
> work even if ELM is disabled (which contradicts your finding above) but you
> must not enable the driver if you are on an older machine (which would
> break multiplatform builds).
> 
> > Let's pick either one of the below patches instead
> > 
> > http://article.gmane.org/gmane.linux.ports.arm.omap/118488
> 
> This doesn't let you have the BCH driver as a module, which seems
> wrong.
> 
> > http://article.gmane.org/gmane.linux.ports.arm.omap/118847
> 
> Looks good, although I think you can simplify this to
> 
> config MTD_NAND_OMAP_BCH_BUILD
> 	def_tristate MTD_NAND_OMAP2 && MTD_NAND_OMAP_BCH
> 
> which makes it 'm' if MTD_NAND_OMAP_BCH is set to m.
> 

Just to clarify, you are talking about this one being the correct one,
right?

http://article.gmane.org/gmane.linux.ports.arm.omap/118488
"[PATCH 3/3] mtd: nand: Force omap_elm to be built as a module if omap2_nand is a module"

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
