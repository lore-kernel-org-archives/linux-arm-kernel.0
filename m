From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 5 Feb 2013 19:22:11 +0100
Subject: [rtc-linux] [RFC] ARM i.MX: rtc: change interrupt handling for
 DryIce
In-Reply-To: <20130131145511.a5da8800.akpm@linux-foundation.org>
References: <1359641777-975-1-git-send-email-s.trumtrar@pengutronix.de>
 <20130131145511.a5da8800.akpm@linux-foundation.org>
Message-ID: <20130205182211.GB27438@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 02:55:11PM -0800, Andrew Morton wrote:
> On Thu, 31 Jan 2013 15:16:17 +0100
> Steffen Trumtrar <s.trumtrar@pengutronix.de> wrote:
> 
> > di_write_wait uses a very short timeout of 1ms for the wait_queue.
> > This may lead to write errors to some registers. Write errors to DCAMR and
> > DSR_CAF where the only one observed, though:
> > 
> > Tue Jan 14 15:32:23 2014  -0.985304 seconds
> > Tue Jan 14 15:32:24 2014  -0.985236 seconds
> > Tue Jan 14 15:32:25 2014  -0.986601 seconds
> > imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x52d5588a reg = 0x00000008
> > Tue Jan 14 15:32:26 2014  -0.983772 seconds
> > Tue Jan 14 15:32:27 2014  -0.983594 seconds
> > imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x52d5588c reg = 0x00000008
> > Tue Jan 14 15:32:28 2014  -0.983596 seconds
> > imxdi_rtc 53ffc000.dryice: Write-wait timeout val = 0x52d5588d reg = 0x00000008
> > Tue Jan 14 15:32:29 2014  -0.983300 seconds
> > Tue Jan 14 15:32:30 2014  -0.982809 seconds
> > 
> > Just increasing this timeout leads to a race condition in the interrupt handler.
> > After a couple minutes of running
> > 	while true; do hwclock; done
> > the interrupt isn't handled by the driver and disabled in the process.
> > This seems to be because of the waitqueue check and then returning out of the
> > handler, as there is no other handler that takes over.
> > 
> > Use wait_event_interruptible without a timeout instead and do not leave the
> > interrupt handler in case of an empty waitqueue, but handle the actual irq case.
> > As before, nothing is done in that case though.
> > 
> 
> The patch makes changes which aren't described in the above changelog:
> 
> - Fiddles with the new DIER_SVIE
> 
> - Enables the DIER_WEIE interrupt
> 

Yes. I should mention that in the changelog.

> > @@ -168,15 +169,18 @@ static int di_write_wait(struct imxdi_dev *imxdi, u32 val, int reg)
> >  	__raw_writel(val, imxdi->ioaddr + reg);
> >  
> >  	/* wait for the write to finish */
> > -	ret = wait_event_interruptible_timeout(imxdi->write_wait,
> > -			imxdi->dsr & (DSR_WCF | DSR_WEF), msecs_to_jiffies(1));
> > -	if (ret < 0) {
> > +	ret = wait_event_interruptible(imxdi->write_wait, imxdi->dsr &
> > +					(DSR_WCF | DSR_WEF));
> > +
> > +	if (ret <= 0) {
> >  		rc = ret;
> >  		goto out;
> > -	} else if (ret == 0) {
> > +	} else if (ret > 0) {
> >  		dev_warn(&imxdi->pdev->dev,
> >  				"Write-wait timeout "
> >  				"val = 0x%08x reg = 0x%08x\n", val, reg);
> > +		rc = -ERESTARTSYS;
> > +		goto out;
> >  	}
> 
> This code looks all confused.  wait_event_interruptible() can only
> return two things: zero or -ERESTARTSYS.  That code which handles (ret
> > 0) will never be executed.
> 

You are obviously right. I wonder how I came to the conclusion, that it is
otherwise...
What I really wondered about is, if it is okay to use wait_event_interruptible
here instead of wait_event_interruptible_timeout. Is that a bad idea ? Can the
__raw_writel go wrong so that the RTC will never issue an IRQ?

> di_write_wait() should return -ERESTARTSYS if
> wait_event_interruptible() returned -ERESTARTSYS and it should return 0
> if wait_event_interruptible() returned 0.  So local variable `ret' can
> just go away.  Although I'd suggest then renaming `rc' to `ret', as the
> latter is more conventional.
> 
Agreed.

Thanks,
Steffen


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
