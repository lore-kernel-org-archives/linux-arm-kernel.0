From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Feb 2014 16:24:58 +0000
Subject: [BISECTED] ssh - Received disconnect from x.x.x.x: 2: Bad packet
 length 3149594624
In-Reply-To: <52FE407C.3080002@gmail.com>
References: <52FD08D1.3030405@gmail.com>
 <20140213182105.GN13576@mudshark.cambridge.arm.com>
 <52FD1243.9040706@gmail.com>
 <20140213192909.GO13576@mudshark.cambridge.arm.com>
 <52FE407C.3080002@gmail.com>
Message-ID: <20140214162458.GF21986@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 04:12:44PM +0000, Ivaylo Dimitrov wrote:
> On 13.02.2014 21:29, Will Deacon wrote:
> >
> > Can you try hacking crypto/memneq.c so that it doesn't use
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS please? That would at least point the
> > finger at net/mac80211/rx.c or similar.
> >
> 
> Well, I am lazy so I hacked net/mac80211/rx.c first:

No problem, thanks for having a go.

> index c24ca0d..6839c77 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -1963,7 +1963,7 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
>                  }
>          }
> 
> -#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +//#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>          if (skb) {
>                  /* 'align' will only take the values 0 or 2 here since all
>                   * frames are required to be aligned to 2-byte boundaries
> @@ -1987,7 +1987,7 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
>                          }
>                  }
>          }
> -#endif
> +//#endif
> 
>          if (skb) {
>                  /* deliver to local stack */
> 
> 
> and that seems to fix the problem.
> 
> I am not sure whom I should forward the problem.

Well, we probably need a bit more to go on, because I doubt that this code
is to blame. More likely, the issue is in the caller.
Looking at drivers/net/wireless/ti/wl1251/rx.c:182

        /* The actual length doesn't include the target's alignment */
        skb->len = desc->length  - PLCP_HEADER_LENGTH;

        fc = (u16 *)skb->data;

        if ((*fc & IEEE80211_FCTL_STYPE) == IEEE80211_STYPE_BEACON)
                beacon = 1;

        wl1251_rx_status(wl, desc, &status, beacon);

        wl1251_debug(DEBUG_RX, "rx skb 0x%p: %d B %s", skb, skb->len,
                     beacon ? "beacon" : "");

        memcpy(IEEE80211_SKB_RXCB(skb), &status, sizeof(status));
        ieee80211_rx_ni(wl->hw, skb);

I wonder whether that first line (with the comment about alignment) is
assuming some behaviour from the mac80211 layer.

You could try putting back the UNALIGNED_ACCESS in net/mac80211/rx.c and
commenting out the skb->len = desc->length  - PLCP_HEADER_LENGTH;  line
above.

Adding the original author (I think) and John Linville, since I'm well out
of my depth in this code!

Will
