From: mw@semihalf.com (Marcin Wojtas)
Date: Thu, 2 Jun 2016 07:48:38 +0200
Subject: [BUG] Page allocation failures with newest kernels
In-Reply-To: <20160531131520.GI24936@arm.com>
References: <CAPv3WKcVsWBgHHC3UPNcbka2JUmN4CTw1Ym4BR1=1V9=B9av5Q@mail.gmail.com>
 <574D64A0.2070207@arm.com>
 <CAPv3WKdYdwpi3k5eY86qibfprMFwkYOkDwHOsNydp=0sTV3mgg@mail.gmail.com>
 <60e8df74202e40b28a4d53dbc7fd0b22@IL-EXCH02.marvell.com>
 <20160531131520.GI24936@arm.com>
Message-ID: <CAPv3WKftqsEXbdU-geAcUKXBSskhA0V72N61a1a+5DfahLK_Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I think I found a right trace. Following one-liner fixes the issue
beginning from v4.2-rc1 up to v4.4 included:

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -294,7 +294,7 @@ static inline bool
early_page_uninitialised(unsigned long pfn)

 static inline bool early_page_nid_uninitialised(unsigned long pfn, int nid)
 {
-       return false;
+       return true;
 }

The regression was introduced by commit 7e18adb4f80b ("mm: meminit:
initialise remaining struct pages in parallel with kswapd"), which in
fact disabled memblock reserve at all for all platfroms not using
CONFIG_DEFERRED_STRUCT_PAGE_INIT (x86 is the only user), hence
temporary shortage of memory possible to allocate during my test.

Since v4.4-rc1 following changes of approach have been introduced:
97a16fc - mm, page_alloc: only enforce watermarks for order-0 allocations
0aaa29a - mm, page_alloc: reserve pageblocks for high-order atomic
allocations on demand
974a786 - mm, page_alloc: remove MIGRATE_RESERVE

>From what I understood, now order-0 allocation keep no reserve at all.
I checked all gathered logs and indeed it was order-0 which failed and
apparently weren't able to reclaim successfully. Since the problem is
very easy to reproduce (at least in my test, as well as stressing
device in NAS setup) is there any chance to avoid destiny of page
alloc failures? Or any trick to play with fragmentation parameters,
etc.?

I would be grateful for any hint.

Best regards,
Marcin

2016-05-31 15:15 GMT+02:00 Will Deacon <will.deacon@arm.com>:
> On Tue, May 31, 2016 at 01:10:44PM +0000, Yehuda Yitschak wrote:
>> During some of the stress tests we also came across a different warning
>> from the arm64  page management code
>> It looks like a race is detected between HW and SW marking a bit in the PTE
>
> A72 (which I believe is the CPU in that SoC) is a v8.0 CPU and therefore
> doesn't have hardware DBM.
>
>> Not sure it's really related but I thought it might give a clue on the issue
>> http://pastebin.com/ASv19vZP
>
> There have been a few patches from Catalin to fix up the hardware DBM
> patches, so it might be worth trying to reproduce this failure with a
> more recent kernel. I doubt this is related to the allocation failures,
> however.
>
> Will
