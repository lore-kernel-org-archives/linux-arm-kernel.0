From: geoff@infradead.org (Geoff Levand)
Date: Tue, 09 Sep 2014 22:49:05 +0000
Subject: [PATCH 09/13] arm64/kexec: Kexec expects cpu_die
In-Reply-To: <cover.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
Message-ID: <8760d3e11621065a78236e91724875f0e1cfadf4.1410302383.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 implementation of kexec expects an operational cpu_die method of
struct cpu_operations, so add defined(CONFIG_KEXEC) to the preprocessor
conditional that enables cpu_die.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/cpu_ops.h | 2 +-
 arch/arm64/kernel/psci.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index d7b4b38..9fd7281 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -50,7 +50,7 @@ struct cpu_operations {
 	int		(*cpu_prepare)(unsigned int);
 	int		(*cpu_boot)(unsigned int);
 	void		(*cpu_postboot)(void);
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
 	int		(*cpu_disable)(unsigned int cpu);
 	void		(*cpu_die)(unsigned int cpu);
 	int		(*cpu_kill)(unsigned int cpu);
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 5539547..81dbbc9 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -380,7 +380,7 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
 	return err;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
 static int cpu_psci_cpu_disable(unsigned int cpu)
 {
 	/* Fail early if we don't have CPU_OFF support */
@@ -442,7 +442,7 @@ const struct cpu_operations cpu_psci_ops = {
 	.cpu_init	= cpu_psci_cpu_init,
 	.cpu_prepare	= cpu_psci_cpu_prepare,
 	.cpu_boot	= cpu_psci_cpu_boot,
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
 	.cpu_disable	= cpu_psci_cpu_disable,
 	.cpu_die	= cpu_psci_cpu_die,
 	.cpu_kill	= cpu_psci_cpu_kill,
-- 
1.9.1
