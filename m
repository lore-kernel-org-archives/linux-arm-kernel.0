From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 16 Oct 2018 16:55:00 +0300
Subject: [PATCH 1/3] driver core: add probe_err log helper
In-Reply-To: <20181016125543eucas1p1f23b3482179a9cd465f509e0abf782c1~eGAecmAv93038330383eucas1p1j@eucas1p1.samsung.com>
References: <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
 <20181016072244.1216-1-a.hajda@samsung.com>
 <20181016072244.1216-2-a.hajda@samsung.com>
 <CAHp75VfVxEkTzc=1hBrvc4K7r=L28vXipb=j9jSRJbTJE4GtLQ@mail.gmail.com>
 <605bd00e-ed0d-4259-bdc3-1784b2b3b16a@samsung.com>
 <20181016125543eucas1p1f23b3482179a9cd465f509e0abf782c1~eGAecmAv93038330383eucas1p1j@eucas1p1.samsung.com>
Message-ID: <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 3:55 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 16.10.2018 13:29, Andrzej Hajda wrote:
> > On 16.10.2018 13:01, Andy Shevchenko wrote:
> >> On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >>> During probe every time driver gets resource it should usually check for error
> >>> printk some message if it is not -EPROBE_DEFER and return the error. This
> >>> pattern is simple but requires adding few lines after any resource acquisition
> >>> code, as a result it is often omited or implemented only partially.
> >>> probe_err helps to replace such code seqences with simple call, so code:
> >>>         if (err != -EPROBE_DEFER)
> >>>                 dev_err(dev, ...);
> >>>         return err;
> >>> becomes:
> >>>         return probe_err(dev, err, ...);

> >>> +               va_start(args, fmt);
> >>> +
> >>> +               vaf.fmt = fmt;
> >>> +               vaf.va = &args;
> >>> +
> >>> +               __dev_printk(KERN_ERR, dev, &vaf);

> >> It would be nice to print an error code as well, wouldn't it?
> > Hmm, on probe fail error is printed anyway (with exception of
> > EPROBE_DEFER, ENODEV and ENXIO):
> >     "probe of %s failed with error %d\n"
> > On the other side currently some drivers prints the error code anyway
> > via dev_err or similar, so I guess during conversion to probe_err it
> > should be removed then.
> >
> > If we add error code to probe_err is it OK to report it this way?
> >     dev_err(dev, "%V, %d\n", &vaf, err);
>
> Ups, I forgot that message passed to probe_err will contain already
> newline character.

You may consider not to pass it.

> So the err must be before message passed to probe_err, for example:
>     dev_err(dev, "err=%d: %V\n", err, &vaf);

> Is it OK?

For me would work either (no \n in the message, or err preceding the message).

-- 
With Best Regards,
Andy Shevchenko
