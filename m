From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 30 Jan 2013 14:52:46 +0800
Subject: [RESEND PATCH v5 4/7] usb: chipidea: consolidate
 ci_role_driver's API for both roles
In-Reply-To: <87vcagmist.fsf@ashishki-desk.ger.corp.intel.com>
References: <1358733418-17969-1-git-send-email-peter.chen@freescale.com>
 <1358733418-17969-5-git-send-email-peter.chen@freescale.com>
 <8738xqodhp.fsf@ashishki-desk.ger.corp.intel.com>
 <20130125033013.GB29795@nchen-desktop>
 <87sj5pbgwr.fsf@ashishki-desk.ger.corp.intel.com>
 <20130128052158.GA8066@nchen-desktop>
 <87vcagmist.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130130065245.GB699@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 11:37:22AM +0200, Alexander Shishkin wrote:
> Peter Chen <peter.chen@freescale.com> writes:
> 
> > On Fri, Jan 25, 2013 at 02:12:20PM +0200, Alexander Shishkin wrote:
> >> Peter Chen <peter.chen@freescale.com> writes:
> >> 
> >> > On Thu, Jan 24, 2013 at 04:35:30PM +0200, Alexander Shishkin wrote:
> >> >> Peter Chen <peter.chen@freescale.com> writes:
> >> >> 
> >> >> > - Create init/destroy API for probe and remove
> >> >> > - start/stop API are only used otg id switch process
> >> >> > - Create the gadget at ci_hdrc_probe if the gadget is supported
> >> >> > at that port, the main purpose for this is to avoid gadget module
> >> >> > load fail at init.rc
> >> >> 
> >> @@ -402,6 +402,12 @@ static ssize_t store_role(struct device *dev, struct device_attribute *attr,
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> +	/*
> >> +	 * there won't be an interrupt in case of manual switching,
> >> +	 * so we need to check vbus session manually
> >> +	 */
> >> +	ci_handle_vbus_change(ci);
> >> +
> > It may not be used as there will be a vbus interrupt.
> 
> Not if you write gadget to "role" file.

Let me see, we will only use it for standard-A receptacle port soldered
at OTG port, there is no ID manual switch, and ID pin is grounded.

When the user wants to use it at gadget mode, eg, update image.
1. Plug cable, then write "gadget" to "role" file
It will work as there will be  ci_handle_vbus_change(ci) at role_start,
just like we insmod gadget mode when the cable is connecting to host.

2. Write "gadget" to "role" file first, then plug cable
After stopping host, it should close vbus.
After gadget role starts, it will enable vbus interrupt.
Then, when we plug in A-to-A cable, there will be a vbus interrupt, then
active gadget.

> >>  		return -ENOMEM;
> >>  
> >> -	rdrv->init	= udc_start;
> >>  	rdrv->start	= udc_id_switch_for_device;
> >>  	rdrv->stop	= udc_id_switch_for_host;
> >> -	rdrv->destroy	= udc_stop;
> > Where we call udc_start and udc_stop? And the udc_start should only be called
> > one time.
> 
> ci_hdrc_gadget_init() and ci_hdrc_gadget_destroy(). Look closer at the
> patch.

I am sorry, I still not see udc_stop at ci_hdrc_gadget_destroy().
It doesn't matter. I know what you want to do, let me summery

- Call udc_start at ci_hdrc_gadget_init, but vbus enable function should
only be called if the role is gadget, or vbus interrupt will occur
when the host switches gadget (vbus is off), besides, the ci->vbus_active
will be set at host mode, and ci13xxx_start will operate register
with function hw_device_state(ci, ci->ep0out->qh.dma) if we load module
at host mode. Besides, if we set REG_SHARED, it will reset controller.

- Create two destroy functions for gadget and host, and call them at ci
remove.

Anything I forget, or do you think anything else I need to change?

If you agree, I will send patch for above change.
Do you want this change is on the top of my v5 patch
or just a new v6 patch with above change?

> > - When the OTG port is at host mode, it should not call any
> > register writing operations at gadget's API.
> 
> Furthermore, there shouldn't be any calls to the gadget api.
The user may load gadget module when it is at host mode, eg, at
their init script.
-- 

Best Regards,
Peter Chen
