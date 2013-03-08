From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 8 Mar 2013 20:42:12 +0800
Subject: [PATCH v11 3/9] usb: chipidea: add otg id switch and vbus
 connect/disconnect detect
In-Reply-To: <20130307055023.GF20470@nchen-desktop>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-4-git-send-email-peter.chen@freescale.com>
 <CAB7JpEHoA3Hx-2rf=Xrpy-zQ-4YASiGzMfhBcX-Du008FAoc+Q@mail.gmail.com>
 <20130307055023.GF20470@nchen-desktop>
Message-ID: <20130308124212.GB3462@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 01:50:24PM +0800, Peter Chen wrote:
> On Wed, Mar 06, 2013 at 07:09:34PM +0200, Alexander Shishkin wrote:
> > > - start/stop API are used at otg id switch and probe routine
> > >
> > > - Defer some gadget operations at ci's delayed work queue
> > 
> > When I asked you to reorder patches, I didn't mean squash them all
> > into one. Now you have a patch that does 5 different things and none
> > of them properly, because you still need to amend these changes later
> > in the patchset, like the patch 7, where you remove the delayed work,
> > which is added in this patch. At the same time, you have bits in this
> > patch that should be moved to other patches. See comments below.
> > 
> 
> I am sorry to let you review difficult, as I changed/added patch according
> to function change, but not updated previous patches.
> 
> I will re-organize all patches according to functionalities.
> Besides, can you help review all patches during next time, in that case,
> I can know which patch is ok.
> 
> > 
> > You remove this function in patch 7. Why add it in the first place?
> > 
> 
> As it is needed at patch 7 to let the function work
> 
> > > +
> > > +static inline void ci_role_destroy(struct ci13xxx *ci)
> > > +{
> > > +       ci_hdrc_gadget_destroy(ci);
> > > +       ci_hdrc_host_destroy(ci);
> > > +}
> > 
> > You shouldn't use "inline" here. And the name of the function is also
> > ambiguous, since it destroys all roles. It would be better to just
> > call both _destroys(), like I suggested in the diff I gave you some
> > time ago.
> 
> Will change.
> 
> > 
> > > +
> > >  static ssize_t show_role(struct device *dev, struct device_attribute *attr,
> > >                          char *buf)
> > >  {
> > > @@ -352,25 +468,50 @@ static ssize_t store_role(struct device *dev, struct device_attribute *attr,
> > >
> > >  static DEVICE_ATTR(role, S_IRUSR | S_IWUSR, show_role, store_role);
> > >
> > > +static bool ci_is_otg_capable(struct ci13xxx *ci)
> > > +{
> > > +       return hw_read(ci, CAP_DCCPARAMS, DCCPARAMS_DC | DCCPARAMS_HC)
> > > +               == (DCCPARAMS_DC | DCCPARAMS_HC);
> > > +}
> > 
> > Can't we
> > a) remember this value so that we don't have to read the register at
> > every interrupt
> 
> Yes.
> 
> > b) also take into account the fact that DCCPARAMS doesn't read
> > correctly on all chipideas? (see dr_mode patches)
> > 
> 
> We have discussed it, but you have not given me exactly answer
> "Which situation we can read OTGSC"?
> 
> 1. We Can't read OTGSC if DCCPARAMS shows it is only device-capable
> 2. DCCPARAMS doesn't correctly for some chips
> 3. If we depend on dr_mode, OTGSC should be read when dr_mode = "peripheral",
> in that case, the condition is ci->roles[CI_ROLE_GADGET].
> 
> If the dr_mode is not set by DT, the 1 and 3 is conflict.
> 
> 
> > >
> > > -       if (ci->is_otg)
> > > +       if (ci_is_otg_capable(ci))
> > 
> > ci->is_otg is actually the right thing to use, we should instead make
> > sure that it's set properly
> > 
> 
> Yes, what is ci->is_otg stands for in your opinion?
> In my patchset, it means it supportes partial OTG (id switch) function.
> 
> > >         if (ci->roles[CI_ROLE_HOST] && ci->roles[CI_ROLE_GADGET]) {
> > > +               dev_dbg(dev, "support otg\n");
> > >                 ci->is_otg = true;
> > > +               /* if otg is supported, create struct usb_otg */
> > > +               ci_hdrc_otg_init(ci);
> > >                 /* ID pin needs 1ms debouce time, we delay 2ms for safe */
> > >                 mdelay(2);
> > >                 ci->role = ci_otg_role(ci);
> > 
> > I'm thinking that this should be based on dr_mode patches and not the
> > other way around.
> > 
> 
> No, ci->role means which role is currently.
> And it is otg mode already as 
> (ci->roles[CI_ROLE_HOST] && ci->roles[CI_ROLE_GADGET]).
> 
> > >
> > >  static int ci_otg_set_peripheral(struct usb_otg *otg,
> > >                 struct usb_gadget *periph)
> > > @@ -55,6 +62,7 @@ int ci_hdrc_otg_init(struct ci13xxx *ci)
> > >         ci->otg.set_host = ci_otg_set_host;
> > >         if (!IS_ERR_OR_NULL(ci->transceiver))
> > >                 ci->transceiver->otg = &ci->otg;
> > > +       ci_enable_otg_interrupt(ci, OTGSC_IDIE);
> > 
> > There should be a counter-action to ci_hdrc_otg_init().
> > Btw, why can't clear_otg_interrupt() be called from here as well
> > instead of hw_device_init()? 
> 
> What the criterion for reading OTGSC?
> What means otg capable and how do we know it is otg capable?
> 
> > This function should only be called for
> > otg capable devices, so it should be safe. And while at it, I think
> > this whole otg.c/otg.h part of this patch should be moved to patch 2.
> > 
> 
> OK.
> 
> > >
> > > +static int udc_id_switch_for_device(struct ci13xxx *ci)
> > 
> > I would use _to_ instead of _for_, for clarity.
> > 
> > > +{
> > > +       ci_clear_otg_interrupt(ci, OTGSC_BSVIS);
> > > +       ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void udc_id_switch_for_host(struct ci13xxx *ci)
> > 

Hi Alan, 

Would you like to answer my questions, esp for
"the situation to read OTGSC", we discussed it lots of times,
but seems has no conclusion.

Thanks.
-- 


Best Regards,
Peter Chen
