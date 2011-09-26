From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 26 Sep 2011 10:28:14 +0200
Subject: [PATCH] mmc: card: modify mmc_getgeo function
In-Reply-To: <m2ty8520fb.fsf@bob.laptop.org>
References: <1316516929-26694-1-git-send-email-girish.shivananjappa@linaro.org>
	<m2ty8520fb.fsf@bob.laptop.org>
Message-ID: <20110926082814.GA28149@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Sep 21, 2011 at 02:52:08PM -0400, Chris Ball wrote:
> Hi,
> 
> On Tue, Sep 20 2011, Girish K S wrote:
> > In the earlier code the cylinder, sector and head are assigned
> > independently. Current patch generates the cylinder number
> > with the values of sector and head.
> > This patch only makes they cylinder value to be dependent on
> > the sector and head.
> >
> > Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> > ---
> >  drivers/mmc/card/block.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> > index 1ff5486..bebb13b 100644
> > --- a/drivers/mmc/card/block.c
> > +++ b/drivers/mmc/card/block.c
> > @@ -226,9 +226,10 @@ static int mmc_blk_release(struct gendisk *disk, fmode_t mode)
> >  static int
> >  mmc_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
> >  {
> > -	geo->cylinders = get_capacity(bdev->bd_disk) / (4 * 16);
> >  	geo->heads = 4;
> >  	geo->sectors = 16;
> > +	geo->cylinders = get_capacity(bdev->bd_disk) /
> > +		(geo->heads * geo->sectors);
> >  	return 0;
> >  }
> 
> Thanks, pushed to mmc-next for 3.2 with a reworded commit message:
This (i.e. ee9e0e0 (mmc: card: Remove duplicated constants) in next)
makes gcc emit a reference to __aeabi_uldivmod in one of my nightly
builds which isn't defined.

The final linking stage fails with:

	  LD      .tmp_vmlinux1
	drivers/built-in.o: In function `mmc_blk_getgeo':
	clkdev.c:(.text+0xd1528): undefined reference to `__aeabi_uldivmod'
	make[2]: *** [.tmp_vmlinux1] Error 1
	make[1]: *** [sub-make] Error 2
	make: *** [all] Error 2

(I don't know why clkdev.c is referenced here. I'm not using ccache.)

It seems gcc isn't smart enough to notice that it can just use the same
generated code ...

Having said that AFAIK the code used before wasn't ok, too. (I.e. an u64
division that was just noticed to be a shift by luck.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
