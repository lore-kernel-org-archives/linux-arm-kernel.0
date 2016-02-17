From: gerald.schaefer@de.ibm.com (Gerald Schaefer)
Date: Wed, 17 Feb 2016 20:13:40 +0100
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe
 also on PowerPC and ARM)
In-Reply-To: <alpine.LFD.2.20.1602131238260.1910@schleppi>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
 <20160212231510.GB15142@node.shutemov.name>
 <alpine.LFD.2.20.1602131238260.1910@schleppi>
Message-ID: <20160217201340.2dafad8d@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 13 Feb 2016 12:58:31 +0100 (CET)
Sebastian Ott <sebott@linux.vnet.ibm.com> wrote:

> [   59.875935] ------------[ cut here ]------------
> [   59.875937] kernel BUG at mm/huge_memory.c:2884!
> [   59.875979] illegal operation: 0001 ilc:1 [#1] PREEMPT SMP DEBUG_PAGEALLOC
> [   59.875986] Modules linked in: bridge stp llc btrfs xor mlx4_en vxlan ip6_udp_tunnel udp_tunnel mlx4_ib ptp pps_core ib_sa ib_mad ib_core ib_addr ghash_s390 prng raid6_pq ecb aes_s390 des_s390 des_generic sha512_s390 sha256_s390 sha1_s390 mlx4_core sha_common genwqe_card scm_block crc_itu_t vhost_net tun vhost dm_mod macvtap eadm_sch macvlan kvm autofs4
> [   59.876033] CPU: 2 PID: 5402 Comm: git Tainted: G        W       4.4.0-07794-ga4eff16-dirty #77
> [   59.876036] task: 00000000d2312948 ti: 00000000cfecc000 task.ti: 00000000cfecc000
> [   59.876039] Krnl PSW : 0704d00180000000 00000000002bf3aa (__split_huge_pmd_locked+0x562/0xa10)
> [   59.876045]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 EA:3
>                Krnl GPRS: 0000000001a7a1cf 000003d10177c000 0000000000044068 000000005df00215
> [   59.876051]            0000000000000001 0000000000000001 0000000000000000 00000000774e6900
> [   59.876054]            000003ff52000000 000000006d403b10 000000006e1eb800 000003ff51f00000
> [   59.876058]            000003d10177c000 0000000000715190 00000000002bf234 00000000cfecfb58
> [   59.876068] Krnl Code: 00000000002bf39c: d507d010a000	clc	16(8,%%r13),0(%%r10)
>                           00000000002bf3a2: a7840004		brc	8,2bf3aa
>                          #00000000002bf3a6: a7f40001		brc	15,2bf3a8
>                          >00000000002bf3aa: 91407440		tm	1088(%%r7),64
>                           00000000002bf3ae: a7840208		brc	8,2bf7be
>                           00000000002bf3b2: a7f401e9		brc	15,2bf784
>                           00000000002bf3b6: 9104a006		tm	6(%%r10),4
>                           00000000002bf3ba: a7740004		brc	7,2bf3c2
> [   59.876089] Call Trace:
> [   59.876092] ([<00000000002bf234>] __split_huge_pmd_locked+0x3ec/0xa10)
> [   59.876095]  [<00000000002c4310>] __split_huge_pmd+0x118/0x218
> [   59.876099]  [<00000000002810e8>] unmap_single_vma+0x2d8/0xb40
> [   59.876102]  [<0000000000282d66>] zap_page_range+0x116/0x318
> [   59.876105]  [<000000000029b834>] SyS_madvise+0x23c/0x5e8
> [   59.876108]  [<00000000006f9f56>] system_call+0xd6/0x258
> [   59.876111]  [<000003ff9bbfd282>] 0x3ff9bbfd282
> [   59.876113] INFO: lockdep is turned off.
> [   59.876115] Last Breaking-Event-Address:
> [   59.876118]  [<00000000002bf3a6>] __split_huge_pmd_locked+0x55e/0xa10

The BUG at mm/huge_memory.c:2884 is interesting, it's the BUG_ON(!pte_none(*pte))
check in __split_huge_pmd_locked(). Obviously we expect the pre-allocated
pagetables to be empty, but in collapse_huge_page() we deposit the original
pagetable instead of allocating a new (empty) one. This saves an allocation,
which is good, but doesn't that mean that if such a collapsed hugepage will
ever be split, we will always run into the BUG_ON(!pte_none(*pte)), or one
of the two other VM_BUG_ONs in mm/huge_memory.c that check the same?

This behavior is not new, it was the same before the THP rework, so I do not
assume that it is related to the current problems, maybe with the exception
of this specific crash. I never saw the BUG at mm/huge_memory.c:2884 myself,
and the other crashes probably cannot be explained with this. Maybe I am
also missing something, but I do not see how collapse_huge_page() and the
(non-empty) pgtable deposit there can work out with the BUG_ON(!pte_none(*pte))
checks. Any thoughts?
