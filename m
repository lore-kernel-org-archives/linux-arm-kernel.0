From: mw@semihalf.com (Marcin Wojtas)
Date: Thu, 9 Jun 2016 20:13:08 +0200
Subject: [BUG] Page allocation failures with newest kernels
In-Reply-To: <20160608100950.GH2527@techsingularity.net>
References: <CAPv3WKdYdwpi3k5eY86qibfprMFwkYOkDwHOsNydp=0sTV3mgg@mail.gmail.com>
 <60e8df74202e40b28a4d53dbc7fd0b22@IL-EXCH02.marvell.com>
 <20160531131520.GI24936@arm.com>
 <CAPv3WKftqsEXbdU-geAcUKXBSskhA0V72N61a1a+5DfahLK_Dg@mail.gmail.com>
 <20160602135226.GX2527@techsingularity.net>
 <CAPv3WKd8Zdcv5nhr2euN7L4W5JYLex_Hmn+9AVd6reyD-Vw4kg@mail.gmail.com>
 <20160603095344.GZ2527@techsingularity.net>
 <CAPv3WKfrgNg00M4oE3VKLYimYqN6NO6ziR7LWYXQ1d_M-bo67A@mail.gmail.com>
 <20160603123655.GA2527@techsingularity.net>
 <CAPv3WKfEQCeR++uqaUVhhsNe0WFsKq1Sn9uo==9NxtQe=GV7zw@mail.gmail.com>
 <20160608100950.GH2527@techsingularity.net>
Message-ID: <CAPv3WKd8TbvTPc_+5qQvZwUH-bfMx5-A1LMdT08Am0as8PXLtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mel,

My last email got cut in half.

2016-06-08 12:09 GMT+02:00 Mel Gorman <mgorman@techsingularity.net>:
> On Tue, Jun 07, 2016 at 07:36:57PM +0200, Marcin Wojtas wrote:
>> Hi Mel,
>>
>>
>>
>> 2016-06-03 14:36 GMT+02:00 Mel Gorman <mgorman@techsingularity.net>:
>> > On Fri, Jun 03, 2016 at 01:57:06PM +0200, Marcin Wojtas wrote:
>> >> >> For the record: the newest kernel I was able to reproduce the dumps
>> >> >> was v4.6: http://pastebin.com/ekDdACn5. I've just checked v4.7-rc1,
>> >> >> which comprise a lot (mainly yours) changes in mm, and I'm wondering
>> >> >> if there may be a spot fix or rather a series of improvements. I'm
>> >> >> looking forward to your opinion and would be grateful for any advice.
>> >> >>
>> >> >
>> >> > I don't believe we want to reintroduce the reserve to cope with CMA. One
>> >> > option would be to widen the gap between low and min watermark by the
>> >> > size of the CMA region. The effect would be to wake kswapd earlier which
>> >> > matters considering the context of the failing allocation was
>> >> > GFP_ATOMIC.
>> >>
>> >> Of course my intention is not reintroducing anything that's gone
>> >> forever, but just to find out way to overcome current issues. Do you
>> >> mean increasing CMA size?
>> >
>> > No. There is a gap between the low and min watermarks. At the low point,
>> > kswapd is woken up and at the min point allocation requests either
>> > either direct reclaim or fail if they are atomic. What I'm suggesting
>> > is that you adjust the low watermark and add the size of the CMA area
>> > to it so that kswapd is woken earlier. The watermarks are calculated in
>> > __setup_per_zone_wmarks
>> >
>>
>> I printed all zones' settings, whose watermarks are configured within
>> __setup_per_zone_wmarks(). There are three DMA, Normal and Movable -
>> only first one's watermarks have non-zero values. Increasing DMA min
>> watermark didn't help. I also played with increasing
>
> Patch?
>

I played with increasing min_free_kbytes from ~2600 to 16000. It
resulted in shifting watermarks levels in __setup_per_zone_wmarks(),
however only for zone DMA. Normal and Movable remained at 0. No
progress with avoiding page alloc failures - a gap between 'free' and
'free_cma' was huge, so I don't think that CMA itself would be a root
cause.

> Did you establish why GFP_ATOMIC (assuming that's the failing site) had
> not specified __GFP_ATOMIC at the time of the allocation failure?
>

Yes. It happens in new_slab() in following lines:
return allocate_slab(s, flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
I added "| GFP_ATOMIC" and in such case I got same dumps but with one
bit set more in gfp_mask, so I don't think it's an issue.

Latest patches in v4.7-rc1 seem to boost page alloc performance enough
to avoid problems observed between v4.2 and v4.6. Hence before
rebasing from v4.4 to another LTS >v4.7 in future, we decided as a WA
to return to using MIGRATE_RESERVE + adding fix for
early_page_nid_uninitialised(). Now operation seems stable on all our
SoC's during the tests.

Best regards,
Marcin
