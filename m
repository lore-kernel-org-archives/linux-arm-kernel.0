From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 22 Dec 2017 22:10:32 +0100
Subject: [PATCH v2 3/5] mtd: nand: replace pxa3xx_nand driver by its
 rework called marvell_nand
In-Reply-To: <87608ycwx5.fsf@belgarion.home>
References: <20171219132942.27433-1-miquel.raynal@free-electrons.com>
 <20171219132942.27433-4-miquel.raynal@free-electrons.com>
 <87608ycwx5.fsf@belgarion.home>
Message-ID: <20171222221032.30f83cb5@bbrezillon>
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

I would not qualify the old driver as stable, given that we regularly
have bug reports, but I understand your point and kind of understand
your concerns about stability.

> 
> What I would propose instead is :
>  - keep both the new marvell nand driver and the old pxa3xx_nand driver
>  - switch pxa_defconfig to compile them both
>  - continue testing (with my help)
> 
> Once I see the marvell_nand is working properly, we can remove pca3xx_nand in a
> second stage, keeping the pxa platform functional all along.
> 
> Would you agree to that path ?

Hm, I tried this approach already (with Marvell's crypto engine) and it
doesn't quite solve the problem, just delay it a bit until someone
decides to remove the old driver. In my experience, people only start
testing the new driver when they're forced to do it (IOW, when the old
driver is removed and defconfigs are patched to use the new one). So
let's find a way to fix the remaining issues you have instead of
delaying the inevitable.
Note that Miquel has done a lot of testing on various Marvell boards
(mainly mvebu ones since we only have one pxa board). Of course he
couldn't test all possible combinations of NFC <-> NAND, but I'm
quite confident the remaining issues can be fixed quickly with your
help.

> 
> As a side not, this patch should be split into 2 parts :
>  - one for arch/arm -> switch to the new driver
>  - one for drivers/mtd -> removal of the old driver

I agree on that part.

> 
> Cheers.
> 
> --
> Robert
