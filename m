From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Nov 2012 11:47:31 +0000
Subject: [PATCH] ARM: perf: fix link error when CONFIG_HW_PERF_EVENTS is not
 selected
Message-ID: <1353584851-17842-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e50c541 (ARM: perf: add guest vs host discrimination) broken the
link as perf_instruction_pointer and perf_misc_flags are not defined
when CONFIG_HW_PERF_EVENTS is not selected.

As it make little sense to try and profile a guest without any HW event,
just fallback to the original code when this config option is not selected.

Reported-by: Russell King <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index 00416ed..7558775 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -21,9 +21,11 @@
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
 #define CACHE_OP_UNSUPPORTED		0xFFFF
 
+#ifdef CONFIG_HW_PERF_EVENTS
 struct pt_regs;
 extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
 extern unsigned long perf_misc_flags(struct pt_regs *regs);
 #define perf_misc_flags(regs)	perf_misc_flags(regs)
+#endif
 
 #endif /* __ARM_PERF_EVENT_H__ */
-- 
1.7.12
