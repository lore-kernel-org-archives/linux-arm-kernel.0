From: rafalo@cadence.com (Rafal Ozieblo)
Date: Mon, 2 Jan 2017 09:36:10 +0000
Subject: [RFC PATCH net-next v4 1/2] macb: Add 1588 support in Cadence GEM.
References: <1481720175-12703-1-git-send-email-andrei.pistirica@microchip.com> 
Message-ID: <BN3PR07MB2516815EDE69ACDCE27F81A3C96F0@BN3PR07MB2516.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rafal Ozieblo 
> Sent: 28 grudnia 2016 14:23
> Subject: RE: [RFC PATCH net-next v4 1/2] macb: Add 1588 support in Cadence GEM.
> 
> > +static void gem_ptp_tx_hwtstamp(struct macb *bp, struct sk_buff *skb,
> > +				int peer_ev)
> > +{
> > +	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
> > +	struct timespec64 ts;
> > +	u64 ns;
> > +
> > +	/* PTP Peer Event Frame packets */
> > +	if (peer_ev) {
> > +		ts.tv_sec = gem_readl(bp, PEFTSL);
> > +		ts.tv_nsec = gem_readl(bp, PEFTN);
> > +
> > +	/* PTP Event Frame packets */
> > +	} else {
> > +		ts.tv_sec = gem_readl(bp, EFTSL);
> > +		ts.tv_nsec = gem_readl(bp, EFTN);
> > +	}
> I'm wondering what is a difference between timestamp in transmit buffer descriptor (Word 2 and 3) and PTP Event Frame Transmitted Seconds/Nanoseconds Register (0x1E0, 0x1E4).
> 
According Cadence Hardware team:
"It is just that some customers prefer to have the time in the descriptors as that is provided per frame.
The registers are simply overwritten when a new event frame is transmitted/received and so software could miss it."
The question is are you sure that you read timestamp for current frame? (not for the next frame).
