From: computersforpeace@gmail.com (Brian Norris)
Date: Sat, 23 Jan 2016 12:55:34 -0800
Subject: [PATCH v2 3/3] mtd: nand: sunxi: add randomizer support
In-Reply-To: <20160123091844.4826ffe6@bbrezillon>
References: <1449054067-16751-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449054067-16751-4-git-send-email-boris.brezillon@free-electrons.com>
 <20160123025713.GA90611@google.com>
 <20160123091844.4826ffe6@bbrezillon>
Message-ID: <20160123205534.GB35559@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 23, 2016 at 09:18:44AM +0100, Boris Brezillon wrote:
> On Fri, 22 Jan 2016 18:57:13 -0800
> Brian Norris <computersforpeace@gmail.com> wrote:
> > 
> > From: Brian Norris <computersforpeace@gmail.com>
> > Date: Fri, 22 Jan 2016 18:54:02 -0800
> > Subject: [PATCH] mtd: nand: sunxi: use mtd_div_by_ws() helper
> > 
> > Suggested-by: Richard Weinberger <richard@nod.at>
> > Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> 
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Applied.

> > ---
> >  drivers/mtd/nand/sunxi_nand.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> > index 5f700719d5c2..b5ea6b312df0 100644
> > --- a/drivers/mtd/nand/sunxi_nand.c
> > +++ b/drivers/mtd/nand/sunxi_nand.c
> > @@ -624,7 +624,7 @@ static u16 sunxi_nfc_randomizer_step(u16 state, int count)
> >  static u16 sunxi_nfc_randomizer_state(struct mtd_info *mtd, int page, bool ecc)
> >  {
> >  	const u16 *seeds = sunxi_nfc_randomizer_page_seeds;
> > -	int mod = mtd->erasesize / mtd->writesize;
> > +	int mod = mtd_div_by_ws(mtd->erasesize, mtd);
> 
> Just a comment (which should not prevent you from applying this patch).
> Isn't it a bit overkill to cast the erasesize to a 64 bit value, and
> then do a do_div on it. Shouldn't happen often though, because
> ->writesize_shift should be != 0 in most (all?) cases.

drivers/mtd/nand/ assumes power-of-2 dimensions for many things, so
probably.

> Another related remark: with the MLC/paired pages stuff I'll have to
> retrieve this information (number of write units per erase block) quite
> often, so maybe we should have a field (and/or an helper) for that.

Perhaps.

Brian
