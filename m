From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Fri, 14 Feb 2014 18:12:44 +0200
Subject: [BISECTED] ssh - Received disconnect from x.x.x.x: 2: Bad packet
 length 3149594624
In-Reply-To: <20140213192909.GO13576@mudshark.cambridge.arm.com>
References: <52FD08D1.3030405@gmail.com>
 <20140213182105.GN13576@mudshark.cambridge.arm.com>
 <52FD1243.9040706@gmail.com>
 <20140213192909.GO13576@mudshark.cambridge.arm.com>
Message-ID: <52FE407C.3080002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13.02.2014 21:29, Will Deacon wrote:
>
> Can you try hacking crypto/memneq.c so that it doesn't use
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS please? That would at least point the
> finger at net/mac80211/rx.c or similar.
>
> Cheers,
>
> Will
>

Well, I am lazy so I hacked net/mac80211/rx.c first:

index c24ca0d..6839c77 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1963,7 +1963,7 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
                 }
         }

-#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+//#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
         if (skb) {
                 /* 'align' will only take the values 0 or 2 here since all
                  * frames are required to be aligned to 2-byte boundaries
@@ -1987,7 +1987,7 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
                         }
                 }
         }
-#endif
+//#endif

         if (skb) {
                 /* deliver to local stack */


and that seems to fix the problem.

I am not sure whom I should forward the problem.

Thanks,
Ivo
