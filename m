From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 14 Oct 2009 16:56:18 +0530
Subject: SMP: BUG with PREEMPT enabled
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BB254F8D@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BB254F8D@dbde02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB2555BF@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Shilimkar, Santosh
> Sent: Tuesday, October 13, 2009 5:33 PM
> To: Russell King - ARM Linux
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: ARM: SMP: BUG with PREEMPT enabled
> 
> Russell,
> 
> On the latest ARM kernel(v2.6.32-rc4),I have observed a BUG() dump when
> PREEMPT is enabled.
> Attached is the detailed log for your reference.
> 
> <snip>
> **********************************************************
> BUG: using smp_processor_id() in preemptible [00000000] code: init/1
> caller is flush_tlb_mm+0x44/0x70
> Backtrace:
> [<c00225c4>] (dump_backtrace+0x0/0x110) from [<c01713a0>]
> (dump_stack+0x18/0x1c)
>  r7:00000000 r6:c00234f0 r5:00000001 r4:c7828000
> [<c0171388>] (dump_stack+0x0/0x1c) from [<c0135364>]
> (debug_smp_processor_id+0xc0/0xf0)
> [<c01352a4>] (debug_smp_processor_id+0x0/0xf0) from [<c00234f0>]
> (flush_tlb_mm+0x44/0x70)
>  r7:00000000 r6:c60b41a0 r5:c60b4154 r4:00000001
> [<c00234ac>] (flush_tlb_mm+0x0/0x70) from [<c0039568>]
> (dup_mm+0x304/0x38c)
>  r5:c1f09058 r4:00000000
> [<c0039264>] (dup_mm+0x0/0x38c) from [<c0039de4>]
> (copy_process+0x7b8/0xeb0)
> [<c003962c>] (copy_process+0x0/0xeb0) from [<c003a638>]
> (do_fork+0x15c/0x29c)
> [<c003a4dc>] (do_fork+0x0/0x29c) from [<c0021df0>] (sys_clone+0x34/0x3c)
> [<c0021dbc>] (sys_clone+0x0/0x3c) from [<c001efa0>]
> (ret_fast_syscall+0x0/0x2c)
> **************************************************************
> 
> As evident from the log " smp_processor_id " is used in preemptible code.
> This gets triggered from
> flush_tlb_mm() -->
> 	local_flush_tlb_mm()
> 	{
> 		if (cpu_isset(smp_processor_id(), vma->vm_mm->cpu_vm_mask)) ^^
> 	}
> 
> This can be guuarded using "get_cpu/put_cpu" pair which can make it
> preemption safe but I am not sure whether that is the right fix.
> 
> Let me know your remarks !!

Here is the patch I used to fix this BUG.
