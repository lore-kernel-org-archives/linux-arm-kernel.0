From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sat, 16 Jan 2010 23:35:16 +0200
Subject: Issue in oamp nand driver with 32-bit reads in prefetch mode
In-Reply-To: <ce9ab5791001102230j7923ef01j6f17b7ca9fafde56@mail.gmail.com>
References: <ce9ab5790912230133wae2c4dcw73051221b66cb40f@mail.gmail.com>
	<20091223174429.GD3512@atomide.com>
	<5e088bd90912291238t1f2aba64na94887b2f864454d@mail.gmail.com>
	<5e088bd90912291347j370ab30cid7c6cfc558c2ed18@mail.gmail.com>
	<ce9ab5790912310420h20beb04csba060b3f5cfeee92@mail.gmail.com>
	<1263113195.7315.129.camel@localhost.localdomain>
	<ce9ab5791001102230j7923ef01j6f17b7ca9fafde56@mail.gmail.com>
Message-ID: <1263677716.8276.130.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-01-11 at 12:00 +0530, Vimal Singh wrote:
> On Sun, Jan 10, 2010 at 2:16 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > On Thu, 2009-12-31 at 17:50 +0530, Vimal Singh wrote:
> >> There is a bug in nand prefetch read routine, which comes into effect
> >> only if nand device is a 16-bit device (as we have in zoom boards).
> >> This bug is effective only with below combination of conditions:
> >> 1. nand deivce, in use, is a 16 bit device
> >> 2. nand driver supports 'subpage' read
> >> 3. SW ECC is in use
> >>
> >> This was not seen old  kernel (ex: .23), because when, in early days,
> >> we tested this (nand prefetch read in LDP boards) there was no
> >> 'subpage read' support.
> >> Later when we had subpage read in (.27) kernel, we had hw ecc enabled
> >> always in our internal tree. So, we missed this bug.
> >>
> >> Here is a patch to fix this issue:
> >>
> >> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> >> index 1bb799f..75004fe 100644
> >> --- a/drivers/mtd/nand/omap2.c
> >> +++ b/drivers/mtd/nand/omap2.c
> >> @@ -295,11 +295,14 @@ static void omap_read_buf_pref(struct
> >>       u32 *p = (u32 *)buf;
> >>
> >>       /* take care of subpage reads */
> >> -     for (; len % 4 != 0; ) {
> >> -             *buf++ = __raw_readb(info->nand.IO_ADDR_R);
> >> -             len--;
> >> +     if (len % 4) {
> >> +             if (info->nand.options & NAND_BUSWIDTH_16)
> >> +                     omap_read_buf16(mtd, buf, len % 4);
> >> +             else
> >> +                     omap_read_buf8(mtd, buf, len % 4);
> >> +             p = (u32 *) (buf + len % 4);
> >> +             len -= len % 4;
> >>       }
> >> -     p = (u32 *) buf;
> >>
> >>       /* configure and start prefetch transfer */
> >>       ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
> >
> > Pushed this patch to my l2-mtd-2.6.git/dunno.
> >
> 
> I have posted this patch formally in patch series:
> [PATCH 0/3][NAND][OMAP]: fixing omap nand driver issues
> 
> Corresponding patch is:
> [PATCH 3/3][NAND][OMAP] : Fixing issue in oamp nand driver in prefetch mode read
> 
> Can you please give a look for this patch series?

Just pushed them to my l2-mtd-2.6.git/dunno

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
