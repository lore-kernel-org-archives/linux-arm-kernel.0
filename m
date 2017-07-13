From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 13 Jul 2017 15:29:43 -0700
Subject: [PATCH 2/3] usb: chipidea: Hook into mux framework to toggle usb
 switch
In-Reply-To: <2db7bc39-9274-6007-d971-59e2a577d437@axentia.se>
References: <20170712010255.26855-1-stephen.boyd@linaro.org>
 <20170712010255.26855-3-stephen.boyd@linaro.org>
 <2db7bc39-9274-6007-d971-59e2a577d437@axentia.se>
Message-ID: <149998498328.4532.10720468535933872401@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Rosin (2017-07-11 23:45:24)
> On 2017-07-12 03:02, Stephen Boyd wrote:
> > @@ -102,4 +107,7 @@ Example:
> >               rx-burst-size-dword = <0x10>;
> >               extcon = <0>, <&usb_id>;
> >               phy-clkgate-delay-us = <400>;
> > +             mux-controls = <&usb_switch>;
> > +             mux-control-names = "usb_switch";
> > +             usb-switch-states = <0>, <1>;
> 
> I don't see the need for usb-switch-states? Just assume states 0/1 and
> if someone later needs some other states, make them add a property that
> overrides the defaults. Just document that 0 is host and 1 is device.
> 

Fine by me. Rob H do you agree?

> > diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> > index 18cb8e46262d..9fd23ecc2da3 100644
> > --- a/drivers/usb/chipidea/host.c
> > +++ b/drivers/usb/chipidea/host.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/usb/hcd.h>
> >  #include <linux/usb/chipidea.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/mux/consumer.h>
> >  
> >  #include "../host/ehci.h"
> >  
> > @@ -123,6 +124,13 @@ static int host_start(struct ci_hdrc *ci)
> >       if (usb_disabled())
> >               return -ENODEV;
> >  
> > +     if (!IS_ERR(ci->platdata->usb_switch.mux)) {
> > +             ret = mux_control_select(ci->platdata->usb_switch.mux,
> > +                                      ci->platdata->usb_switch.host);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> 
> You *must* call mux_control_deselect to clean up if there is a failure
> later in host_start. Is that handled in some non-obvious way?

Good catch. Thanks. I'll add in the unwinding on the error path.
