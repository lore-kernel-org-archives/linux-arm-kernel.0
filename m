From: dongas86@gmail.com (Dong Aisheng)
Date: Mon, 19 Jun 2017 23:36:39 +0800
Subject: [PATCH V2 2/2] timer: imx-tpm: add imx tpm timer support
In-Reply-To: <2318694.E4xdUbedMD@ws-stein>
References: <1497340725-26594-1-git-send-email-aisheng.dong@nxp.com>
 <1497340725-26594-3-git-send-email-aisheng.dong@nxp.com>
 <2318694.E4xdUbedMD@ws-stein>
Message-ID: <20170619153638.GB8913@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 10:19:47AM +0200, Alexander Stein wrote:
> On Tuesday 13 June 2017 15:58:45, Dong Aisheng wrote:
> > diff --git a/drivers/clocksource/timer-imx-tpm.c
> > b/drivers/clocksource/timer-imx-tpm.c new file mode 100644
> > index 0000000..940a4f75
> > --- /dev/null
> > +++ b/drivers/clocksource/timer-imx-tpm.c
> > @@ -0,0 +1,227 @@
> > [...]
> > +static int tpm_set_next_event(unsigned long delta,
> > +				struct clock_event_device *evt)
> > +{
> > +	unsigned long next, now;
> > +
> > +	next = readl(timer_base + TPM_CNT) + delta;
> > +	writel(next, timer_base + TPM_C0V);
> > +	now = readl(timer_base + TPM_CNT);
> 
> What about:
> > now = readl(timer_base + TPM_CNT);
> > next = now + delta;
> > writel(next, timer_base + TPM_C0V);
> > return 0;
> 
> > +	return (int)((next - now) <= 0) ? -ETIME : 0;
> 
> Can this error actually happen, even with your implementation?

Yes, i did observe some -ETIME when testing with nanosleep or
hrtimer during programing min_delta event, especially when system
is high loading. e.g. run GPU stress test.

Please also refer to another mail for details i just replied to Daniel.

Regards
Dong Aisheng
