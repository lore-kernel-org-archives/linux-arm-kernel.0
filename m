From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Mon, 14 Jun 2010 11:32:37 +0200
Subject: [PATCH 1/2 v2] mv643xx_eth: use sw csum for big packets
In-Reply-To: <FCBE654890C0334289D0AD3AF4EF009F9FAC7B6E2B@IL-MB01.marvell.com>
References: <FCBE654890C0334289D0AD3AF4EF009F9FAC75A69C@IL-MB01.marvell.com>
	<1276073483-17208-1-git-send-email-saeed@marvell.com>
	<20100610064330.GK1743@mail.wantstofly.org>
	<FCBE654890C0334289D0AD3AF4EF009F9FAC75AA96@IL-MB01.marvell.com>
	<20100612083137.GO1743@mail.wantstofly.org>
	<FCBE654890C0334289D0AD3AF4EF009F9FAC7B6E2B@IL-MB01.marvell.com>
Message-ID: <20100614093237.GG14513@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 13, 2010 at 10:38:10AM +0300, Saeed Bishara wrote:

> >> >> @@ -2666,6 +2668,9 @@ static int 
> >> >mv643xx_eth_shared_probe(struct platform_device *pdev)
> >> >>  	 * Detect hardware parameters.
> >> >>  	 */
> >> >>  	msp->t_clk = (pd != NULL && pd->t_clk != 0) ? pd->t_clk 
> >> >: 133000000;
> >> >> +	msp->tx_csum_limit = pd->tx_csum_limit ? 
> >> >pd->tx_csum_limit : 9 * 1024;
> >> >> +	/* add header count so we can compare against skb->len */
> >> >> +	msp->tx_csum_limit += ETH_HLEN;
> >> >>  	infer_hw_params(msp);
> >> >
> >> >Is the limit 9 * 1024 + 14 for the whole packet, or 9 * 
> >1024 for the IP
> >> >part?
> >>
> >> the limit is for the IP part, but I thought that adding the 
> >header length, then comparing agains skb->len will be the 
> >same. What do you suggest?
> >
> >Right, but for the header length you take 14, while if to include VLAN
> >tags or DSA tags the header might actually be longer -- how does that
> >affect the ability of the hardware to compute the checksum?
> >
> >I.e. is the restriction "total packet length must be < N + 14 bytes"
> >or is it "the IP part must be < N bytes and it doesn't matter whether
> >there are VLAN tags or not"?
>
> It's the second option: "the IP part must be < N" regardless to the L2 header.

Then I suppose you want to do something like:

	int hdr_len;
	int tag_bytes;

	hdr_len = (void *)ip_hdr(skb) - (void *)skb->data;
	tag_bytes = hdr_len - 4;
	if (skb->len - hdr_len > the limit || unlikely(tag_bytes & ~12)) {

(And then keep the limit as maximum number of bytes in the packet
starting from the IP header part.)
