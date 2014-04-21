From: elder@linaro.org (Alex Elder)
Date: Mon, 21 Apr 2014 16:53:10 -0500
Subject: [PATCH v2 09/10] ARM: bcm: rewrite commentary for bcm_kona_do_smc()
In-Reply-To: <1398117191-2433-1-git-send-email-elder@linaro.org>
References: <1398117191-2433-1-git-send-email-elder@linaro.org>
Message-ID: <1398117191-2433-10-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The block of comments in bcm_kona_do_smc() are somewhat confusing.
This patch attempts to clarify what's going on.

Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <mporter@linaro.org>
---
 arch/arm/mach-bcm/bcm_kona_smc.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
index cc81c86..a55a7ec 100644
--- a/arch/arm/mach-bcm/bcm_kona_smc.c
+++ b/arch/arm/mach-bcm/bcm_kona_smc.c
@@ -77,16 +77,34 @@ int __init bcm_kona_smc_init(void)
 }
 
 /*
- * Since interrupts are disabled in the open mode, we must keep
- * interrupts disabled in secure mode by setting R5=0x3. If interrupts
- * are enabled in open mode, we can set R5=0x0 to allow interrupts in
- * secure mode.  If we did this, the secure monitor would return back
- * control to the open mode to handle the interrupt prior to completing
- * the secure service. If this happened, R12 would not be
- * SEC_EXIT_NORMAL and we would need to call SMC again after resetting
- * R5 (it gets clobbered by the secure monitor) and setting R4 to
- * SSAPI_RET_FROM_INT_SERV to indicate that we want the secure monitor
- * to finish up the previous uncompleted secure service.
+ * int bcm_kona_do_smc(u32 service_id, u32 buffer_addr)
+ *
+ * Only core 0 can run the secure monitor code.  If an "smc" request
+ * is initiated on a different core it must be redirected to core 0
+ * for execution.  We rely on the caller to handle this.
+ *
+ * Each "smc" request supplies a service id and the address of a
+ * buffer containing parameters related to the service to be
+ * performed.  A flags value defines the behavior of the level 2
+ * cache and interrupt handling while the secure monitor executes.
+ *
+ * Parameters to the "smc" request are passed in r4-r6 as follows:
+ *     r4	service id
+ *     r5	flags (SEC_ROM_*)
+ *     r6	physical address of buffer with other parameters
+ *
+ * Execution of an "smc" request produces two distinct results.
+ *
+ * First, the secure monitor call itself (regardless of the specific
+ * service request) can succeed, or can produce an error.  When an
+ * "smc" request completes this value is found in r12; it should
+ * always be SEC_EXIT_NORMAL.
+ *
+ * In addition, the particular service performed produces a result.
+ * The values that should be expected depend on the service.  We
+ * therefore return this value to the caller, so it can handle the
+ * request result appropriately.  This result value is found in r0
+ * when the "smc" request completes.
  */
 static int bcm_kona_do_smc(u32 service_id, u32 buffer_phys)
 {
-- 
1.9.1
