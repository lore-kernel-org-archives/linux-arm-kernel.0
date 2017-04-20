From: eric@anholt.net (Eric Anholt)
Date: Thu, 20 Apr 2017 14:20:40 -0700
Subject: [Bug] VCHIQ functional test broken
In-Reply-To: <20170420195822.GA22677@laptop>
References: <331235003.222371.1491934205807@email.1und1.de>
 <685482264.60263.1492105308873@email.1und1.de>
 <20170413222915.GF17774@n2100.armlinux.org.uk> <20170414074104.GA8704@laptop>
 <87pog7x7c5.fsf@eliezer.anholt.net> <20170420195822.GA22677@laptop>
Message-ID: <87bmrq22tz.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rabin Vincent <rabin@rab.in> writes:

> On Thu, Apr 20, 2017 at 11:27:38AM -0700, Eric Anholt wrote:
>> I'm confused by what you're saying here.  The driver has already been
>> converted to not use dmac_map_area (commit
>> cf9caf1929882b66922aee698e99e6c8f357bee5), and uses dma_map_sg instead,
>> matching the radeon driver you give as a model as far as I can see.
>> That commit is in v4.11-rc6 from Stefan's regression report.
>
> Right.  Sorry.  I must have had an old tag checked out when I looked at
> the driver earlier.  The DMA API usage in the driver in v4.11-rc6 and
> current master looks fine, except for one thing:
>
> The flush in flush_dcache_page() (from get_user_pages()) was done with a
> v6_flush_kern_dcache_page() which always did a clean+invalidate while
> the DMA API only does what is required by the direction, which is only a
> invalidate for DMA_FROM_DEVICE.  Since the driver calls dma_from_sg() on
> the entire page, even if userspace sent in an offset into the page,
> unrelated data in userspace may be thrown away.
>
> Does changing the dma API calls to always use DMA_BIDIRECTIONAL make the
> test pass?

Oh, that's a neat explanation for what might be wrong, and there seem to
be tests trying to poke at that within the functional test code.
Hopefully Stefan can try that out.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170420/c55cf587/attachment-0001.sig>
