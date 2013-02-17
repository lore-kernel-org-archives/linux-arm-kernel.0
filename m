From: peter.chen@freescale.com (Peter Chen)
Date: Sun, 17 Feb 2013 11:27:29 +0800
Subject: [PATCH v8 3/8] usb: chipidea: add otg id switch and vbus
 connect/disconnect detect
In-Reply-To: <87wqub9ill.fsf@ashishki-desk.ger.corp.intel.com>
References: <1360051215-27722-1-git-send-email-peter.chen@freescale.com>
 <1360051215-27722-4-git-send-email-peter.chen@freescale.com>
 <87wqub9ill.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130217032728.GB1588@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 02:37:42PM +0200, Alexander Shishkin wrote:
> Peter Chen <peter.chen@freescale.com> writes:
> 
> > @@ -130,6 +130,7 @@ struct hw_bank {
> >   * @transceiver: pointer to USB PHY, if any
> >   * @hcd: pointer to usb_hcd for ehci host driver
> >   * @otg: for otg support
> > + * @events: events for otg, and handled at ci_role_work
> 
> Should be id_event and b_sess_valid_event.

Will change

> 
> If you reordered the patchset so that the role api patch comes before
> this one, this function would have been much shorter from the start. Now
> it looks like you're adding lots of code in one patch and then replace
> and reshuffle it in subsequent patches, which makes it really difficult
> to review.

I will merge the 3/8 and 4/8 to one patch.

> > +static void ci_delayed_work(struct work_struct *work)
> > +{
> > +	struct delayed_work *dwork = to_delayed_work(work);
> > +	struct ci13xxx *ci = container_of(dwork, struct ci13xxx, dwork);
> > +
> > +	otg_set_vbus(&ci->otg, true);
> > +
> > +}
> 
> That's one newline too many.

Will change

> 
> > +
> >  static ssize_t show_role(struct device *dev, struct device_attribute *attr,
> >  			 char *buf)
> >  {
> > @@ -352,25 +469,49 @@ static ssize_t store_role(struct device *dev, struct device_attribute *attr,
> >  
> >  static DEVICE_ATTR(role, S_IRUSR | S_IWUSR, show_role, store_role);
> >  
> > +static bool ci_supports_gadget(struct ci13xxx *ci)
> > +{
> > +	return (ci->roles[CI_ROLE_GADGET]) ? true : false;
> 

I prefer to keep it

> > +}
> > +
> >  static irqreturn_t ci_irq(int irq, void *data)
> >  {
> >  	struct ci13xxx *ci = data;
> >  	irqreturn_t ret = IRQ_NONE;
> >  	u32 otgsc = 0;
> >  
> > -	if (ci->is_otg)
> > +	if (ci_supports_gadget(ci))
> 
> We can't do this since there are indeed devices out there that support
> gadget and don't support otg to such an extend that OTGSC accesses are
> discouraged. We should really make sure that we're only touching it on
> otg capable devices.
> 

OK, for such devices they need external gpio to judge connection
and disconnection.

I will replace ci_supports_gadget(ci) to ci_supports_otg(ci), it
indicates the controller supports both host and devices. Currently,
the ci->is_otg indicates the driver has both host and device funcitons.

-- 

Best Regards,
Peter Chen
