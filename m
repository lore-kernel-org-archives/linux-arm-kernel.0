From: mgorman@techsingularity.net (Mel Gorman)
Date: Fri, 3 Jun 2016 10:53:44 +0100
Subject: [BUG] Page allocation failures with newest kernels
In-Reply-To: <CAPv3WKd8Zdcv5nhr2euN7L4W5JYLex_Hmn+9AVd6reyD-Vw4kg@mail.gmail.com>
References: <CAPv3WKcVsWBgHHC3UPNcbka2JUmN4CTw1Ym4BR1=1V9=B9av5Q@mail.gmail.com>
 <574D64A0.2070207@arm.com>
 <CAPv3WKdYdwpi3k5eY86qibfprMFwkYOkDwHOsNydp=0sTV3mgg@mail.gmail.com>
 <60e8df74202e40b28a4d53dbc7fd0b22@IL-EXCH02.marvell.com>
 <20160531131520.GI24936@arm.com>
 <CAPv3WKftqsEXbdU-geAcUKXBSskhA0V72N61a1a+5DfahLK_Dg@mail.gmail.com>
 <20160602135226.GX2527@techsingularity.net>
 <CAPv3WKd8Zdcv5nhr2euN7L4W5JYLex_Hmn+9AVd6reyD-Vw4kg@mail.gmail.com>
Message-ID: <20160603095344.GZ2527@techsingularity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 09:01:55PM +0200, Marcin Wojtas wrote:
> >> From what I understood, now order-0 allocation keep no reserve at all.
> >
> > Watermarks should still be preserved. zone_watermark_ok is still there.
> > What might change is the size of reserves for high-order atomic
> > allocations only. Fragmentation shouldn't be a factor. I'm missing some
> > major part of the picture.
> >
> 
> I CC'ed you in the last email, as I found out your authorship of
> interesting patches - please see problem description
> https://lkml.org/lkml/2016/5/30/1056
> 
> Anyway when using v4.4.8 baseline, after reverting below patches:
> 97a16fc - mm, page_alloc: only enforce watermarks for order-0 allocations
> 0aaa29a - mm, page_alloc: reserve pageblocks for high-order atomic
> allocations on demand
> 974a786 - mm, page_alloc: remove MIGRATE_RESERVE
> + adding early_page_nid_uninitialised() modification
> 

The early_page check is wrong because of the check itself rather than
the function so that was the bug there.

> I stop receiving page alloc fail dumps like this one
> http://pastebin.com/FhRW5DsF, also performance in my test looks very
> similar. I'd like to understand this phenomenon and check if it's
> possible to avoid such page-alloc-fail hickups in a nice way.
> Afterwards, once the dumps finish, the kernel remain stable, but is
> such behavior expected and intended?
> 

Looking at the pastebin, the page allocation failure appears to be partially
due to CMA. If the free_cma pages are substracted from the free pages then
it's very close to the low watermark. I suspect kswapd was already active
but it had not acted in time to prevent the first allocation. The impact
of MIGRATE_RESERVE was to give a larger window for kswapd to do work in
but it's a co-incidence. By relying on it for an order-0 allocation it
would fragment that area which in your particular case may not matter but
actually violates what MIGRATE_RESERVE was for.

> For the record: the newest kernel I was able to reproduce the dumps
> was v4.6: http://pastebin.com/ekDdACn5. I've just checked v4.7-rc1,
> which comprise a lot (mainly yours) changes in mm, and I'm wondering
> if there may be a spot fix or rather a series of improvements. I'm
> looking forward to your opinion and would be grateful for any advice.
> 

I don't believe we want to reintroduce the reserve to cope with CMA. One
option would be to widen the gap between low and min watermark by the
size of the CMA region. The effect would be to wake kswapd earlier which
matters considering the context of the failing allocation was
GFP_ATOMIC.

The GFP_ATOMIC itself is interesting. If I'm reading this correctly,
scsi_get_cmd_from_req() was called from scsi_prep() where it was passing
in GFP_ATOMIC but in the page allocation failure, __GFP_ATOMIC is not
set. It would be worth chasing down if the allocation site really was
GFP_ATOMIC and if so, isolate what stripped that flag and see if it was
a mistake.

-- 
Mel Gorman
SUSE Labs
