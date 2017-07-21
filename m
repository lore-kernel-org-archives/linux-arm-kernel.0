From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:27 +0100
Subject: [PATCH 01/16] arm64: Use arch_timer_get_rate when trapping CNTFRQ_EL0
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In an ideal world, CNTFRQ_EL0 always contains the timer frequency
for the kernel to use. Sadly, we get quite a few broken systems
where the firmware authors cannot be bothered to program that
register on all CPUs, and rely on DT to provide that frequency.

So when trapping CNTFRQ_EL0, make sure to return the actual rate
(as known by the kernel), and not CNTFRQ_EL0.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c7c7088097be..b02295673216 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -519,7 +519,7 @@ static void cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
 {
 	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
 
-	pt_regs_write_reg(regs, rt, read_sysreg(cntfrq_el0));
+	pt_regs_write_reg(regs, rt, arch_timer_get_rate());
 	regs->pc += 4;
 }
 
-- 
2.11.0
