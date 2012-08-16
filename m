From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 16 Aug 2012 10:08:04 +0200
Subject: [rtc-linux] [PATCH v3] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20120815133221.ca88d4ba.akpm@linux-foundation.org>
References: <1342164663-31351-1-git-send-email-shawn.guo@linaro.org>
 <20120814170300.8f97afcf.akpm@linux-foundation.org>
 <20120815141606.GA2457@S2101-09.ap.freescale.net>
 <20120815133221.ca88d4ba.akpm@linux-foundation.org>
Message-ID: <20524.43620.36859.792122@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Andrew Morton writes:
> On Wed, 15 Aug 2012 22:16:10 +0800
> Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > Thanks for looking at the patch, Andrew.
> > 
> > On Tue, Aug 14, 2012 at 05:03:00PM -0700, Andrew Morton wrote:
> > > On Fri, 13 Jul 2012 15:31:03 +0800
> > > Shawn Guo <shawn.guo@linaro.org> wrote:
> > > 
> > > > +static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
> > > > +{
> > > > +	unsigned long timeout = jiffies + msecs_to_jiffies(1);
> > > > +	unsigned long flags;
> > > > +	u32 lpcr;
> > > > +
> > > > +	spin_lock_irqsave(&data->lock, flags);
> > > > +
> > > > +	lpcr = readl(data->ioaddr + SNVS_LPCR);
> > > > +	if (enable)
> > > > +		lpcr |= SNVS_LPCR_SRTC_ENV;
> > > > +	else
> > > > +		lpcr &= ~SNVS_LPCR_SRTC_ENV;
> > > > +	writel(lpcr, data->ioaddr + SNVS_LPCR);
> > > > +
> > > > +	spin_unlock_irqrestore(&data->lock, flags);
> > > > +
> > > > +	while (1) {
> > > > +		lpcr = readl(data->ioaddr + SNVS_LPCR);
> > > > +
> > > > +		if (enable) {
> > > > +			if (lpcr & SNVS_LPCR_SRTC_ENV)
> > > > +				break;
> > > > +		} else {
> > > > +			if (!(lpcr & SNVS_LPCR_SRTC_ENV))
> > > > +				break;
> > > > +		}
> > > > +
> > > > +		if (time_after(jiffies, timeout))
> > > > +			return -ETIMEDOUT;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > 
> > > The timeout code here is fragile.  If acquiring the spinlock takes more
> > > than a millisecond or if this thread gets interrupted or preempted then
> > > we could easily execute that loop just a single time, and fail.
> > > 
> > So what about moving the timeout initialization to right above the
> > while(1) loop?
> 
> It still has the same problem - a well-timed preemption would cause a
> timeout.
> 
> > > It would be better to retry a fixed number of times, say 1000?  That
> > > would take around 1 millisecond, but might be overkill.
> > > 
> > How long a 1000 times loop takes really depends on the cpu frequency,
> > right?
> 
> No, it will depend on the preiod of that readl(), which typically takes
> much much longer than a cpu cycle.  It depends a lot on the bus type
> but I'd guess that the readl would take 100's of nanoseconds.  Thus we
> can use the expected readl duration to control the timeout interval.
> 
Why not read the register once more in case of a timeout, which
would guarantee to have a current view of the register contents no
matter how long the process may have been descheduled before:

[...]
static int snvs_rtc_enable_done(int enable, void __iomem *addr)
{
	u32 lpcr = readl(addr + SNVS_LPCR);

	return !!enable ^ !(lpcr & SNVS_LPCR_SRTC_ENV);
}
[...]
	while (1) {
		if (svns_rtc_enable_done(enable, data->ioaddr))
			break;

		if (time_after(jiffies, timeout)) {
			if (!svns_rtc_enable_done(enable, data->ioaddr))
				return -ETIMEDOUT;
		}
	}


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
