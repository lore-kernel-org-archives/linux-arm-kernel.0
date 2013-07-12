From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 12 Jul 2013 16:25:01 +0800
Subject: [PATCH v12 06/13] usb: chipidea: add otg_cap attribute for otg
 capable
In-Reply-To: <871u742o4u.fsf@ashishki-desk.ger.corp.intel.com>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
 <1373524041-10482-7-git-send-email-peter.chen@freescale.com>
 <871u742o4u.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130712082500.GA16202@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 11:12:01AM +0300, Alexander Shishkin wrote:
> Peter Chen <peter.chen@freescale.com> writes:
> 
> > Since we need otgsc to know vbus's status at some chipidea
> > controllers even it is peripheral-only mode. Besides, some
> > SoCs (eg, AR9331 SoC) don't have otgsc register even
> > the DCCPARAMS_DC and DCCPARAMS_HC are both 1 at CAP_DCCPARAMS.
> > We inroduce otg_cap attribute to indicate if the controller
> > is otg capable, defaultly, we follow the rule that if DCCPARAMS_DC
> > and DCCPARAMS_HC are both 1 at CAP_DCCPARAMS are otg capable, but if there
> > is exception, the platform can override it by device tree or platform data.
> >
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> 
> [...]
> 
> > diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> > index 118bf66..0a906b4 100644
> > --- a/include/linux/usb/chipidea.h
> > +++ b/include/linux/usb/chipidea.h
> > @@ -7,6 +7,12 @@
> >  
> >  #include <linux/usb/otg.h>
> >  
> > +enum usb_otg_cap {
> > +	OTG_CAP_ATTR_IS_NOT_EXISTED = 0,
> > +	OTG_CAP_ATTR_IS_TRUE,
> > +	OTG_CAP_ATTR_IS_FALSE,
> > +};
> 
> We don't really need all three, do we? We only need to know if the
> controller *can't* do otg. The rest we can infer from dr_mode and
> DCCPARAMS. So it can be another bit in flags rather than a separate
> field in platdata.
> 

In order to cover below two cases, I have no other idea.

1. For mips Soc (ARxxx), if dr_mode = otg and it is 1 for both
mode at DCCPARAMS,  It can switch role through proc or whatever,
but NO otgsc register, it is NOT otg-capable.

2. For peripheral-only case at most chipidea controllers,
the dr_mode = peripheral and it is 1 for both modes at DCCPARAMS,
the otgsc can be visited, it is otg-capable.

-- 

Best Regards,
Peter Chen
