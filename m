From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 3 May 2017 11:43:04 +0200
Subject: [PATCH 3/4] net: macb: Add hardware PTP support
In-Reply-To: <BN3PR07MB2516757CB4EA7367F6623C06C9170@BN3PR07MB2516.namprd07.prod.outlook.com>
References: <1492090439-11793-1-git-send-email-rafalo@cadence.com>
 <1492090763-15686-1-git-send-email-rafalo@cadence.com>
 <20170414182850.GB7751@localhost.localdomain>
 <BN3PR07MB2516757CB4EA7367F6623C06C9170@BN3PR07MB2516.namprd07.prod.outlook.com>
Message-ID: <20170503094304.GD2340@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 02, 2017 at 01:57:15PM +0000, Rafal Ozieblo wrote:
> > What is the point of this wrapper function anyhow?  Please remove it.
> gem_ptp_gettime() is assigned in ptp_clock_info and it has to have 
> ptp_clock_info pointer as first parameter. gem_tsu_get_time() is used in
> the source code but with macb pointer.
> Do you want me to do something like:
> gem_ptp_gettime(macb->ptp, ts);
> and first would be getting macb pointer from ptp ?
> struct macb *bp = container_of(ptp, struct macb, ptp_clock_info);

Yes.  Unless your sub-function is used in more than one place, then it
is wasteful and confusing to wrap the functionality for no apparent
reason.

> > > +	switch (rq->type) {
> > > +	case PTP_CLK_REQ_EXTTS:	/* Toggle TSU match interrupt */
> > > +		if (on)
> > > +			macb_writel(bp, IER, MACB_BIT(TCI));
> > 
> > No locking to protect IER and IDE?
> There is no need.

But what happens when the PTP_CLK_REQ_EXTTS and PTP_CLK_REQ_PPS ioctls
are called at the same time?

You need to ensure that IDR is consistent.  If the bits are write
only, then you should comment this fact.

> > > +		else
> > > +			macb_writel(bp, IDR, MACB_BIT(TCI));
> > > +		break;
> > > +	case PTP_CLK_REQ_PEROUT: /* Toggle Periodic output */
> > > +		return -EOPNOTSUPP;
> > > +		/* break; */
> > > +	case PTP_CLK_REQ_PPS:	/* Toggle TSU periodic (second)
> > interrupt */
> > > +		if (on)
> > > +			macb_writel(bp, IER, MACB_BIT(SRI));
> > > +		else
> > > +			macb_writel(bp, IDR, MACB_BIT(SRI));
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > > +	return 0;
> > > +}

Thanks,
Richard
