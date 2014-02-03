From: msalter@redhat.com (Mark Salter)
Date: Mon, 03 Feb 2014 15:50:49 -0500
Subject: arm64: kernel panic in paging_init()
Message-ID: <1391460649.13327.51.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm seeing the following panic in paging init. This is on the foundation
model with a modified dtb memory node which has a non section-aligned
bank:
	memory at 80000000 {
		device_type = "memory";
		reg = <0x00000000 0x80000000 0 0x20000000>,
		      <0x00000000 0xa0300000 0 0x1fd00000>;
	};

I only see this with 64k pagesize configured. What happens is the
non section-aligned bank causes alloc_init_pte() to allocate a page
for the new pte from the end of the first bank (the failing address
0xfffffe001fff0000 [0x9fff0000 phys]). This should be a valid page
since it was mapped during the create_mapping() call for the first
memory bank. A flush_tlb_all() added to the end of create_mapping()
makes the panic go away so I think the problem is something stale
cached before the page with the failing address was mapped.

Thoughts?

     Linux version 3.14.0-rc1+ (msalter at deneb.redhat.com) (gcc version 4.8.1 20130717 (Red Hat 4.8.1-5) (GCC) ) #1 SMP Mon Feb 3 10:31:04 EST 2014
     CPU: AArch64 Processor [410fd000] revision 0
     bootconsole [earlycon0] enabled
     Unable to handle kernel paging request at virtual address fffffe001fff0000
     pgd = fffffe0000050000
     [fffffe001fff0000] *pgd=0000000080000711, *pmd=0000000080000711
     Internal error: Oops: 96000047 [#1] SMP
     Modules linked in:
     CPU: 0 PID: 0 Comm: swapper Not tainted 3.14.0-rc1+ #1
     task: fffffe00007f6920 ti: fffffe00007c0000 task.ti: fffffe00007c0000
     PC is at memset+0x1c/0x60
     LR is at early_alloc.constprop.6+0x3c/0x4c
     pc : [<fffffe00002f2e7c>] lr : [<fffffe000076439c>] pstate: 200002c5
     sp : fffffe00007c3e40
     x29: fffffe00007c3e40 x28: fffffe0020300000 
     x27: fffffbffffffffff x26: fffffe0000804000 
     x25: fffffe00006a6b18 x24: fffffe0000000000 
     x23: fffffe0000804000 x22: 0000000000000018 
     x21: fffffe000084e000 x20: fffffe000084e000 
     x19: fffffe001fff0000 x18: 0000000000000000 
     x17: fffffe000087c308 x16: 0000000000000000 
     x15: 0000000000000007 x14: 00000000a0000000 
     x13: 0000000000000018 x12: 0000000080000000 
     x11: fffffe000087cf08 x10: 000000000020153d 
     x9 : 0000000300000000 x8 : 0000000000000007 
     x7 : 00000000ff79b000 x6 : 0000000000001000 
     x5 : fffffe000087cf98 x4 : fffffe001fff0000 
     x3 : 00000000000000a8 x2 : 000000000000fff8 
     x1 : 0000000000000000 x0 : fffffe001fff0000 
     
     Process swapper (pid: 0, stack limit = 0xfffffe00007c0058)
     Stack: (0xfffffe00007c3e40 to 0xfffffe00007c4000)
     3e40: 007c3e60 fffffe00 00764598 fffffe00 0087c320 fffffe00 001424a8 fffffe00
     3e60: 007c3f10 fffffe00 00762bf0 fffffe00 0084e000 fffffe00 00080000 fffffe00
     3e80: 007c3fe0 fffffe00 0084d000 fffffe00 807f9000 00000000 80000000 00000000
     3ea0: 80030000 00000000 80050000 00000000 000803f8 fffffe00 80080200 00000000
     3ec0: a0300000 00000000 40000000 fffffe00 40000000 fffffe00 00058008 fffffe00
     3ee0: 0000a030 00000000 20000000 00000000 3fffffff fffffe00 0084e080 fffffe00
     3f00: 00000000 02c00000 00000000 00000200 007c3fa0 fffffe00 0076051c fffffe00
     3f20: 0084de40 fffffe00 00000001 00000000 00000000 00000000 410fd000 00000000
     3f40: 807f9000 00000000 80000000 00000000 80030000 00000000 80050000 00000000
     3f60: 000803f8 fffffe00 005600a8 fffffe00 00000001 00000000 00000001 00000000
     3f80: 007ff330 fffffe00 00000000 00000000 9f400000 00000000 00854168 fffffe00
     3fa0: 00000000 00000000 80080200 00000000 ff7b2f18 00000000 00000e12 00000000
     3fc0: 9f400000 00000000 410fd000 00000000 807f9000 00000000 00000000 00000000
     3fe0: 00787278 fffffe00 00000000 00000000 00000000 00000000 00000000 00000000
     Call trace:
     [<fffffe00002f2e7c>] memset+0x1c/0x60
     [<fffffe0000764598>] paging_init+0x194/0x314
     [<fffffe0000762bf0>] setup_arch+0x1d0/0x520
     [<fffffe000076051c>] start_kernel+0x88/0x384
     Code: 2a014021 aa018021 f1002042 54000084 (f8008481) 
     ---[ end trace 3406ff24bd97382e ]---
     Kernel panic - not syncing: Attempted to kill the idle task!
