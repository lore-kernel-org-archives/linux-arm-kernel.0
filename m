From: johannes@sipsolutions.net (Johannes Berg)
Date: Thu, 27 Apr 2017 10:22:12 +0200
Subject: [PATCH 1/2] wcn36xx: Pass used skb to ieee80211_tx_status()
In-Reply-To: <20170426220444.10539-1-bjorn.andersson@linaro.org>
 (sfid-20170427_000624_047560_805C9599)
References: <20170426220444.10539-1-bjorn.andersson@linaro.org>
 (sfid-20170427_000624_047560_805C9599)
Message-ID: <1493281332.2529.1.camel@sipsolutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> @@ -371,7 +371,7 @@ static void reap_tx_dxes(struct wcn36xx *wcn,
> struct wcn36xx_dxe_ch *ch)
> ?			info = IEEE80211_SKB_CB(ctl->skb);
> ?			if (!(info->flags &
> IEEE80211_TX_CTL_REQ_TX_STATUS)) {
> ?				/* Keep frame until TX status comes
> */
> -				ieee80211_free_txskb(wcn->hw, ctl-
> >skb);
> +				ieee80211_tx_status(wcn->hw, ctl-
> >skb);
> 

I don't think this is a good idea. This code intentionally checked if
TX status was requested, and if not then it doesn't go to the effort of
building it.

As it is with your patch, it'll go and report the TX status without any
TX status information - which is handled in wcn36xx_dxe_tx_ack_ind()
for those frames needing it.

johannes
