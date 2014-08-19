From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Tue, 19 Aug 2014 11:31:59 -0700
Subject: [PATCH v4 2/2] net: moxa: replace build_skb() with
 netdev_alloc_skb_ip_align() / memcpy()
In-Reply-To: <1408459784-9385-2-git-send-email-jonas.jensen@gmail.com>
References: <1408459784-9385-1-git-send-email-jonas.jensen@gmail.com>
 <1408459784-9385-2-git-send-email-jonas.jensen@gmail.com>
Message-ID: <1408473119.5604.4.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-08-19 at 16:49 +0200, Jonas Jensen wrote:
> build_skb() is used to make skbs out of existing RX ring memory
> which is bad because the RX ring is allocated only once, on probe.
> Memory corruption occur because said memory is reclaimed, i.e.
> __kfree_skb() (and eventually put_page()).
> 
> Replace build_skb() with netdev_alloc_skb_ip_align() and use memcpy().
> Also, synchronize DMA memory before passing skb to napi_gro_receive().
> 
> Addresses https://bugzilla.kernel.org/show_bug.cgi?id=69041

Wow, this driver was really buggy.

Patch is not complete.

Instead of :

priv->rx_buf_size = RX_BUF_SIZE + 
		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));

I think rx_buf_size can now be RX_BUF_SIZE

Another point is that priv->stats seems not needed, as ndev->stats could
be used instead (and remove moxart_mac_get_stats())
