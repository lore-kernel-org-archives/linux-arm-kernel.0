From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  5 Jan 2017 17:32:36 +0000
Subject: [PATCH] ARM: hw_breakpoint: blacklist Scorpion CPUs
Message-ID: <1483637556-3974-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On APQ8060, the kernel crashes in arch_hw_breakpoint_init, taking an
undefined instruction trap within write_wb_reg. This is because Scorpion
CPUs erroneously appear to set DBGPRSR.SPD when WFI is issued, even if
the core is not powered down. When DBGPRSR.SPD is set, breakpoint and
watchpoint registers are treated as undefined.

It's possible to trigger similar crashes later on from userspace, by
requesting the kernel to install a breakpoint or watchpoint, as we can
go idle at any point between the reset of the debug registers and their
later use. This has always been the case.

Given that this has always been broken, no-one has complained until now,
and there is no clear workaround, disable hardware breakpoints and
watchpoints on Scorpion to avoid these issues.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: stable at vger.kernel.org
---
 arch/arm/include/asm/cputype.h  |  3 +++
 arch/arm/kernel/hw_breakpoint.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 522b5fe..b62eaeb 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -94,6 +94,9 @@
 #define ARM_CPU_XSCALE_ARCH_V2		0x4000
 #define ARM_CPU_XSCALE_ARCH_V3		0x6000
 
+/* Qualcomm implemented cores */
+#define ARM_CPU_PART_SCORPION		0x510002d0
+
 extern unsigned int processor_id;
 
 #ifdef CONFIG_CPU_CP15
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 188180b..5d68ff9 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -1063,6 +1063,22 @@ static int __init arch_hw_breakpoint_init(void)
 		return 0;
 	}
 
+	/*
+	 * Scorpion CPUs (at least those in APQ8060) seem to set DBGPRSR.SPD
+	 * whenever a WFI is issued, even if the core is not powered down, in
+	 * violation of the architecture.  When DBGPRSR.SPD is set, accesses to
+	 * breakpoint and watchpoint registers are treated as undefined, so
+	 * this results in boot time and runtime failures when these are
+	 * accessed and we unexpectedly take a trap.
+	 *
+	 * It's not clear if/how this can be worked around, so we blacklist
+	 * Scorpion CPUs to avoid these issues.
+	*/
+	if (read_cpuid_part() == ARM_CPU_PART_SCORPION) {
+		pr_info("Scorpion CPU detected. Breakpoints and watchpoints disabled\n");
+		return 0;
+	}
+
 	has_ossr = core_has_os_save_restore();
 
 	/* Determine how many BRPs/WRPs are available. */
-- 
1.9.1
