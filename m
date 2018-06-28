From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Jun 2018 17:00:05 +0100
Subject: [PATCH v2 3/4] arm64: IPI each CPU after invalidating the
 I-cache for kernel mappings
In-Reply-To: <1529656278-878-4-git-send-email-will.deacon@arm.com>
References: <1529656278-878-1-git-send-email-will.deacon@arm.com>
 <1529656278-878-4-git-send-email-will.deacon@arm.com>
Message-ID: <20180628160005.cywb6vn7jl4v7kmb@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Jun 22, 2018 at 09:31:17AM +0100, Will Deacon wrote:
> When invalidating the instruction cache for a kernel mapping via
> flush_icache_range(), it is also necessary to flush the pipeline for
> other CPUs so that instructions fetched into the pipeline before the
> I-cache invalidation are discarded. For example, if module 'foo' is
> unloaded and then module 'bar' is loaded into the same area of memory,
> a CPU could end up executing instructions from 'foo' when branching into
> 'bar' if these instructions were fetched into the pipeline before 'foo'
> was unloaded.
> 
> Whilst this is highly unlikely to occur in practice, particularly as
> any exception acts as a context-synchronizing operation, following the
> letter of the architecture requires us to execute an ISB on each CPU
> in order for the new instruction stream to be visible.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

I hit a warning via kgdb_flush_swbreak_addr() because if IRQs disabled
(and it actually deadlocks for me; running as a guest under KVM on TX1):

WARNING: CPU: 3 PID: 1 at /home/cmarinas/work/Linux/linux-2.6-aarch64/kernel/smp.c:416 smp_call_function_many+0xd4/0x350
Modules linked in:
CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc2-00006-ga5cfc8429d36 #97
Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
pstate: 200003c5 (nzCv DAIF -PAN -UAO)
pc : smp_call_function_many+0xd4/0x350
lr : smp_call_function+0x38/0x68
sp : ffff0000080737f0
x29: ffff0000080737f0 x28: ffff000009169000 
x27: 0000000000000003 x26: 0000000000000000 
x25: ffff00000815a3d0 x24: 0000000000000001 
x23: 0000000000000000 x22: ffff000008eba730 
x21: ffff000009169940 x20: 0000000000000000 
x19: 0000000000000003 x18: ffffffffffffffff 
x17: 0000000000000001 x16: 0000000000000019 
x15: ffff0000091696c8 x14: ffff00008930ef07 
x13: ffff00000930ef1d x12: 0000000000000010 
x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f 
x9 : 656565652aff6223 x8 : ffffffffffffffff 
x7 : fefefefefefefefe x6 : ffff7dfffe7fe014 
x5 : ffff000009169940 x4 : ffff000009147018 
x3 : 0000000000000001 x2 : 0000000000000000 
x1 : ffff00000815a3d0 x0 : 0000000000000000 
Call trace:
 smp_call_function_many+0xd4/0x350
 smp_call_function+0x38/0x68
 kick_all_cpus_sync+0x20/0x28
 kgdb_flush_swbreak_addr+0x14/0x20
 dbg_activate_sw_breakpoints+0x74/0xb0
 gdb_serial_stub+0x6ec/0xc80
 kgdb_cpu_enter+0x36c/0x578
 kgdb_handle_exception+0x130/0x238
 kgdb_compiled_brk_fn+0x28/0x38
 brk_handler+0x80/0xd8
 do_debug_exception+0x94/0x170
 el1_dbg+0x18/0x78
 kgdb_breakpoint+0x20/0x40
 run_breakpoint_test+0x58/0xb0
 configure_kgdbts+0x1b8/0x538
 init_kgdbts+0x1c/0x2c
 do_one_initcall+0x58/0x170
 kernel_init_freeable+0x184/0x22c
 kernel_init+0x10/0x108
 ret_from_fork+0x10/0x18

-- 
Catalin
