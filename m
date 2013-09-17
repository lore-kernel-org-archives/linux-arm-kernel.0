From: jbe@pengutronix.de (=?iso-8859-1?q?J=FCrgen_Beisert?=)
Date: Tue, 17 Sep 2013 09:33:08 +0200
Subject: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven
 touch detection
In-Reply-To: <20130916152846.GC12105@core.coreip.homeip.net>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de>
 <52359259.8010202@kernel.org> <20130916152846.GC12105@core.coreip.homeip.net>
Message-ID: <201309170933.08505.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On Monday 16 September 2013 17:28:46 Dmitry Torokhov wrote:
> [...]
> > >  static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
> > > @@ -641,6 +1056,7 @@ static void mxs_lradc_ts_unregister(struct
> > > mxs_lradc *lradc)
> > >
> > >  	cancel_work_sync(&lradc->ts_work);
> > >
> > > +	mxs_lradc_disable_ts(lradc);
> > >  	input_unregister_device(lradc->ts_input);
> > >  }
>
> This looks iffy... Normally you disable the device so that it does not
> generate more interrupts, and then cancel outstanding work(s), otherwise
> newly generated interrupts may cause more work to be scheduled. Or I
> missed some of the context and this is not a concern here?

This part gets removed in patch 6/6:

@@ -1054,8 +891,6 @@ static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
????????if (!lradc->use_touchscreen)
????????????????return;
?
-???????cancel_work_sync(&lradc->ts_work);
-
????????mxs_lradc_disable_ts(lradc);
????????input_unregister_device(lradc->ts_input);
?}

But you are right, I should move this into patch 5/6.

Thanks

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |
