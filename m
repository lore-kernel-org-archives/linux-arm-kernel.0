From: minchan.kim@gmail.com (Minchan Kim)
Date: Fri, 16 Jul 2010 11:31:45 +0900
Subject: Question of kmap_atomic
In-Reply-To: <alpine.LFD.2.00.1007152200520.10598@xanadu.home>
References: <AANLkTilFvE0eyQS7jNQ77OYkJovJugjKRO-fPHjX8CB9@mail.gmail.com>
	<alpine.LFD.2.00.1007152200520.10598@xanadu.home>
Message-ID: <AANLkTimy4fLzkAmVpxB9sTBUMQsqwMXjFLRUmk1dNEvm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 11:10 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 16 Jul 2010, Minchan Kim wrote:
>
>> I am stuck with looking at ARM's kmap_atomic.
>> I am not familiar with ARM cache model.
>> As I look the code, ARM seems to have a VIPT aliasing model.
>
> There are VIPT as well as VIVT models available.
>
>> Before Nicolas's 17ebba1fe, kmap_atomic always calls kmap_high_get to
>> prevent aliasing problem of 7929eb9cf64 regardless of VIVT and VIPT.
>
> The aliasing issue is fundamental for VIVT. ?But on VIPT it is also
> advantageous to reuse a kmap entry if possible as this saves on the PTE
> setup and TLB flush that is required otherwise.
>
>> But the patch made it to not call kmap_high_get when VIPT-aliasing
>> model in CONFIG_DEBUG_HIGHMEM.
>> Doesn't it cause aliasing problem as 7929eb9cf64 says, again?
>
> No because with VIPT, the cache is tagged with physical addresses, and
> therefore the same cache data will be used for the same memory
> regardless of the virtual address used to reach it. ?On VIVT this is not
> the case and the comment in 7929eb9cf64 applies to VIVT only.

Thanks for quick reply, Nicolas.

My concern is following as.

In VIPT alising model,

I mean
[N-1:5] = virtual index
[31:N] = physical tag

where N > PAGE_SHIFT,

1. kmap uses a page A
2. kunmap just decrease pkmcp count of page A but not flush the cache.
3. Unfortunately, kmap_atomic uses a page A with different virtual
address. (fixmap)
4. write page A
5. kunmap_atomic
6. someone call kmap a page B
7. flush_all_zero_pkmaps flush page A and lost 4's content.

I might be misunderstaning. Please correct me.


-- 
Kind regards,
Minchan Kim
