From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Apr 2013 17:29:32 -0400 (EDT)
Subject: ARM: 7684/1: errata: Workaround for Cortex-A15 erratum 798181
 (TLBI/DSB operations)
Message-ID: <alpine.LFD.2.03.1304221641340.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

I notice that commit 93dc68876b60 ( "ARM: 7684/1: errata: Workaround for 
Cortex-A15 erratum 798181 (TLBI/DSB operations)") is in mainline, but it 
is causing a flood of warnings with CONFIG_DEBUG_PREEMPT active, making 
the system unusable. Unfortunately, I failed to find it in the list 
archives, so I couldn't reply to the original patch.

The kernel spits out this on every fork():

BUG: using smp_processor_id() in preemptible [00000000] code: bash/1419
caller is broadcast_tlb_mm_a15_erratum+0x94/0xfc
[<c0014640>] (unwind_backtrace+0x0/0xf8) from [<c02074ec>] (debug_smp_processor_id+0xc4/0xe8)
[<c02074ec>] (debug_smp_processor_id+0xc4/0xe8) from [<c0013a3c>] (broadcast_tlb_mm_a15_erratum+0x94/0xfc)
[<c0013a3c>] (broadcast_tlb_mm_a15_erratum+0x94/0xfc) from [<c0020f28>] (dup_mm+0x30c/0x41c)
[<c0020f28>] (dup_mm+0x30c/0x41c) from [<c00217a4>] (copy_process.part.56+0x724/0xe20)
[<c00217a4>] (copy_process.part.56+0x724/0xe20) from [<c0021f54>] (do_fork+0x90/0x320)
[<c0021f54>] (do_fork+0x90/0x320) from [<c000e240>] (ret_fast_syscall+0x0/0x30)
BUG: using smp_processor_id() in preemptible [00000000] code: bash/1419
caller is broadcast_tlb_mm_a15_erratum+0x94/0xfc
[<c0014640>] (unwind_backtrace+0x0/0xf8) from [<c02074ec>] (debug_smp_processor_id+0xc4/0xe8)
[<c02074ec>] (debug_smp_processor_id+0xc4/0xe8) from [<c0013a3c>] (broadcast_tlb_mm_a15_erratum+0x94/0xfc)
[<c0013a3c>] (broadcast_tlb_mm_a15_erratum+0x94/0xfc) from [<c0020f28>] (dup_mm+0x30c/0x41c)
[<c0020f28>] (dup_mm+0x30c/0x41c) from [<c00217a4>] (copy_process.part.56+0x724/0xe20)
[<c00217a4>] (copy_process.part.56+0x724/0xe20) from [<c0021f54>] (do_fork+0x90/0x320)
[<c0021f54>] (do_fork+0x90/0x320) from [<c000e240>] (ret_fast_syscall+0x0/0x30)
BUG: using smp_processor_id() in preemptible [00000000] code: bash/1419
caller is smp_call_function_many+0x18/0x2c0
[<c0014640>] (unwind_backtrace+0x0/0xf8) from [<c02074ec>] (debug_smp_processor_id+0xc4/0xe8)
[<c02074ec>] (debug_smp_processor_id+0xc4/0xe8) from [<c006b3d4>] (smp_call_function_many+0x18/0x2c0)
[<c006b3d4>] (smp_call_function_many+0x18/0x2c0) from [<c0013a8c>] (broadcast_tlb_mm_a15_erratum+0xe4/0xfc)
[<c0013a8c>] (broadcast_tlb_mm_a15_erratum+0xe4/0xfc) from [<c0020f28>] (dup_mm+0x30c/0x41c)
[<c0020f28>] (dup_mm+0x30c/0x41c) from [<c00217a4>] (copy_process.part.56+0x724/0xe20)
[<c00217a4>] (copy_process.part.56+0x724/0xe20) from [<c0021f54>] (do_fork+0x90/0x320)
[<c0021f54>] (do_fork+0x90/0x320) from [<c000e240>] (ret_fast_syscall+0x0/0x30)


Nicolas
