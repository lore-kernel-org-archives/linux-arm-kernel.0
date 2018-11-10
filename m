From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Sat, 10 Nov 2018 22:02:23 +0100
Subject: [PATCH 3/3] ARM: trusted_foundations: announce firmware version
In-Reply-To: <cover.1541882833.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541882833.git.mirq-linux@rere.qmqm.pl>
Message-ID: <86834d26d87aa31ccb48c49e932f01274f1d4058.1541882833.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Announce Trusted Foundations version for debugging and documentation.

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 arch/arm/firmware/trusted_foundations.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 135068119453..e59f44fcda35 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -30,6 +30,8 @@
 #define TF_CACHE_FLUSH		2
 #define TF_CACHE_REENABLE	4
 
+#define TF_GET_PROTOCOL_VERSION	0xfffffffb
+
 #define TF_CPU_PM		0xfffffffc
 #define TF_CPU_PM_S3		0xffffffe3
 #define TF_CPU_PM_S2		0xffffffe6
@@ -39,7 +41,7 @@
 
 static unsigned long cpu_boot_addr;
 
-static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
+static u64 tf_generic_smc(u32 type, u32 arg1, u32 arg2)
 {
 	register u32 r0 asm("r0") = type;
 	register u32 r1 asm("r1") = arg1;
@@ -55,9 +57,10 @@ static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
 		"mov	r4, #0\n\t"
 		"smc	#0\n\t"
 		"ldmfd	sp!, {r4 - r11}\n\t"
-		:
-		: "r" (r0), "r" (r1), "r" (r2)
+		: "+r" (r0), "+r" (r1)
+		: "r" (r2)
 		: "memory", "r3", "r12", "lr");
+	return ((u64)r1 << 32) | r0;
 }
 
 static int tf_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
@@ -110,6 +113,11 @@ static int tf_init_cache(void)
 }
 #endif /* CONFIG_CACHE_L2X0 */
 
+static u32 tf_get_protocol_version(void)
+{
+	return tf_generic_smc(TF_GET_PROTOCOL_VERSION, 0, 0) >> 48;
+}
+
 static const struct firmware_ops trusted_foundations_ops = {
 	.set_cpu_boot_addr = tf_set_cpu_boot_addr,
 	.prepare_idle = tf_prepare_idle,
@@ -120,6 +128,12 @@ static const struct firmware_ops trusted_foundations_ops = {
 
 void register_trusted_foundations(struct trusted_foundations_platform_data *pd)
 {
+	unsigned int protocol = tf_get_protocol_version();
+
+	pr_info("TF: version %u.%u, protocol %u.%u\n",
+		pd->version_major, pd->version_minor,
+		protocol >> 8, protocol & 0xFF);
+
 	/*
 	 * we are not using version information for now since currently
 	 * supported SMCs are compatible with all TF releases
@@ -145,5 +159,6 @@ void of_register_trusted_foundations(void)
 				   &pdata.version_minor);
 	if (err != 0)
 		panic("Trusted Foundation: missing version-minor property\n");
+
 	register_trusted_foundations(&pdata);
 }
-- 
2.19.1
