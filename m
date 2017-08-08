From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 07 Aug 2017 18:51:31 -0700
Subject: [PATCH v2 2/3] usb: chipidea: Hook into mux framework to toggle
 usb switch
In-Reply-To: <7080030c-c9c2-657d-aad4-aef636438cb1@axentia.se>
References: <20170714214005.14967-1-stephen.boyd@linaro.org>
 <20170714214005.14967-3-stephen.boyd@linaro.org>
 <7080030c-c9c2-657d-aad4-aef636438cb1@axentia.se>
Message-ID: <150215709134.18242.599725161375995991@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Rosin (2017-07-31 03:33:22)
> On 2017-07-14 23:40, Stephen Boyd wrote:
> > @@ -1964,16 +1965,26 @@ void ci_hdrc_gadget_destroy(struct ci_hdrc *ci)
> >  
> >  static int udc_id_switch_for_device(struct ci_hdrc *ci)
> >  {
> > +     int ret = 0;
> > +
> >       if (ci->is_otg)
> >               /* Clear and enable BSV irq */
> >               hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE,
> >                                       OTGSC_BSVIS | OTGSC_BSVIE);
> >  
> > -     return 0;
> > +     if (!ci_otg_is_fsm_mode(ci))
> > +             ret = mux_control_select(ci->platdata->usb_switch, 0);
> > +
> > +     if (ci->is_otg && ret)
> > +             hw_write_otgsc(ci, OTGSC_BSVIE | OTGSC_BSVIS, OTGSC_BSVIS);
> > +
> > +     return ret;
> >  }
> >  
> >  static void udc_id_switch_for_host(struct ci_hdrc *ci)
> >  {
> > +     mux_control_deselect(ci->platdata->usb_switch);
> > +
> 
> This looks broken. You conditionally lock the mux and you unconditionally
> unlock it. Quoting the mux_control_deselect doc:
> 
>  * It is required that a single call is made to mux_control_deselect() for
>  * each and every successful call made to either of mux_control_select() or
>  * mux_control_try_select().
> 
> Think of the mux as a semaphore with a max count of one. If you lock it,
> you have to unlock it when you're done. If you didn't lock it, you have
> zero business unlocking it. If you try to lock it but fail, you also have
> no business unlocking it. Just like a semaphore.

Good catch. I've added a if (!ci_otg_is_fsm_mode()) check here.

> 
> Another point: I do not know if udc_id_switch_for_host is *only* called
> when there has been a prior call to udc_id_switch_for_device that
> succeeded or how this works exactly. But this all looks fragile. Using
> mux_control_select and mux_control_deselect *must* be done in pairs.
> If you want a mux to be locked for "a while", such as in this case, you
> have to make sure you stay within the rules. There is no room for half
> measures, or you will likely cause a deadlock when something unexpected
> happens.
> 

Can you elaborate? Is it bad that we keep it "locked" while we're in
host or device mode? It looked like we paired the start/stop ops with
each other so that the mux is properly managed across these ops. My
testing hasn't shown a problem, but maybe there's some corner case
you're thinking of? I'll double check the code.
