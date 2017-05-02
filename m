From: rafalo@cadence.com (Rafal Ozieblo)
Date: Tue, 2 May 2017 13:57:15 +0000
Subject: [PATCH 3/4] net: macb: Add hardware PTP support
In-Reply-To: <20170414182850.GB7751@localhost.localdomain>
References: <1492090439-11793-1-git-send-email-rafalo@cadence.com>
 <1492090763-15686-1-git-send-email-rafalo@cadence.com>
 <20170414182850.GB7751@localhost.localdomain>
Message-ID: <BN3PR07MB2516757CB4EA7367F6623C06C9170@BN3PR07MB2516.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Richard Cochran [mailto:richardcochran at gmail.com]
> Sent: 14 kwietnia 2017 20:29
> To: Rafal Ozieblo <rafalo@cadence.com>
> Cc: David Miller <davem@davemloft.net>; nicolas.ferre at atmel.com;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> harinikatakamlinux at gmail.com; harini.katakam at xilinx.com;
> Andrei.Pistirica at microchip.com
> Subject: Re: [PATCH 3/4] net: macb: Add hardware PTP support
> 
> On Thu, Apr 13, 2017 at 02:39:23PM +0100, Rafal Ozieblo wrote:
(...)
> > +static int gem_tsu_get_time(struct macb *bp, struct timespec64 *ts)
> > +{
> > +	long first, second;
> > +	u32 secl, sech;
> > +	unsigned long flags;
> > +
> > +	if (!bp || !ts)
> > +		return -EINVAL;
> 
> Useless test.
Sorry for me being too carefulness, I'll remove all tests.
> 
(...)
> > +static int gem_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64
> *ts)
> > +{
> > +	struct macb *bp = container_of(ptp, struct macb, ptp_clock_info);
> > +
> > +	if (!ptp || !ts)
> > +		return -EINVAL;
> 
> Useles test.
> 
> What is the point of this wrapper function anyhow?  Please remove it.
gem_ptp_gettime() is assigned in ptp_clock_info and it has to have 
ptp_clock_info pointer as first parameter. gem_tsu_get_time() is used in
the source code but with macb pointer.
Do you want me to do something like:
gem_ptp_gettime(macb->ptp, ts);
and first would be getting macb pointer from ptp ?
struct macb *bp = container_of(ptp, struct macb, ptp_clock_info);
> 
> > +
> > +	gem_tsu_get_time(bp, ts);
> > +	return 0;
> > +}
> > +
> > +static int gem_ptp_settime(struct ptp_clock_info *ptp,
> > +		const struct timespec64 *ts)
> > +{
> > +	struct macb *bp = container_of(ptp, struct macb, ptp_clock_info);
> > +
> > +	if (!ptp || !ts)
> > +		return -EINVAL;
> 
> Another useless function.
ditto
> 
> > +	gem_tsu_set_time(bp, ts);
> > +	return 0;
> > +}
> > +
> > +static int gem_ptp_enable(struct ptp_clock_info *ptp,
> > +			  struct ptp_clock_request *rq, int on)
> > +{
> > +	struct macb *bp = container_of(ptp, struct macb, ptp_clock_info);
> > +
> > +	if (!ptp || !rq)
> > +		return -EINVAL;
> 
> Sigh.
> 
> > +
> > +	switch (rq->type) {
> > +	case PTP_CLK_REQ_EXTTS:	/* Toggle TSU match interrupt */
> > +		if (on)
> > +			macb_writel(bp, IER, MACB_BIT(TCI));
> 
> No locking to protect IER and IDE?
There is no need.
> 
> > +		else
> > +			macb_writel(bp, IDR, MACB_BIT(TCI));
> > +		break;
> > +	case PTP_CLK_REQ_PEROUT: /* Toggle Periodic output */
> > +		return -EOPNOTSUPP;
> > +		/* break; */
> > +	case PTP_CLK_REQ_PPS:	/* Toggle TSU periodic (second)
> interrupt */
> > +		if (on)
> > +			macb_writel(bp, IER, MACB_BIT(SRI));
> > +		else
> > +			macb_writel(bp, IDR, MACB_BIT(SRI));
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +	return 0;
> > +}
> > +
(...)
> > --
> > 2.4.5
> >
> 
> Thanks,
> Richard
