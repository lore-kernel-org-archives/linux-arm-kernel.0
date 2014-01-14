From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Tue, 14 Jan 2014 16:24:06 +0100
Subject: build_skb() and data corruption
In-Reply-To: <1389620539.3720.157.camel@deadeye.wl.decadent.org.uk>
References: <CACmBeS35RAEQ+t2vtYtFTKNT-VdQw20hURjTi193Jk8HG7UECA@mail.gmail.com>
 <1389620539.3720.157.camel@deadeye.wl.decadent.org.uk>
Message-ID: <CACmBeS1gTfdjwiCkHMViOnF6G2zjy3HSMm3NVq8Jiq5F22ynJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the replies, you led me to a new solution,


I now think build_skb() is not the right choice, my motivation for
using it in the first place, that I thought it meant getting away with
not copying memory.

build_skb() is replaced by netdev_alloc_skb_ip_align() and memcpy()
(derived from drivers/net/ethernet/realtek/r8169.c).

Read errors are gone, even without syncing DMA. Is it a good idea to
do it anyway, i.e. leave calls to dma_sync_single_* in?

Also, without build_skb(), kmalloc memory can be used (frag_size > 0),
memory is used more efficiently, at least half of a page times 64
previously wasted.

New code here:
https://bitbucket.org/Kasreyn/linux-next/src/92f5aeb3b58f8d8dffd9178b6b5ff46217156caa/drivers/net/ethernet/moxa/moxart_ether.c#cl-424


Thanks,
Jonas
