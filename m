From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jan 2013 08:43:34 +0000
Subject: [PATCH 16/24] ab8500-bm: Flush all work queues before suspending
In-Reply-To: <20130121191411.GA16177@lizard.mcd01528.sjc.wayport.net>
References: <1358769840-4763-1-git-send-email-lee.jones@linaro.org>
 <1358769840-4763-17-git-send-email-lee.jones@linaro.org>
 <20130121191411.GA16177@lizard.mcd01528.sjc.wayport.net>
Message-ID: <20130122084334.GD6857@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Jan 2013, Anton Vorontsov wrote:

> On Mon, Jan 21, 2013 at 12:03:52PM +0000, Lee Jones wrote:
> > From: Jonas Aaberg <jonas.aberg@stericsson.com>
> > 
> > Flush all workqueues at suspend time to avoid suspending during work.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
> > Reviewed-by: Marcus COOPER <marcus.xm.cooper@stericsson.com>
> > Reviewed-on: http://gerrit.lud.stericsson.com/gerrit/61915
> 
> I do remeber I was commenting on that patch, and I was asking to merge the
> changes into the patches that introduce the workqueues (aka problems).
> 
> Now I see that "ab8500_charger: Detect charger removal" commit already in
> the mainline, i.e. I merged the patch with the *known* possible
> regression. The issue was known to me during the first review cycle, and I
> pointed you to my review comments. But the patch sneaked in anyway...

I assure you I didn't _sneak_ any patch in. I'm working on small, simplified
patch-sets for your convenience. I didn't look at the review comments
for this patch until I placed it in this patch-set. By the time I did
look, the offending patch was already in -next. To solve this type of
situation, I can either send you the whole lot in one go with
everything fixed-up and squashed, or we can continue dealing with more
manageable patch-sets where situations like this are bound to happen
occasionally.

Even when working directly with Mainline, we still have patches which
fixup issues which were introduced earlier in the development
cycle. I'm not sure on your view of it exactly, but I don't think it's
the end of the world?

> > ---
> >  drivers/power/ab8500_charger.c |   11 +++++++++++
> >  drivers/power/ab8500_fg.c      |    5 +++++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
> > index da965ee..a632b94 100644
> > --- a/drivers/power/ab8500_charger.c
> > +++ b/drivers/power/ab8500_charger.c
> > @@ -2866,6 +2866,17 @@ static int ab8500_charger_suspend(struct platform_device *pdev,
> >  	if (delayed_work_pending(&di->check_hw_failure_work))
> >  		cancel_delayed_work(&di->check_hw_failure_work);
> >  
> > +	flush_delayed_work(&di->attach_work);
> > +	flush_delayed_work(&di->usb_charger_attached_work);
> > +	flush_delayed_work(&di->ac_charger_attached_work);
> > +	flush_delayed_work(&di->check_usbchgnotok_work);
> > +	flush_delayed_work(&di->check_vbat_work);
> > +	flush_delayed_work(&di->kick_wd_work);
> > +
> > +	flush_work(&di->usb_link_status_work);
> > +	flush_work(&di->ac_work);
> > +	flush_work(&di->detect_usb_type_work);
> > +
> >  	return 0;
> >  }
> >  #else
> > diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
> > index 0378aab..1a78116 100644
> > --- a/drivers/power/ab8500_fg.c
> > +++ b/drivers/power/ab8500_fg.c
> > @@ -2410,6 +2410,11 @@ static int ab8500_fg_suspend(struct platform_device *pdev,
> >  	struct ab8500_fg *di = platform_get_drvdata(pdev);
> >  
> >  	flush_delayed_work(&di->fg_periodic_work);
> > +	flush_work(&di->fg_work);
> > +	flush_work(&di->fg_acc_cur_work);
> > +	flush_delayed_work(&di->fg_reinit_work);
> > +	flush_delayed_work(&di->fg_low_bat_work);
> > +	flush_delayed_work(&di->fg_check_hw_failure_work);
> >  
> >  	/*
> >  	 * If the FG is enabled we will disable it before going to suspend

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
