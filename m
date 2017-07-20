From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Thu, 20 Jul 2017 02:29:24 +0200
Subject: [PATCH 5/9] ARM: trusted_foundations: announce firmware version
In-Reply-To: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
References: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
Message-ID: <90ad41ff1b54695154348c0c7f9333ed9e162ce3.1500510157.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Announce Trusted Foundations version for debugging and documentation.

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 arch/arm/firmware/trusted_foundations.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 81ff71b87438..105655802dfd 100644
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
 
-static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
+static u64 __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
 {
 	asm volatile(
 		".arch_extension	sec\n\t"
@@ -54,6 +56,7 @@ static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
 		:
 		: "r" (type), "r" (arg1), "r" (arg2)
 		: "memory");
+	return 0;  /* silence gcc warning */
 }
 
 static int tf_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
@@ -106,6 +109,11 @@ static int tf_init_cache(void)
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
@@ -116,6 +124,12 @@ static const struct firmware_ops trusted_foundations_ops = {
 
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
@@ -141,5 +155,6 @@ void of_register_trusted_foundations(void)
 				   &pdata.version_minor);
 	if (err != 0)
 		panic("Trusted Foundation: missing version-minor property\n");
+
 	register_trusted_foundations(&pdata);
 }
-- 
2.11.0
