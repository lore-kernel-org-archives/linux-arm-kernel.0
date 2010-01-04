From: jamie.iles@picochip.com (Jamie Iles)
Date: Mon, 4 Jan 2010 12:26:24 +0000
Subject: [PATCH 4/5] arm: enable support for software perf events
In-Reply-To: <20100104111137.GC9107@n2100.arm.linux.org.uk>
References: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-2-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-3-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-4-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-5-git-send-email-jamie.iles@picochip.com>
	<20100104111137.GC9107@n2100.arm.linux.org.uk>
Message-ID: <20100104122624.GD4117@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2010 at 11:11:37AM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 04, 2010 at 10:48:41AM +0000, Jamie Iles wrote:
> > +/* Get the PC. Make sure that we have a 64bit value with the upper 32 cleared.
> > + */
> > +#define perf_instruction_pointer(_regs) \
> > +	((u64)instruction_pointer(regs) & 0xFFFFFFFFLU)
> 
> Maybe we should make pt_regs entries be unsigned instead of having this?
> Nothing should be affected by that change - and it looks like x86 went
> through this change, making two pt_regs structures, one for userspace
> with signed ints/longs, and one for kernel space with unsigned ints/longs.
> 
> I think it would make more sense to do that rather than litter the kernel
> with casts like the above.
Ok, how about this?

Jamie

[PATCH] arm ptrace: use unsigned types for kernel pt_regs

Make registers unsigned for kernel space. This is important for
example in the perf events where the PC is stored into a u64. We
don't want it sign extended so make the regs unsigned to prevent
casts throughout the kernel.

Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
---
 arch/arm/include/asm/ptrace.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index bbecccd..eec6e89 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -97,9 +97,15 @@
  * stack during a system call.  Note that sizeof(struct pt_regs)
  * has to be a multiple of 8.
  */
+#ifndef __KERNEL__
 struct pt_regs {
 	long uregs[18];
 };
+#else /* __KERNEL__ */
+struct pt_regs {
+	unsigned long uregs[18];
+};
+#endif /* __KERNEL__ */
 
 #define ARM_cpsr	uregs[16]
 #define ARM_pc		uregs[15]
-- 
1.6.5.4
