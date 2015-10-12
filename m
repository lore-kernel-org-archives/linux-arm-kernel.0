From: neidhard.kim@lge.com (Jongsung Kim)
Date: Mon, 12 Oct 2015 14:30:39 +0900
Subject: [PATCH] ARM:mm: fix kmap_atomic_to_page
In-Reply-To: <20151007090121.GC21513@n2100.arm.linux.org.uk>
References: <1444129773-12632-1-git-send-email-chanho.min@lge.com>
 <20151006192836.GX21513@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1510062136190.1531@knanqh.ubzr> <5614979C.30100@lge.com>
 <20151007090121.GC21513@n2100.arm.linux.org.uk>
Message-ID: <561B457F.5090104@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We tried to utilize a HW compressor as a zram backend. Current zram uses kmap_atomic to map a page, and the HW DMAes. So we needed to use kmap_atomic_to_page to get the page to be dma-mapped.


On 10/07/2015 06:01 PM, Russell King - ARM Linux wrote:
> On Wed, Oct 07, 2015 at 12:55:08PM +0900, Jongsung Kim wrote:
>> Recently, we made a driver utilizing kmap_atomic_to_page. Of course,
>> it's not mainlined. People may be using it outside mainline just like us.
> Since kmap_atomic() mappings are supposed to be short-lived, why do you
> need it in your driver?  Don't you already have the struct page pointer
> when setting up the kmap_atomic() mapping?
>
> It is invalid to setup a mapping, and leave it setup across any context
> switching or similar.
>
> Also, kmap_atomic_to_page() is not exported to modules, so you can only
> use it when built-in.
>
>> vmalloc has vmalloc_to_page, pkmap has kmap_to page, and fixmap has
>> kmap_atomic_to_page. Then.. how about letting virt_to_page do them all?
> No.  virt_to_page() is defined to only work on the lowmem mapping, and
> that's not going to change.
>
> Please show the outline of your code making use of this function so we
> can better understand your use case.
>
