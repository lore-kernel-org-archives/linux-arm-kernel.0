From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Apr 2013 22:54:31 +0100
Subject: ARM: 7684/1: errata: Workaround for Cortex-A15 erratum 798181
 (TLBI/DSB operations)
In-Reply-To: <20130423100332.GA23407@arm.com>
References: <alpine.LFD.2.03.1304221641340.17375@syhkavp.arg>
 <20130423100332.GA23407@arm.com>
Message-ID: <20130423215431.GA46270@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 11:03:32AM +0100, Catalin Marinas wrote:
> On Mon, Apr 22, 2013 at 10:29:32PM +0100, Nicolas Pitre wrote:
> > The kernel spits out this on every fork():
> > 
> > BUG: using smp_processor_id() in preemptible [00000000] code: bash/1419
> > caller is broadcast_tlb_mm_a15_erratum+0x94/0xfc
> > [<c0014640>] (unwind_backtrace+0x0/0xf8) from [<c02074ec>] (debug_smp_processor_id+0xc4/0xe8)
> > [<c02074ec>] (debug_smp_processor_id+0xc4/0xe8) from [<c0013a3c>] (broadcast_tlb_mm_a15_erratum+0x94/0xfc)
> > [<c0013a3c>] (broadcast_tlb_mm_a15_erratum+0x94/0xfc) from [<c0020f28>] (dup_mm+0x30c/0x41c)
> > [<c0020f28>] (dup_mm+0x30c/0x41c) from [<c00217a4>] (copy_process.part.56+0x724/0xe20)
> > [<c00217a4>] (copy_process.part.56+0x724/0xe20) from [<c0021f54>] (do_fork+0x90/0x320)
> > [<c0021f54>] (do_fork+0x90/0x320) from [<c000e240>] (ret_fast_syscall+0x0/0x30)
> 
> So it needs preemption disabled, see below.
> 
> I'll double-check with the hardware guys whether the dummy TLBI can
> happen on any CPU (if we get preempted), otherwise I'll have to disable
> the preemption around both the local_flush_tlb_*() and broadcast_tlb_*()
> functions.

It looks like we have a slight problem even without this erratum. The
TLB invalidate and subsequent DSB must take place on the same CPU,
otherwise there is no guarantee that the broadcast TLB operation has
been completed on the other CPUs. We may get a DSB as part of a
spin_unlock during thread switching but it's safer to either add an
explicit DSB via __switch_to() or disable preemption during
flush_tlb_*() operations. I would go for the former since we have a
similar situation with cache maintenance. I'll check tomorrow.

-- 
Catalin
