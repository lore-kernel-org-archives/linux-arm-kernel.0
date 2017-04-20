From: rabin@rab.in (Rabin Vincent)
Date: Thu, 20 Apr 2017 21:58:40 +0200
Subject: [Bug] VCHIQ functional test broken
In-Reply-To: <87pog7x7c5.fsf@eliezer.anholt.net>
References: <331235003.222371.1491934205807@email.1und1.de>
 <685482264.60263.1492105308873@email.1und1.de>
 <20170413222915.GF17774@n2100.armlinux.org.uk>
 <20170414074104.GA8704@laptop> <87pog7x7c5.fsf@eliezer.anholt.net>
Message-ID: <20170420195822.GA22677@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 11:27:38AM -0700, Eric Anholt wrote:
> I'm confused by what you're saying here.  The driver has already been
> converted to not use dmac_map_area (commit
> cf9caf1929882b66922aee698e99e6c8f357bee5), and uses dma_map_sg instead,
> matching the radeon driver you give as a model as far as I can see.
> That commit is in v4.11-rc6 from Stefan's regression report.

Right.  Sorry.  I must have had an old tag checked out when I looked at
the driver earlier.  The DMA API usage in the driver in v4.11-rc6 and
current master looks fine, except for one thing:

The flush in flush_dcache_page() (from get_user_pages()) was done with a
v6_flush_kern_dcache_page() which always did a clean+invalidate while
the DMA API only does what is required by the direction, which is only a
invalidate for DMA_FROM_DEVICE.  Since the driver calls dma_from_sg() on
the entire page, even if userspace sent in an offset into the page,
unrelated data in userspace may be thrown away.

Does changing the dma API calls to always use DMA_BIDIRECTIONAL make the
test pass?
