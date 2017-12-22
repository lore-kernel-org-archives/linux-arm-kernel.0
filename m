From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 22 Dec 2017 23:04:44 +0100
Subject: [PATCH v2 3/5] mtd: nand: replace pxa3xx_nand driver by its
 rework called marvell_nand
In-Reply-To: <87608ycwx5.fsf@belgarion.home>
References: <20171219132942.27433-1-miquel.raynal@free-electrons.com>
 <20171219132942.27433-4-miquel.raynal@free-electrons.com>
 <87608ycwx5.fsf@belgarion.home>
Message-ID: <20171222230444.2c952ea0@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Dec 2017 21:47:18 +0100
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Miquel Raynal <miquel.raynal@free-electrons.com> writes:
> 
> > Actually remove pxa3xx_nand.c to let marvell_nand.c be compiled instead.
> > Also change the defconfig files using it as well as some board files
> > depending on CONFIG_MTD_NAND_PXA3xx.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>  
> 
> Actually that approach doesn't quite suit me.
> I'm not convinced at all a new rewrite of the driver will be stable right out of
> the box as the old one is.
> 
> What I would propose instead is :
>  - keep both the new marvell nand driver and the old pxa3xx_nand driver
>  - switch pxa_defconfig to compile them both

Didn't notice you were suggesting to compile both, which doesn't work
because both drivers match the same devices, and only one of them
can actually claim the device (likely the first one to register to the
device model). So, to make it safe you need to have a

	depends on !MTD_NAND_PXA3xx

in your MTD_NAND_MARVELL entry, which means only one driver can be
compiled.

>  - continue testing (with my help)
> 
> Once I see the marvell_nand is working properly, we can remove pca3xx_nand in a
> second stage, keeping the pxa platform functional all along.
> 
> Would you agree to that path ?
> 
> As a side not, this patch should be split into 2 parts :
>  - one for arch/arm -> switch to the new driver
>  - one for drivers/mtd -> removal of the old driver
> 
> Cheers.
> 
> --
> Robert
