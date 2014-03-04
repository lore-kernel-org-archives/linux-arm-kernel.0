From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Tue, 4 Mar 2014 12:37:14 +0100
Subject: BUG_ON for DMA-bounce and bidirectional mappings (e100 on IXP4xx)
In-Reply-To: <20140304104528.GQ21483@n2100.arm.linux.org.uk>
References: <20140304112459.354f0980@marrow.netinsight.se>
 <20140304104528.GQ21483@n2100.arm.linux.org.uk>
Message-ID: <20140304123714.7e1fe704@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Mar 2014 10:45:28 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Tue, Mar 04, 2014 at 11:24:59AM +0100, Simon K?gstr?m wrote:
> > We have a IXP4xx-based board which has an e100 NIC. During bootup, we
> > trigger a BUG_ON in dmabounce.c because the mapped direction doesn't
> > match the synced one. e100.c maps buffers bidirectional, but the sync
> > is done fromdevice.
> 
> First and foremost, enable DMA API debugging and check whether that
> complains too (I think it should do, you're not allowed to change the
> direction argument until a mapping is unmapped.)

Well, you are right, but the warning I get is not for direction:

  WARNING: at /srv/lhome/simkag/devel/nc602/external/kernel/lib/dma-debug.c:986 check_sync+0x14c/0x540()
  e100 0000:00:02.0: DMA-API: device driver tries to sync DMA memory it has not allocated [device address=0x0000000003c01000] [size=16 bytes]
  [...]
  [<c0134b24>] (debug_dma_sync_single_for_device+0x44/0x50) from [<c017a5e8>] (e100_rx_alloc_skb+0x1c4/0x1e8)
  [<c017a5e8>] (e100_rx_alloc_skb+0x1c4/0x1e8) from [<c017c58c>] (e100_rx_alloc_list+0x84/0x164)
  [<c017c58c>] (e100_rx_alloc_list+0x84/0x164) from [<c017e958>] (e100_up+0xc/0x14c)
  [<c017e958>] (e100_up+0xc/0x14c) from [<c017ecc8>] (e100_open+0x14/0x40)
  [<c017ecc8>] (e100_open+0x14/0x40) from [<c019b230>] (__dev_open+0x8c/0x134)

And the dma_debug code explicitly skips the check if the direction is
DMA_BIDIRECTIONAL:

  static void check_sync(struct device *dev,
		       struct dma_debug_entry *ref,
		       bool to_cpu)
  {
	[...]
	if (entry->direction == DMA_BIDIRECTIONAL)
		goto out;

	if (ref->direction != entry->direction) {
		err_printk(dev, entry, "DMA-API: device driver syncs "
				"DMA memory with different direction "
				"[device address=0x%016llx] [size=%llu bytes] "
				"[mapped with %s] [synced with %s]\n",
				(unsigned long long)ref->dev_addr, entry->size,
				dir2name[entry->direction],
				dir2name[ref->direction]);
	}
	[...]
  }

Krzysztofs patch does the same for dmabounce.c, from the dma-debug code
it seems to me that it would make sense there as well?

// Simon
