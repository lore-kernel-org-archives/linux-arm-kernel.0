From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Thu, 21 Oct 2010 16:12:28 +0200
Subject: BUG: spinlock recursion on CPU#0
Message-ID: <201010211612.46685.alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I tried a demo app which results in a kernel BUG, the backtrace is as follows:
> BUG: spinlock recursion on CPU#0, demogui/507
>  lock: c3e15590, .magic: dead4ead, .owner: demogui/507, .owner_cpu: 0
> [<c002a858>] (unwind_backtrace+0x0/0xec) from [<c01609ac>]
> (do_raw_spin_lock+0x48/0xac) [<c01609ac>] (do_raw_spin_lock+0x48/0xac)
> from [<c002bec4>] (adjust_pte+0x54/0x94) [<c002bec4>]
> (adjust_pte+0x54/0x94) from [<c002bfa4>] (make_coherent+0xa0/0xe4)
> [<c002bfa4>] (make_coherent+0xa0/0xe4) from [<c002c088>]
> (update_mmu_cache+0xa0/0xac) [<c002c088>] (update_mmu_cache+0xa0/0xac)
> from [<c007bfdc>] (__do_fault+0x334/0x414) [<c007bfdc>]
> (__do_fault+0x334/0x414) from [<c007d594>] (handle_mm_fault+0x108/0x2c8)
> [<c007d594>] (handle_mm_fault+0x108/0x2c8) from [<c002b658>]
> (__do_page_fault+0x6c/0xb8) [<c002b658>] (__do_page_fault+0x6c/0xb8) from
> [<c002b878>] (do_page_fault+0xb4/0x15c) [<c002b878>]
> (do_page_fault+0xb4/0x15c) from [<c0025264>] (do_DataAbort+0x34/0x94)
> [<c0025264>] (do_DataAbort+0x34/0x94) from [<c0025da0>]
> (ret_from_exception+0x0/0x10) Exception stack(0xc3e75fb0 to 0xc3e75ff8)
> 5fa0:                                     40fff000 000040a8 00000003
> 4089d3d0 5fc0: 0005e3a0 00000001 4089d3d0 0005c940 ffff0fc0 0005e480
> ffff0fc0 be81bda8 5fe0: 0005c940 be81bbc0 404798c0 404760ec 20000010
> ffffffff

The used version is a Linux-2.6.35.7+ (local patches) running on an 
AT19SAM9263 (ARM926EJ-S). My test program is a QT application I cannot share. 
After sme searching i found this patch:
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/79676
I didn't try any of the demos in this patch, but I applied the changes and the 
BUG didn't occur anymore.
Now I'm wondering what's the status of this patch and is this the right 
approach to handle this problem.

Best regards
Alexander
