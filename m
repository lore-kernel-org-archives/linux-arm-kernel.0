From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 21 Aug 2014 11:56:08 +0100
Subject: [PATCH v2 6/9] arm: mediatek: enable gpt6 on boot up to make
 arch timer working
In-Reply-To: <CABuKBe+oVzQ9_Q__sULLQt8OvJ1Za_uA5x2aXSSQ6r8myvFqnA@mail.gmail.com>
References: <1408373917-10002-1-git-send-email-matthias.bgg@gmail.com>
 <1408373917-10002-7-git-send-email-matthias.bgg@gmail.com>
 <20140818154548.GA3302@leverpostej>
 <CABuKBe+oVzQ9_Q__sULLQt8OvJ1Za_uA5x2aXSSQ6r8myvFqnA@mail.gmail.com>
Message-ID: <20140821105608.GK21734@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 11:38:20AM +0100, Matthias Brugger wrote:
> 2014-08-18 17:45 GMT+02:00 Mark Rutland <mark.rutland@arm.com>:
> > Hi Matthias,
> >
> > On Mon, Aug 18, 2014 at 03:58:34PM +0100, Matthias Brugger wrote:
> >> We enable GTP6 which ungates the arch timer clock. Apart we write the
> >> frequency with which the timer is running in the CNTFREQ register.
> >
> > We don't seem to set CNTFRQ below. Does it happen to have a consistent
> > value on current versions of the bootloader?
> 
> Oh sorry, my fault. In v2 I moved the frequency to the dts, as this
> will make the driver write CNTFRQ.
> I forgot to update the commit message.

The arch timer driver does not write CNTFRQ as this can only be done
from the secure side. It simply uses the value provided internally. This
isn't sufficient for virtualization guests (which need to have CNTFRQ
programmed correctly).

For the moment as we're not booting at Hyp that's not necessarily a big
problem, but it is a shame.

> >> In the future this should be done in the bootloader.
> >
> > Do we know how far in the future that's likely to be?
> 
> AFAIK no one right now is working on an open source bootloader for the
> mediatek devices.
> So I think we won't see an open source bootloader in a reasonable time.
 
Ok. :(

> > What's the plan for this code when such a bootloader becomes available?
> 
> I think when a bootloader becomes available, this code should be
> removed. I know that this will lead to a not working ARM arch timer in
> devices which don't migrate to the new bootloader, but I think it's
> not too critical. Apart from the ARM arch timer, the devices have the
> mediatek global porpose timer (drivers/clocksource/mtk_timer.c), which
> implement a clock source and a clock event timer. So the system won't
> hang.

I fear that's never going to happen, either because such a bootloader
never becomes available or because there will be hold-outs sticking to
the old loader.

If that's not critical, why not for the moment use the global timer?

Thanks,
Mark.
