From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 24 Apr 2017 09:40:02 +0100
Subject: [PATCH v3 15/18] arm64: arch_timer: Enable CNTVCT_EL0 trap if
 workaround is enabled
In-Reply-To: <AF3DCEF48831C6498A12720ADD13CD7F2A5DACA8@dggeml506-mbs.china.huawei.com>
References: <20170404171826.25030-1-marc.zyngier@arm.com>
 <20170404171826.25030-16-marc.zyngier@arm.com> <58FDB05B.6020108@huawei.com>
 <95ac3477-436a-22ad-80f4-d4bed6c73e1c@arm.com>
 <AF3DCEF48831C6498A12720ADD13CD7F2A5DACA8@dggeml506-mbs.china.huawei.com>
Message-ID: <493e2b26-96a2-4b92-fd4b-f6f7d5c89fb5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/17 09:25, Lixiaoping (Timmy) wrote:
> Hi Marc,
> 
> Sorry about previous email's confidential info. Please forget it.
> 
> +#define ESR_ELx_SYS64_ISS_SYS_CNTFRQ	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 14, 0, 0) | \
> +					 ESR_ELx_SYS64_ISS_DIR_READ)
> 
> I think (3, 3, 14, 0, 0) should be (3, 3, 0, 14, 0)?

Thanks for spotting this. I assumed that the sys_reg() and
SR_ELx_SYS64_ISS_SYS_VAL() macros took their arguments in the same 
order. That would have been too easy... ;-)

Amended patch below, please let me know if it works for you.

Thanks,

	M.

>From 4444c86a97c1a487e12c319fdc197c88631d72b5 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Mon, 24 Apr 2017 09:04:03 +0100
Subject: [PATCH] arm64: Add CNTFRQ_EL0 trap handler

We now trap accesses to CNTVCT_EL0 when the counter is broken
enough to require the kernel to mediate the access. But it
turns out that some existing userspace (such as OpenMPI) do
probe for the counter frequency, leading to an UNDEF exception
as CNTVCT_EL0 and CNTFRQ_EL0 share the same control bit.

The fix is to handle the exception the same way we do for CNTVCT_EL0.

Fixes: a86bd139f2ae ("arm64: arch_timer: Enable CNTVCT_EL0 trap if workaround is enabled")
Reported-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/esr.h |  4 ++++
 arch/arm64/kernel/traps.c    | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index ad42e79a5d4d..85997c0e5443 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -177,6 +177,10 @@
 
 #define ESR_ELx_SYS64_ISS_SYS_CNTVCT	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 2, 14, 0) | \
 					 ESR_ELx_SYS64_ISS_DIR_READ)
+
+#define ESR_ELx_SYS64_ISS_SYS_CNTFRQ	(ESR_ELx_SYS64_ISS_SYS_VAL(3, 3, 0, 14, 0) | \
+					 ESR_ELx_SYS64_ISS_DIR_READ)
+
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 1de444e6c669..d4d6ae02cd55 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -513,6 +513,14 @@ static void cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
 	regs->pc += 4;
 }
 
+static void cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
+{
+	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
+
+	pt_regs_write_reg(regs, rt, read_sysreg(cntfrq_el0));
+	regs->pc += 4;
+}
+
 struct sys64_hook {
 	unsigned int esr_mask;
 	unsigned int esr_val;
@@ -537,6 +545,12 @@ static struct sys64_hook sys64_hooks[] = {
 		.esr_val = ESR_ELx_SYS64_ISS_SYS_CNTVCT,
 		.handler = cntvct_read_handler,
 	},
+	{
+		/* Trap read access to CNTFRQ_EL0 */
+		.esr_mask = ESR_ELx_SYS64_ISS_SYS_OP_MASK,
+		.esr_val = ESR_ELx_SYS64_ISS_SYS_CNTFRQ,
+		.handler = cntfrq_read_handler,
+	},
 	{},
 };
 
-- 
2.11.0


-- 
Jazz is not dead. It just smells funny...
