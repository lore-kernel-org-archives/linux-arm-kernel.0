From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Mar 2013 20:27:14 +0800
Subject: [PATCH] ARM: imx: fix sync issue between imx_cpu_die and imx_cpu_kill
Message-ID: <1364300834-8836-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a sync issue with hotplug operation.  It's possible that when
imx_cpu_kill gets running on primary core, the imx_cpu_die execution
on the core which is to be killed hasn't been finished yet.  The problem
will very likely be hit when running suspend without no_console_suspend
setting on kernel cmdline.

It uses cpu jumping argument register to sync imx_cpu_die and
imx_cpu_kill.  The register will be set in imx_cpu_die and imx_cpu_kill
will wait for the register being cleared to actually kill the cpu.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: <stable@vger.kernel.org>
---
 arch/arm/mach-imx/common.h  |    2 ++
 arch/arm/mach-imx/hotplug.c |   12 ++++++++++++
 arch/arm/mach-imx/src.c     |   12 ++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 5a800bf..5bf4a97 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -110,6 +110,8 @@ void tzic_handle_irq(struct pt_regs *);
 
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
+extern u32 imx_get_cpu_arg(int cpu);
+extern void imx_set_cpu_arg(int cpu, u32 arg);
 extern void v7_cpu_resume(void);
 extern u32 *pl310_get_save_ptr(void);
 #ifdef CONFIG_SMP
diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
index 7bc5fe1..361a253 100644
--- a/arch/arm/mach-imx/hotplug.c
+++ b/arch/arm/mach-imx/hotplug.c
@@ -46,11 +46,23 @@ static inline void cpu_enter_lowpower(void)
 void imx_cpu_die(unsigned int cpu)
 {
 	cpu_enter_lowpower();
+	/*
+	 * We use the cpu jumping argument register to sync with
+	 * imx_cpu_kill() which is running on cpu0 and waiting for
+	 * the register being cleared to kill the cpu.
+	 */
+	imx_set_cpu_arg(cpu, ~0);
 	cpu_do_idle();
 }
 
 int imx_cpu_kill(unsigned int cpu)
 {
+	unsigned long timeout = jiffies + msecs_to_jiffies(50);
+
+	while (imx_get_cpu_arg(cpu) == 0)
+		if (time_after(jiffies, timeout))
+			return 0;
 	imx_enable_cpu(cpu, false);
+	imx_set_cpu_arg(cpu, 0);
 	return 1;
 }
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index e15f155..09a742f 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -43,6 +43,18 @@ void imx_set_cpu_jump(int cpu, void *jump_addr)
 		       src_base + SRC_GPR1 + cpu * 8);
 }
 
+u32 imx_get_cpu_arg(int cpu)
+{
+	cpu = cpu_logical_map(cpu);
+	return readl_relaxed(src_base + SRC_GPR1 + cpu * 8 + 4);
+}
+
+void imx_set_cpu_arg(int cpu, u32 arg)
+{
+	cpu = cpu_logical_map(cpu);
+	writel_relaxed(arg, src_base + SRC_GPR1 + cpu * 8 + 4);
+}
+
 void imx_src_prepare_restart(void)
 {
 	u32 val;
-- 
1.7.9.5
