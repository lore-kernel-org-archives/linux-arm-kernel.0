From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 22 Dec 2011 12:08:07 +0000
Subject: Oops in guest after ioremap() on ARMv7
Message-ID: <4EF31DA7.9030407@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running the linux kernel on the ARMv7 envelope model as a guest
under the Xen hypervisor there is a oops (see below for an example of
the page translation fault) when trying to access ioremap()'d memory.

The same kernel works fine when not running under the hypervisor.

It's a 3.2.0-rc5+ kernel with the two additional linux-arch-arm
branches: arm-arch/vexpress and arm-arch/arm-lpae.

Calling flush_cache_all() in flush_cache_vmap() makes it work.  What
isn't being correctly flushed?  I see that flush_pmd_entry() and
cpu_v7_set_pte_ext() already flush the L1 and L2 translation table
entries and I can't think of anything else that would need to be flushed
(unless the mapped virtual addresses need to be flushed as well?)

The "Barrier Litmus Tests and Cookbook" says that a TLB flush and a
branch predictor flush are required after a translation table entry
update.  This seems not to be done but adding this didn't seem to help
(and using local_flush_tlb_all()) in flush_cache_vmap() didn't help either).

I don't see anything in the hypervisor that could be causing this as the
fault is occurring at stage 1 and not stage 2 translation.

David

[    0.200952] Unable to handle kernel paging request at virtual address
c8804050
[    0.203234] pgd = c0004000
[    0.204147] [c8804050] *pgd=8781a811, *pte=1a000653, *ppte=1a000453
[    0.206120] Internal error: Oops: 7 [#1]
[    0.207381] CPU: 0    Tainted: G        W     (3.2.0-rc5.dv #123)
[    0.209338] PC is at v2m_init+0x44/0x100
[    0.210616] LR is at ioremap_page_range+0x100/0x164
[    0.212197] pc : [<c0325130>]    lr : [<c013e278>]    psr: a0000013
[    0.212235] sp : c781dfa0  ip : 00000001  fp : 00000000
[    0.215880] r10: 00000000  r9 : 00000000  r8 : 00000000
[    0.217570] r7 : 00000013  r6 : 00000000  r5 : c0321f1c  r4 : c033d184
[    0.219680] r3 : c8804000  r2 : c0325128  r1 : 1a000613  r0 : c8804000
[    0.221756] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    0.224159] Control: 10c53c7d  Table: 80004059  DAC: 00000015
[    0.225990] Process swapper (pid: 1, stack limit = 0xc781c268)
[    0.227858] Stack: (0xc781dfa0 to 0xc781e000)
[    0.229325] dfa0: c03250ec c033d184 c0321f1c c0321f38 c781c000
c031f7c0 c033d430 33369eb8
[    0.231955] dfc0: 00000000 00000000 00000080 c033d184 c033d430
c0009eb8 00000013 00000000
[    0.234652] dfe0: 00000000 c031f908 00000000 00000000 c031f890
c0009eb8 dfdfdfcf cfdfdfdf
[    0.237304] [<c0325130>] (v2m_init+0x44/0x100) from [<c0321f38>]
(customize_machine+0x1c/0x28)
[    0.240099] [<c0321f38>] (customize_machine+0x1c/0x28) from
[<c031f7c0>] (do_one_initcall+0x90/0x160)
[    0.243080] [<c031f7c0>] (do_one_initcall+0x90/0x160) from
[<c031f908>] (kernel_init+0x78/0x114)
[    0.245958] [<c031f908>] (kernel_init+0x78/0x114) from [<c0009eb8>]
(kernel_thread_exit+0x0/0x8)
[    0.248823] Code: e3a02000 ebf3a9b7 e2503000 0a00000a (e5933050)
