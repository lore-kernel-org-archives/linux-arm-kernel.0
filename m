From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Dec 2015 10:15:37 +0000
Subject: [PATCH] ARM: dma-mapping: Just allocate one chunk at a time
In-Reply-To: <1643621.CLgIjY2JrC@avalon>
References: <1450384253-1067-1-git-send-email-dianders@chromium.org>
 <CAD=FV=XxSBe8=OJHpMqk9mPUnhNZ5pF5otJWr-2RedEkuMp+Kw@mail.gmail.com>
 <56746AA8.6010202@arm.com> <1643621.CLgIjY2JrC@avalon>
Message-ID: <20151221101536.GC23092@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 03:26:27AM +0200, Laurent Pinchart wrote:
> On Friday 18 December 2015 20:20:56 Robin Murphy wrote:
> > On 18/12/15 18:55, Doug Anderson wrote:
> > > 2. We still have the same problem that we're taking away all the
> > > contiguous memory that other users may want.  I've got a dwc2 USB
> > > controller in my system and it needs to allocate bounce buffers for
> > > its DMA.  While looking at cat videos on Facebook and running a
> > > program to simulate memory pressure (4 userspace programs each walking
> > > through 350 Megs of memory over and over) I start seeing lots of order
> > > 3 allocation failures in dwc2.  It's true that the USB/network stack
> > > is resilient against these allocation failures (other than spamming my
> > > log), but performance will decrease.  When I switch to WiFi I suddenly
> > > start seeing "mwifiex_sdio mmc2:0001:1: single skb allocated fail,
> > > drop pkt port=28 len=33024".  Again, it's robust, but you're affecting
> > > performance.
> > > 
> > > I also tried using "4" instead of "MAX_ORDER" (as per Marek) so that
> > > we don't try for > 64K chunks.  This is might be a reasonable
> > > compromise.  My cat video test still reproduces "alloc 4194304 bytes:
> > > 674318751 ns", but maybe ~700 ms is an OK?  Of course, this still eats
> > > all the large chunks of memory that everyone else would like to have.
> > > 
> > > Oh, or how about this: we start allocating of order 4.  Upon the first
> > > failure we jump to order 1.  AKA: if there's no memory pressure we're
> > > golden.  The moment we have the first bit of memory pressure we fold.
> > > That's basically just a slight optimization on Marek's suggestion.  I
> > > still see 450 ms for an allocation, but that's not too bad.  It can
> > > still take away large chunks from other users, but maybe that's OK?
> > 
> > That makes sense - there's really no benefit to be had from trying
> > orders which don't correspond to our relevant IOMMU page sizes - I'm not
> > sure off-hand how many contortions you'd have to go through to actually
> > get at those from here, although it might be another argument in favour
> > of moving the pgsize_bitmap into the iommu_domain as Will proposed some
> > time ago.
> 
> What's the status of that ? Do we just need a volunteer to do the job ?

The pgsize_bitmap per domain stuff? It got a bunch of Acks, but Joerg
didn't like it :(

  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/334729.html

The idea being that you should be able to attach arbitrary devices to
arbitrary domains, something that I still don't think works in practice.

One way forward would be to do what dwmw2 suggested here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/335023.html

by extending the page table code to iterate and therefore support all
page sizes. At that point, the pgsize_bitmap can be removed, although
we will run into similar issues expressing the minimum supported page
size.

Will
