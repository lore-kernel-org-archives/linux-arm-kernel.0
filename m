From: geoff@infradead.org (Geoff Levand)
Date: Fri, 09 May 2014 00:48:17 +0000
Subject: [PATCH 3/8] arm64: Add spin-table cpu_die
In-Reply-To: <cover.1399594544.git.geoff@infradead.org>
References: <cover.1399594544.git.geoff@infradead.org>
Message-ID: <56b0c0f2834cba63db1f75966f2ee756ab347205.1399594544.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two new minimal routines smp_spin_table_cpu_disable() and
smp_spin_table_cpu_die() and hook them up to the smp_spin_table_ops instance.

Kexec support will use smp_spin_table_cpu_die() for re-boot of spin table CPUs,
but also needs a compatible smp_spin_table_cpu_disable() to allow
execution to reach smp_spin_table_cpu_die().

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/smp_spin_table.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 7a530d2..26c780b 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -142,10 +142,23 @@ static void smp_spin_table_cpu_postboot(void)
 	raw_spin_unlock(&boot_lock);
 }
 
+static int smp_spin_table_cpu_disable(unsigned int cpu)
+{
+	return 0;
+}
+
+static void smp_spin_table_cpu_die(unsigned int cpu)
+{
+	while (1)
+		cpu_relax();
+}
+
 const struct cpu_operations smp_spin_table_ops = {
 	.name		= "spin-table",
 	.cpu_init	= smp_spin_table_cpu_init,
 	.cpu_prepare	= smp_spin_table_cpu_prepare,
 	.cpu_boot	= smp_spin_table_cpu_boot,
 	.cpu_postboot	= smp_spin_table_cpu_postboot,
+	.cpu_disable	= smp_spin_table_cpu_disable,
+	.cpu_die	= smp_spin_table_cpu_die,
 };
-- 
1.9.1
