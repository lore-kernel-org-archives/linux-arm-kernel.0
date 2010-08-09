From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Aug 2010 11:21:50 +0100
Subject: [PATCH 1/1] arm: kernel: idle loop pm constraints
In-Reply-To: <62697B07E9803846BC582181BD6FB6B82B994E2860@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1281086261-23908-1-git-send-email-samu.p.onkalo@nokia.com>
	<1281086261-23908-2-git-send-email-samu.p.onkalo@nokia.com>
	<20100807141443.GA8687@n2100.arm.linux.org.uk>
	<62697B07E9803846BC582181BD6FB6B82B994E2860@NOK-EUMSG-02.mgdnok.nokia.com>
Message-ID: <20100809102150.GB10793@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 09, 2010 at 12:12:47PM +0200, samu.p.onkalo at nokia.com wrote:
> >-----Original Message-----
> >From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> >Sent: 07 August, 2010 17:15
> >To: Onkalo Samu.P (Nokia-MS/Tampere)
> >Cc: linux-arm-kernel at lists.infradead.org
> >Subject: Re: [PATCH 1/1] arm: kernel: idle loop pm constraints
> >
> >It's pointless to repeatedly call schedule() if need_resched() is not
> >set -
> >and the need_resched() check is extremely cheap.
> 
> True. But point is that we can't allow cpu to go to idle or even prepare
> for idle.  However it is little bit better to run locally small loop when
> there is no need to schedule instead of continuous scheduling for nothing.

I don't buy these kinds of arguments - especially when they end up
breaking stuff.

> >In any case, the parts that you're cutting out are the calls to
> >leds_event() down to tick_nohz_restart_sched_tick().  Do you know
> >where the additional latency comes from?  Is it the code in the
> >pm_idle() hook?
> 
> pm_idle is not the problem. Neither the leds_events. tick*() functions
> seems to take 0 - 120 us each. In worst case over 200 us together.
> 
> If the interrupt arrives when tick_nohz_stop_sched_tick() is just called,
> irqs are disabled.  Rescheduling needs are noticed in the worst case after
> the 120 us. It may take about the same time when going out. pm_idle is not
> called in this case.

120us - 200us does seem rather excessive.  Maybe this should be reported to
the time subsystem maintainers.
