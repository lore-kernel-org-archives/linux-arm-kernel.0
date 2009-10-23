From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 23 Oct 2009 08:57:26 +0300
Subject: [PATCH] s3c24xx-adc: resume convertions interrupted by going to
	suspend
In-Reply-To: <20091022190524.GB8096@trinity.fluff.org>
References: <200910201719.41102.anarsoul@gmail.com>
	<20091022190524.GB8096@trinity.fluff.org>
Message-ID: <200910230857.35780.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 22 ??????? 2009 22:05:24 ????? Ben Dooks ???????:

> > -	client->select_cb(client, 1);
> > +	if (!client->selected) {
> > +		client->selected = 1;
> > +		client->select_cb(client, 1);
> > +	}
> 
> You seem to have added something other than just a bugfix to this patch,
> you've changed the behaviour of the select callback. Is this really
> necessary for the function of the fix or something that dropped in by
> accident?

No, select callback behaviour is not changed, this check is necessary to avoid 
calling select callback when client was already selected (for example, after 
resuming from suspend)
 
> >  	writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
> >  	       adc->regs + S3C2410_ADCCON);
> > +	/* Schedule task if there are clients pending. */
> > +	if (!list_empty(&adc_pending) || adc_dev->ts_pend) {
> > +		INIT_WORK(&resume_work, adc_resume_work);
> > +		if (!schedule_work(&resume_work))
> > +			dev_err(&pdev->dev,
> > +				"Failed to schedule adc_resume work!\n");
> > +	}
> 
> Is the work being used here to avoid trying to do things that may
> sleep? IIRC, none of the calls should need to sleep.

It's used to prevent calling callbacks (that may sleep) in atomic context 
(AFAIK resume handler is in atomic context)
 
> I was just wondering whether it would be better to abort any calls in
> progress before sleep and get the clients themselves to restart once
> they themselves have been resumed. We may end up with the case where the
> callbacks are being triggered before the client has been resumed.

Maybe, but sometimes it's tricky to abort waiting for callback in client 
driver. Anyway, resume_work will be called only after all drivers has been 
resumed, so situation when callbacks are being triggered before the client has 
been resumed is impossible.

Regards,
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091023/d2de15d2/attachment.sig>
