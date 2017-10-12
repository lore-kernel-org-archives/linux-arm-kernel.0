From: yesskarthik@gmail.com (Karthik Srinivasamurthy)
Date: Thu, 12 Oct 2017 12:07:00 -0700
Subject: Crash in dma_cache_maint_page+0x10 on linux 3.4
Message-ID: <CAEe49ty28NNRjewxLKBU9PQf9=zzwpA8cWi4CCyHHnXP_wwhQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I see a kernel crash in dma_cache_maint_page. it appears to have crashed when
accessing struct page when doing page_to_pfn. However the struct page
is obtained
via pfn_page(dma_to_pfn) in arm_dma_sync_single_for_device
and the preceding page_to_phys(page) seems to have worked (didn't crash)
in __dma_page_dev_to_cpu just before the outer_inv_range.
Its quite strange, could you please help analyze what could be wrong?
There are some memory corruption issues that are going on and i am
debugging the same,
but i can't quite think how this could be possible due to memory corruption.
Any help is appreciated.
Thanks
Karthik


<4>[ 2862.415464] cpu0
<4>[ 2862.415464] [<c0018e30>] (dma_cache_maint_page+0x10/0x158) from
[<c0018fc8>] (arm_dma_sync_single_for_device+0x50/0x60)
<4>[ 2862.415526] [<c0018fc8>]
(arm_dma_sync_single_for_device+0x50/0x60) from [<bfa88c58>]
(bus_dma_sync_single+0x140/0x158 [ath_dev])
<4>[ 2862.415713] [<bfa88c58>] (bus_dma_sync_single+0x140/0x158 [ath_dev])
_______
<1>[ 2860.191440] Unable to handle kernel NULL pointer dereference at
virtual address 00000220
<1>[ 2860.191440] pgd = c0004000
<1>[ 2860.191440] [00000220] *pgd=00000000
<0>[ 2860.191471] Internal error: Oops: 17 [#1] SMP ARM
<4>[ 2860.235270] CPU: 0    Tainted: P           O  (3.4.103 #60886)
<4>[ 2860.235301] PC is at dma_cache_maint_page+0x10/0x158
<4>[ 2860.235301] LR is at arm_dma_sync_single_for_device+0x50/0x60
<4>[ 2860.235301] pc : [<c0018e30>]    lr : [<c0018fc8>]    psr: a0000113
<4>[ 2860.235332] sp : c0e0fd60  ip : c001d040  fp : c0fafe80
<4>[ 2860.235332] r10: 00000002  r9 : ffdecbf8  r8 : de157000
<4>[ 2860.235332] r7 : 43000000  r6 : dd078800  r5 : 00000000  r4 : c0018f78
<4>[ 2860.235332] r3 : 00000002  r2 : 00000040  r1 : 00000430  r0 : 00000220
<4>[ 2860.235332] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
<4>[ 2860.235364] Control: 10c5787d  Table: 5cfd006a  DAC: 00000015

________

(gdb) list *(dma_cache_maint_page+0x10)
0xc0018e30 is in dma_cache_maint_page (include/linux/mm.h:708).
703 page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
704 }
705
706 static inline unsigned long page_to_section(const struct page *page)
707 {
708 return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
709 }
710 #endif
711
712 static inline void set_page_zone(struct page *page, enum zone_type zone)
(gdb)
