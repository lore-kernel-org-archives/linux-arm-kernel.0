From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 30 May 2016 12:18:40 +0200
Subject: [PATCH] reset: Put back *_optional variants
In-Reply-To: <dcf6372f-4910-bd03-f1b5-c7e0086fdead@redhat.com>
References: <ca359e013c30f27c825a9580164b01da5ca6476d.1464224883.git.johnyoun@synopsys.com>
 <12e450f0-70ea-29f8-0bf7-8a0697263f2d@redhat.com>
 <57476E48.2060204@synopsys.com>
 <dcf6372f-4910-bd03-f1b5-c7e0086fdead@redhat.com>
Message-ID: <1464603520.3808.34.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Freitag, den 27.05.2016, 09:06 +0200 schrieb Hans de Goede:
[...]
> >> So IMHO the following change would be a better way to fix this:
> >>
> >> --- a/include/linux/reset.h
> >> +++ b/include/linux/reset.h
> >> @@ -65,14 +65,14 @@ static inline struct reset_control *__of_reset_control_get(
> >>                                          struct device_node *node,
> >>                                          const char *id, int index, int shared)
> >>   {
> >> -   return ERR_PTR(-EINVAL);
> >> + return ERR_PTR(-ENOTSUPP);
> >>   }
> >>
> >>   static inline struct reset_control *__devm_reset_control_get(
> >>                                          struct device *dev,
> >>                                          const char *id, int index, int shared)
> >>   {
> >> -   return ERR_PTR(-EINVAL);
> >> + return ERR_PTR(-ENOTSUPP);
> >>   }
> >>
> >>   #endif /* CONFIG_RESET_CONTROLLER */
> >
> >
> > I'm good with this. However, per Philipp on a previous thread, the
> > intended behavior is to return -EINVAL for the non-optional functions.
> >
> > http://marc.info/?l=linux-usb&m=146156945528848&w=2

Adding Dinh to Cc: because he wanted this changed from -EINVAL.
My point then was that WARN_ON + -EINVAL is indented in this case.

Given that the warning backtrace already helps to identify the issue
(CONFIG_RESET_CONTROLLER disabled), and that changing the return value
to -ENOTSUPP improves consistency with the rest of the API and reduces
the amount of inline wrappers, I concur.

> As Philipp rightfully points out, calling the non-optional functions
> without CONFIG_RESET_CONTROLLER is a no-no, so IMHO we should not have to
> care too much about the error code in that case, as long as we return
> an error.
> 
> Also note that even before my patch things were already inconsistent
> with the of_...get... functions already always returning
> -ENOTSUPP when CONFIG_RESET_CONTROLLER was not set, to me it seems
> best and also KISS to just return -ENOTSUPP from all get functions
> when CONFIG_RESET_CONTROLLER is not set.
> 
> Anyways this is Philipp's call, this is all just my 2 cents.

Let the stubs return -ENOTSUPP consistently. A quick grep doesn't show
any driver handling -EINVAL explicitly either.

regards
Philipp
