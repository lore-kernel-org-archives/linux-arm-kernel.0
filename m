From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 27 Jun 2016 12:07:54 -0700
Subject: [PATCH 04/21] usb: chipidea: Only read/write OTGSC from one place
In-Reply-To: <AM4PR04MB213088094DF074BB5CB3DD0689210@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-5-stephen.boyd@linaro.org>
 <AM4PR04MB213088094DF074BB5CB3DD0689210@AM4PR04MB2130.eurprd04.prod.outlook.com>
Message-ID: <146705447431.30684.10431147947045016957@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jun Li (2016-06-27 01:04:39)
> > diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c index
> > 03b6743461d1..763a8332b009 100644
> > --- a/drivers/usb/chipidea/otg.c
> > +++ b/drivers/usb/chipidea/otg.c
> > @@ -104,7 +104,32 @@ void ci_handle_vbus_change(struct ci_hdrc *ci)
> >               usb_gadget_vbus_disconnect(&ci->gadget);
> >  }
> > 
> > -#define CI_VBUS_STABLE_TIMEOUT_MS 5000
> > +/**
> > + * Sometimes, it needs to wait register value before going on.
> > + * Eg, when switch to device mode, the vbus value should be lower
> > + * than OTGSC_BSV before connects to host.
> 
> This should be updated since this API is dedicated for BSV now.

Ok I've updated it to say:

  When we switch to device mode, the vbus value should be lower
  than OTGSC_BSV before connecting to host.

> 
> > + *
> > + * @ci: the controller
> > + *
> > + * This function returns an error code if timeout  */ static int
> > +hw_wait_otgsc_bsv(struct ci_hdrc *ci) {
> > +     unsigned long elapse = jiffies + msecs_to_jiffies(5000);
> > +     u32 mask = OTGSC_BSV;
> > +
> > +     while (!hw_read_otgsc(ci, mask)) {
> 
> Reverse logic, should be:
> while (hw_read_otgsc(ci, mask)) {
> 

Good catch! Thanks.
