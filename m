From: johannes@sipsolutions.net (Johannes Berg)
Date: Wed, 17 May 2017 15:14:27 +0200
Subject: [PATCH 1/2] wcn36xx: Pass used skb to ieee80211_tx_status()
In-Reply-To: <87fugkrchl.fsf@kamboji.qca.qualcomm.com>
References: <20170426220444.10539-1-bjorn.andersson@linaro.org>
 <1493281332.2529.1.camel@sipsolutions.net>	<20170428234247.GQ15143@minitux>
 <87fugkrchl.fsf@kamboji.qca.qualcomm.com>
Message-ID: <1495026867.2442.9.camel@sipsolutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-05-04 at 13:13 +0000, Kalle Valo wrote:
> 
> > > This code intentionally checked if TX status was requested, and
> > > if not then it doesn't go to the effort of building it.
> > > 
> > 
> > What I'm finding puzzling is the fact that the only caller of
> > ieee80211_led_tx() is ieee80211_tx_status() and it seems like
> > drivers, such as ath10k, call this for each packet handled - but
> > I'm likely missing something.

Yes, many drivers do call it for each packet, and as such, this
deficiency was never noted.

> > > As it is with your patch, it'll go and report the TX status
> > > without any
> > > TX status information - which is handled in
> > > wcn36xx_dxe_tx_ack_ind()
> > > for those frames needing it.
> > > 
> > 
> > Right, it doesn't sound desired. However, during normal operation
> > I'm not seeing IEEE80211_TX_CTL_REQ_TX_STATUS being set and as such
> > ieee80211_led_tx() is never called.
> 
> So what's the conclusion? How do we get leds working?

Well, frankly, I never thought the TX LED was a super good idea - but
it had been supported by the original code IIRC, so never removed. Some
people like frantic blinking I guess ;-)

But I think the problem also applies to the throughput trigger thing,
so perhaps we need to stick some LED feedback calls into other places,
like _noskb() or provide an extra way to do it?

johannes
