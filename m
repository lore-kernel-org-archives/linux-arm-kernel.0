From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 2 Dec 2015 09:53:40 +0100
Subject: [PATCH v2 17/25] mtd: nand: remove useless mtd->priv = chip
 assignments
In-Reply-To: <20151201221747.GB64635@google.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
 <1448967802-25796-18-git-send-email-boris.brezillon@free-electrons.com>
 <20151201221747.GB64635@google.com>
Message-ID: <20151202095340.2f84e80f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Tue, 1 Dec 2015 14:17:47 -0800
Brian Norris <computersforpeace@gmail.com> wrote:

> On Tue, Dec 01, 2015 at 12:03:14PM +0100, Boris Brezillon wrote:
> > mtd_to_nand() now uses the container_of() approach to transform an
> > mtd_info pointer into a nand_chip one. Drop useless mtd->priv
> > assignments from NAND controller drivers.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> > Patch generated with the following coccinelle script:
> > 
> > ---8<----
> > virtual patch
> > 
> > @@
> > struct mtd_info m;
> > struct mtd_info *mp;
> > struct nand_chip *c;
> > @@
> > (
> > -(m).priv = c;
> > |
> > -(mp)->priv = c;
> > |
> > -(mp)->priv = (void *)c;
> > )
> > ---8<----
> > ---
> 
> ...
> 
> > diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
> > index 3f29734..ed4184c 100644
> > --- a/drivers/mtd/nand/s3c2410.c
> > +++ b/drivers/mtd/nand/s3c2410.c
> > @@ -834,7 +834,6 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
> >  	chip->IO_ADDR_R = chip->IO_ADDR_W;
> >  
> >  	nmtd->info	   = info;
> > -	mtd->priv	   = chip;
> 
> After this one, we have:
> 
> drivers/mtd/nand/s3c2410.c: In function ?s3c2410_nand_init_chip?:
> drivers/mtd/nand/s3c2410.c:791:19: warning: unused variable ?mtd? [-Wunused-variable]

I fixed all the warnings/errors you pointed in patch 12 and 17 and
resent a v3 only for those patches to avoid annoying all recipients
again. Let me know if you want me to resend the whole patchset.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
