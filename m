From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 9 Aug 2013 19:13:54 +0800
Subject: [PATCH v14 06/12] usb: chipidea: add flag
 CI_HDRC_DUAL_ROLE_NOT_OTG
In-Reply-To: <87fvujauqr.fsf@ashishki-desk.ger.corp.intel.com>
References: <1375432445-31918-1-git-send-email-peter.chen@freescale.com>
 <1375432445-31918-7-git-send-email-peter.chen@freescale.com>
 <87fvujauqr.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130809111352.GA24763@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 03:55:56PM +0300, Alexander Shishkin wrote:
> Peter Chen <peter.chen@freescale.com> writes:
> 
> > Since we need otgsc to know vbus's status at some chipidea
> > controllers even it is peripheral-only mode. Besides, some
> > SoCs (eg, AR9331 SoC) don't have otgsc register even
> > the DCCPARAMS_DC and DCCPARAMS_HC are both 1 at CAP_DCCPARAMS.
> >
> > We inroduce flag CI_HDRC_DUAL_ROLE_NOT_OTG to indicate if the
> > controller is dual role, but not supports OTG. If this flag is
> > not set, we follow the rule that if DCCPARAMS_DC and DCCPARAMS_HC
> > are both 1 at CAP_DCCPARAMS, then this controller is otg capable.
> >
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/chipidea/core.c  |   38 +++++++++++++++++++++++++++++++-------
> >  include/linux/usb/chipidea.h |    5 +++++
> >  2 files changed, 36 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > index bfc9aef..2ae18fd 100644
> > --- a/drivers/usb/chipidea/core.c
> > +++ b/drivers/usb/chipidea/core.c
> > @@ -426,6 +426,18 @@ static inline void ci_role_destroy(struct ci_hdrc *ci)
> >  	ci_hdrc_host_destroy(ci);
> >  }
> >  
> > +static void ci_get_otg_capable(struct ci_hdrc *ci)
> > +{
> > +	if (ci->platdata->flags & CI_HDRC_DUAL_ROLE_NOT_OTG)
> > +		ci->is_otg = false;
> > +	else
> > +		ci->is_otg = (hw_read(ci, CAP_DCCPARAMS,
> > +				DCCPARAMS_DC | DCCPARAMS_HC)
> > +					== (DCCPARAMS_DC | DCCPARAMS_HC));
> > +	if (ci->is_otg)
> > +		dev_dbg(ci->dev, "It is OTG capable controller\n");
> > +}
> > +
> >  static int ci_hdrc_probe(struct platform_device *pdev)
> >  {
> >  	struct device	*dev = &pdev->dev;
> > @@ -482,6 +494,9 @@ static int ci_hdrc_probe(struct platform_device *pdev)
> >  		return -ENODEV;
> >  	}
> >  
> > +	/* To know if controller is OTG capable or not */
> > +	ci_get_otg_capable(ci);
> 
> The comment is redundant.
> 

Will delete

> > +		} else {
> > +			/*
> > +			 * If the controller is not OTG capable, but support
> > +			 * role switch, the defalt role is gadget, and the
> > +			 * user can switch it through debugfs (proc in future?)
> 
> It's not going to be in procfs ever, so that part of the comment can go.
> 

I can delete now, but the role switch does not a debug function, we
may not put it at debugfs, do you think so?

> > +			 */
> > +			ci->role = CI_ROLE_GADGET;
> 
> I think we might need a config option for this in the future, at least.
> 

Yes, we can add CONFIG_CI_DEFAULT_ROLE in the future.

-- 

Best Regards,
Peter Chen
