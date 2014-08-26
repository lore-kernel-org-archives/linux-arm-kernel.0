From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Tue, 26 Aug 2014 03:55:30 -0700
Subject: [PATCH v6 2/4] net: moxa: replace build_skb() with
 netdev_alloc_skb_ip_align() / memcpy()
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1748126F@AcuExch.aculab.com>
References: <1408544342-32058-1-git-send-email-jonas.jensen@gmail.com>
 <1408976542-15624-1-git-send-email-jonas.jensen@gmail.com>
 <4449672.aCJ5J5rv4r@wuerfel>
 <063D6719AE5E284EB5DD2968C1650D6D1748126F@AcuExch.aculab.com>
Message-ID: <1409050530.3173.12.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-08-26 at 09:10 +0000, David Laight wrote:
> From: Arnd Bergmann

> > While this seems correct, I wonder why you don't do the normal approach of
> > dequeuing the skb from the chain and adding a newly allocated skb to it to
> > save the memcpy.
> 
> Because the receive buffer area isn't made of skbs.
> Post-allocating the skb also reduces the 'true size' of the skb.

This strategy assumes this is not a 10Gbe NIC.

We try to avoid copies because they are generally not needed.

Wifi devices are usually slow, and packet losses are more frequent, so
the copybreak gives better chance to not doing the collapses [1] later
in the TCP stack.

[1] collapses : reducing skb overhead (skb->len / skb->truesize ratio)
