From: joe@perches.com (Joe Perches)
Date: Mon, 23 Sep 2013 10:44:42 -0700
Subject: [PATCH v5 1/4] media: s5p-tv: Replace mxr_ macro by default dev_
In-Reply-To: <13162989.WhfDRzW6dg@amdc1032>
References: <1379775649-6331-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1379775649-6331-2-git-send-email-m.krawczuk@partner.samsung.com>
 <52405519.3020504@samsung.com> <13162989.WhfDRzW6dg@amdc1032>
Message-ID: <1379958282.3575.31.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-09-23 at 17:48 +0200, Bartlomiej Zolnierkiewicz wrote:
> On Monday, September 23, 2013 04:50:01 PM Tomasz Stanislawski wrote:
> > May I ask what is the rationale for this patch?
> > To reduce a few lines of code?
> This patch makes source code more generic-like and easier to follow (mxd_r*
> macros currently only obfuscate the code and make them harder to read for
> everybody, maybe besides the original driver author ;). Removal of few
> superfluous lines of code is just a bonus.

I don't see any significant issue with this change.
Using generic mechanisms is good.

Few trivial nits:

I'd remove the trailing periods from some of the messages
at the same time.

Function tracing is better done by the function tracing
mechanism built in to the kernel.  Removing the
	dev_dbg(dev, "%s: enter\n", __func__)
lines would be good too.

Maybe look at the message levels of more of these
logging messages and determine which are actually
useful and what is mostly noise and should be dev_dbg
or deleted altogether.

> > > diff --git a/drivers/media/platform/s5p-tv/mixer_drv.c b/drivers/media/platform/s5p-tv/mixer_drv.c

> > > @@ -59,7 +59,7 @@ void mxr_streamer_get(struct mxr_device *mdev)
> > >  {
> > >  	mutex_lock(&mdev->mutex);
> > >  	++mdev->n_streamer;
> > > -	mxr_dbg(mdev, "%s(%d)\n", __func__, mdev->n_streamer);
> > > +	dev_dbg(mdev->dev, "%s(%d)\n", __func__, mdev->n_streamer);

not too useful

[]

> > > @@ -159,42 +159,42 @@ static int mxr_acquire_plat_resources(struct mxr_device *mdev,
> > >  
> > >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mxr");
> > >  	if (res == NULL) {
> > > -		mxr_err(mdev, "get memory resource failed.\n");
> > > +		dev_err(mdev->dev, "get memory resource failed.\n");

		dev_err(mdev->dev, "get memory resource failed\n");
etc... because of:

> > > @@ -252,27 +252,27 @@ static int mxr_acquire_clocks(struct mxr_device *mdev)
> > >  
> > >  	res->mixer = clk_get(dev, "mixer");
> > >  	if (IS_ERR(res->mixer)) {
> > > -		mxr_err(mdev, "failed to get clock 'mixer'\n");
> > > +		dev_err(mdev->dev, "failed to get clock 'mixer'\n");

Mixed use of messages with/without periods.

> > > @@ -295,13 +295,13 @@ static int mxr_acquire_resources(struct mxr_device *mdev,
> > >  	if (ret)
> > >  		goto fail_plat;
> > >  
> > > -	mxr_info(mdev, "resources acquired\n");
> > > +	dev_info(mdev->dev, "resources acquired\n");

This isn't really a useful message so I'd convert it
to dev_dbg

> > > @@ -391,7 +391,6 @@ static int mxr_probe(struct platform_device *pdev)
> > >  	struct mxr_device *mdev;
> > >  	int ret;
> > >  
> > > -	/* mdev does not exist yet so no mxr_dbg is used */
> > >  	dev_info(dev, "probe start\n");

Same with a lot of these...

Maybe in a separate patch.
