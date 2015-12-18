From: dianders@chromium.org (Doug Anderson)
Date: Fri, 18 Dec 2015 14:05:40 -0800
Subject: [PATCH] ARM: dma-mapping: Just allocate one chunk at a time
In-Reply-To: <56746AA8.6010202@arm.com>
References: <1450384253-1067-1-git-send-email-dianders@chromium.org>
 <CAD=FV=XP9zx2XEmo7vS0MdsROJ0JoRYFidnRaBLxR43GXnuqag@mail.gmail.com>
 <5673FEF0.1080504@arm.com>
 <CAD=FV=XxSBe8=OJHpMqk9mPUnhNZ5pF5otJWr-2RedEkuMp+Kw@mail.gmail.com>
 <56746AA8.6010202@arm.com>
Message-ID: <CAD=FV=XYym5B=G762e6NLdMKaqTNwObakNrVDPu3iJAdhy7frA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 18, 2015 at 12:20 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hmm, I'm no mm expert, but from a look at the flags in gfp.h perhaps instead
> of just __GFP_NORETRY we should go all the way to clearing __GFP_RECLAIM for
> the opportunistic calls so they really fail fast?

Ah, interesting.

Hrmm, I thought I mentioned somewhere that I'm testing on 3.14, but
looking back it looks like I didn't.  :(  It is entirely possible that
the memory management has improved in newer versions of Linux so that
things aren't so bad even without my patch.  Since I'm doing a full
system test it's pretty hard for me to bump up to a new version of
Linux and test (it looks like the accelerated video hasn't landed
there).

On 3.14 thre's no "__GFP_RECLAIM".

Since many ARM users are running old versions of Linux and are
interested in nice backportable patches, it probably makes sense to
post up and use __GFP_NORETRY and someone in the future can try poking
it to clearing __GFP_RECLAIM instead?


>> 2. We still have the same problem that we're taking away all the
>> contiguous memory that other users may want.  I've got a dwc2 USB
>> controller in my system and it needs to allocate bounce buffers for
>> its DMA.  While looking at cat videos on Facebook and running a
>> program to simulate memory pressure (4 userspace programs each walking
>> through 350 Megs of memory over and over) I start seeing lots of order
>> 3 allocation failures in dwc2.  It's true that the USB/network stack
>> is resilient against these allocation failures (other than spamming my
>> log), but performance will decrease.  When I switch to WiFi I suddenly
>> start seeing "mwifiex_sdio mmc2:0001:1: single skb allocated fail,
>> drop pkt port=28 len=33024".  Again, it's robust, but you're affecting
>> performance.
>>
>>
>>
>> I also tried using "4" instead of "MAX_ORDER" (as per Marek) so that
>> we don't try for > 64K chunks.  This is might be a reasonable
>> compromise.  My cat video test still reproduces "alloc 4194304 bytes:
>> 674318751 ns", but maybe ~700 ms is an OK?  Of course, this still eats
>> all the large chunks of memory that everyone else would like to have.
>>
>>
>> Oh, or how about this: we start allocating of order 4.  Upon the first
>> failure we jump to order 1.  AKA: if there's no memory pressure we're
>> golden.  The moment we have the first bit of memory pressure we fold.
>> That's basically just a slight optimization on Marek's suggestion.  I
>> still see 450 ms for an allocation, but that's not too bad.  It can
>> still take away large chunks from other users, but maybe that's OK?
>
>
> That makes sense - there's really no benefit to be had from trying orders
> which don't correspond to our relevant IOMMU page sizes - I'm not sure
> off-hand how many contortions you'd have to go through to actually get at
> those from here, although it might be another argument in favour of moving
> the pgsize_bitmap into the iommu_domain as Will proposed some time ago. In
> lieu of an actual lookup, my general inclination would be to go
> 2MB->1MB->64K->4K to cover all the common page sizes, but Marek's probably
> right that the larger two are less relevant in the context of mobile
> graphics stuff, which lets face it is the prime concern for IOMMUs on 32-bit
> ARM.

OK, adding 1MB in the mix isn't too hard and doesn't seem to affect
performance too negatively compared to just trying 64K too.  2MB
either.

Note that I re-tested trying 64K vs. just always allocation 1 page at
a time.  In my usage model (Facebook cat videos under memory pressure)
performance was visually better with page at a time.  That's because:

1. I'm on a system that uses IOMMU for video decoding.  I don't think
TLB optimization in this case is very critical since video decoding is
a linear optimization.  Also these IOMMU mappings are allocated once
per video, so every time I scroll down and a new video starts playing
it allocates a new buffer.  The time it takes is critical.

2. The page at a time definitely affects my other peripherals, so by
eating up large pages I kill my network connectivity.  :(

It might make sense to choose peripheral by peripheral.


>> Anyway, I'll plan to send that patch up.  I'll also do a quick test to
>> see if my "sort()" actually helps anything.

The sort actually did help in some cases.  I'll throw it up as a
separate patch and people can see if they want it.


> Sounds good. I'm about to disappear off for holidays, but it'll be good to
> see how much you've improved everything when I get back :D

I'm going to be out for a while too.


Anyway, I'm about out of time.  I'll send up what I have and people
can debate about it if they want...  Unless there's something truly
terribly about it maybe it would be good to land since the newest
patch shouldn't cause any major regressions but should massively
improve performance for some cases.

-Doug
