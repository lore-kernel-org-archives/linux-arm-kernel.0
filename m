From: geoff@infradead.org (Geoff Levand)
Date: Fri, 09 May 2014 00:48:17 +0000
Subject: [PATCH 6/8] arm64/kexec: kexec needs cpu_die
In-Reply-To: <cover.1399594544.git.geoff@infradead.org>
References: <cover.1399594544.git.geoff@infradead.org>
Message-ID: <4408c92fbc8f2f2a81054b9f2ac38331562e658a.1399594544.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kexec uses the cpu_die method of struct cpu_operations, so add
defined(CONFIG_KEXEC) to the preprocessor conditional that enables cpu_die.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/psci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index ea4828a..0e5fa69 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -253,7 +253,7 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
 	return err;
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
 static int cpu_psci_cpu_disable(unsigned int cpu)
 {
 	/* Fail early if we don't have CPU_OFF support */
@@ -284,7 +284,7 @@ const struct cpu_operations cpu_psci_ops = {
 	.cpu_init	= cpu_psci_cpu_init,
 	.cpu_prepare	= cpu_psci_cpu_prepare,
 	.cpu_boot	= cpu_psci_cpu_boot,
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
 	.cpu_disable	= cpu_psci_cpu_disable,
 	.cpu_die	= cpu_psci_cpu_die,
 #endif
-- 
1.9.1
