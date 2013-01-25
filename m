From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 25 Jan 2013 11:30:15 +0800
Subject: [RESEND PATCH v5 4/7] usb: chipidea: consolidate
 ci_role_driver's API for both roles
In-Reply-To: <8738xqodhp.fsf@ashishki-desk.ger.corp.intel.com>
References: <1358733418-17969-1-git-send-email-peter.chen@freescale.com>
 <1358733418-17969-5-git-send-email-peter.chen@freescale.com>
 <8738xqodhp.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130125033013.GB29795@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 04:35:30PM +0200, Alexander Shishkin wrote:
> Peter Chen <peter.chen@freescale.com> writes:
> 
> > - Create init/destroy API for probe and remove
> > - start/stop API are only used otg id switch process
> > - Create the gadget at ci_hdrc_probe if the gadget is supported
> > at that port, the main purpose for this is to avoid gadget module
> > load fail at init.rc
> 
> I don't think it's necessary to mention android-specific init scripts
> here in our patches.

Ok, will just mention init script.
> 
> >  
> > +static inline void ci_role_destroy(struct ci13xxx *ci)
> > +{
> > +	enum ci_role role = ci->role;
> > +
> > +	if (role == CI_ROLE_END)
> > +		return;
> > +
> > +	ci->role = CI_ROLE_END;
> > +
> > +	ci->roles[role]->destroy(ci);
> > +}
> 
> What does this do? It should take role an a parameter, at least. Or it
> can be called ci_roles_destroy() and, well, destroy all the roles. Now
> we're in a situation where we destroy one.
Yes, this function has some problems, I suggest just call two lines at
ci_role_destory, do you think so?

	ci->roles[role]->destroy(ci);
	ci->role = CI_ROLE_END;
> 
> The idea is that, with this api, we can (and should) have both roles
> allocated all the time, but only one role start()'ed.
> 
> What we can do here is move the udc's .init() code to
> ci_hdrc_gadget_init() and add a complementary ci_hdrc_gadget_destroy(),
> which we call in ci_hdrc_remove() and probe's error path. And we can
> probably do something similar for the host, or just leave it as it is
> now. Seems simpler to me.
Yes, current code has bug that it should call ci_role_destroy at probe's
error path.
For your comments, it still needs to add destory function for udc which will
be called at core.c. I still prefer current way due to below reasons:

- It can keep ci_hdrc_gadget_init() clean
- .init and .remove are different logical function with .start and .stop.
The .init and .remove are used for create and destroy, .start and .stop
are used at id role switch.

> >  }
> > diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> > index caecad9..6024a4f 100644
> > --- a/drivers/usb/chipidea/host.c
> > +++ b/drivers/usb/chipidea/host.c
> > @@ -92,8 +92,10 @@ int ci_hdrc_host_init(struct ci13xxx *ci)
> >  	if (!rdrv)
> >  		return -ENOMEM;
> >  
> > +	rdrv->init	= host_start;
> >  	rdrv->start	= host_start;
> >  	rdrv->stop	= host_stop;
> > +	rdrv->destroy	= host_stop;
> 
> Will this allocate the hcd twice if we start in host role? Looks like that.
No, if we start host role, the host will be allocated once at probe.
host_start is only called when the id value from 1 to 0.
> 

-- 

Best Regards,
Peter Chen
