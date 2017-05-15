From: phil@raspberrypi.org (Phil Elwell)
Date: Mon, 15 May 2017 15:29:29 +0100
Subject: [Bug] VCHIQ functional test broken
In-Reply-To: <20170513093016.GQ22219@n2100.armlinux.org.uk>
References: <20170413222915.GF17774@n2100.armlinux.org.uk>
 <20170414074104.GA8704@laptop> <87pog7x7c5.fsf@eliezer.anholt.net>
 <20170420195822.GA22677@laptop>
 <696fb1c1-7751-caf0-e0d9-9c67b059b4cc@i2se.com>
 <20170424164015.GP17774@n2100.armlinux.org.uk>
 <1058502523.15283.1493055747531@email.1und1.de>
 <20170424185931.GQ17774@n2100.armlinux.org.uk>
 <1381182989.263636.1493062504676@email.1und1.de>
 <952745481.440383.1494666448727@email.1und1.de>
 <20170513093016.GQ22219@n2100.armlinux.org.uk>
Message-ID: <34277896-d59f-9026-8700-d592c14458f5@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/05/2017 10:30, Russell King - ARM Linux wrote:
> On Sat, May 13, 2017 at 11:07:28AM +0200, Stefan Wahren wrote:
>> In the meantime this issue has been fixed by Phil [1].
> 
> Right - definitely a driver bug.  Mapping more memory for DMA than is
> actually going to be DMA'd to and expecting data to be preserved is
> really horrid.

That feature was added during the upstreaming process, and as Stefan says
there is an outstanding patch for it.

>> Unfortunately i found another issue. If i enable CONFIG_HIGHMEM in
>> the kernel config, the data during functional test gets corrupted.
>> Phil said it's caused by the usage of get_user_pages() [2].
> 
> Without knowing who "Phil" is in that thread, but...
> 
>    HIGHMEM is a problem because you can't use get_user_pages on pages in
>    HIGHMEM.
> 
> is an interesting statement, and without any reasoning or evidence.
> 
> I also believe it to be incorrect.  get_user_pages() returns an array
> of struct page pointers for the user memory, calling flush_dcache_page()
> and flush_anon_page() on them to ensure that any kernel mapping is
> coherent with what is in userspace.
> 
> As far as returning the array of page pointers, get_user_pages() doesn't
> care whether they're lowmem or highmem.
> 
> flush_dcache_page() doesn't care either - if it wants to flush the page
> and the page is a highmem page, it will temporarily map it before
> flushing it.
> 
> flush_anon_page() is a no-op for all non-aliasing caches.
> 
> get_user_pages() works fine for whatever memory on other platforms and
> drivers such as etnaviv, so I think this comes down to the vchip driver
> doing things in ways that the kernel interfaces its using don't expect -
> exactly like the "lets pass full pages to the DMA API" broken-ness.

See previous comment.

> I would like to hear the justification for that statement, but without
> any justification, I assert that the statement is false.

I am the Phil in question, and the off-the-cuff comment was the result of
a hazy memory of issues encountered with VCHIQ bulk transfers as a Broadcom
employee (which would have been on a 2.6 kernel). I suspect there may have
been some use of kernel virtual addresses as an intermediate representation,
but I no longer have access to that code.

If get_user_pages is HIGHMEM-safe (and I can see why it would be), then the
cause of the corruption Stefan saw is probably the special handling of
unaligned reads, specifically:

			memcpy((char *)page_address(pages[0]) +
				pagelist->offset,
				fragments,
				head_bytes);

Phil
