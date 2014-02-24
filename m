From: kvalo@qca.qualcomm.com (Kalle Valo)
Date: Mon, 24 Feb 2014 18:52:53 +0200
Subject: [BISECTED] ssh - Received disconnect from x.x.x.x: 2: Bad packet
 length 3149594624
In-Reply-To: <20140214162458.GF21986@mudshark.cambridge.arm.com> (Will
 Deacon's message of "Fri, 14 Feb 2014 16:24:58 +0000")
References: <52FD08D1.3030405@gmail.com>
 <20140213182105.GN13576@mudshark.cambridge.arm.com>
 <52FD1243.9040706@gmail.com>
 <20140213192909.GO13576@mudshark.cambridge.arm.com>
 <52FE407C.3080002@gmail.com>
 <20140214162458.GF21986@mudshark.cambridge.arm.com>
Message-ID: <877g8ktpui.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:
> Well, we probably need a bit more to go on, because I doubt that this code
> is to blame. More likely, the issue is in the caller.
> Looking at drivers/net/wireless/ti/wl1251/rx.c:182
>
>         /* The actual length doesn't include the target's alignment */
>         skb->len = desc->length  - PLCP_HEADER_LENGTH;
>
>         fc = (u16 *)skb->data;
>
>         if ((*fc & IEEE80211_FCTL_STYPE) == IEEE80211_STYPE_BEACON)
>                 beacon = 1;
>
>         wl1251_rx_status(wl, desc, &status, beacon);
>
>         wl1251_debug(DEBUG_RX, "rx skb 0x%p: %d B %s", skb, skb->len,
>                      beacon ? "beacon" : "");
>
>         memcpy(IEEE80211_SKB_RXCB(skb), &status, sizeof(status));
>         ieee80211_rx_ni(wl->hw, skb);
>
> I wonder whether that first line (with the comment about alignment) is
> assuming some behaviour from the mac80211 layer.
>
> You could try putting back the UNALIGNED_ACCESS in net/mac80211/rx.c and
> commenting out the skb->len = desc->length  - PLCP_HEADER_LENGTH;  line
> above.
>
> Adding the original author (I think) and John Linville, since I'm well out
> of my depth in this code!

I haven't touched wl1251 for years. You should send questions to
linux-wireless list and CC people who have worked on it recently.

-- 
Kalle Valo
