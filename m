From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 24 Jan 2013 01:27:51 -0500
Subject: [PATCH v2 08/16] ARM: bL_platsmp.c: close the kernel entry gate before
 hot-unplugging a CPU
In-Reply-To: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
References: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1359008879-9015-9-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If for whatever reason a CPU is unexpectedly awaken, it shouldn't
re-enter the kernel by using whatever entry vector that might have
been set by a previous operation.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_platsmp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/common/bL_platsmp.c b/arch/arm/common/bL_platsmp.c
index e28dd50640..c3835b0e29 100644
--- a/arch/arm/common/bL_platsmp.c
+++ b/arch/arm/common/bL_platsmp.c
@@ -63,6 +63,11 @@ static int bL_cpu_disable(unsigned int cpu)
 
 static void __ref bL_cpu_die(unsigned int cpu)
 {
+	unsigned int mpidr, pcpu, pcluster;
+	mpidr = read_cpuid_mpidr();
+	pcpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	pcluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	bL_set_entry_vector(pcpu, pcluster, NULL);
 	bL_cpu_power_down();
 }
 
-- 
1.8.0
