From: elder@linaro.org (Alex Elder)
Date: Thu, 17 Apr 2014 21:30:06 -0500
Subject: [PATCH 01/10] ARM: bcm: use memory accessors for ioremapped area
In-Reply-To: <1397788215-20279-1-git-send-email-elder@linaro.org>
References: <1397788215-20279-1-git-send-email-elder@linaro.org>
Message-ID: <1397788215-20279-2-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pointer used to pass parameters to an "smc" call is produced
through a call to ioremap().  As such, we should be using functions
like writel() to access it.

Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Matt Porter <mporter@linaro.org>
---
 arch/arm/mach-bcm/bcm_kona_smc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
index 5e31e91..d881c72 100644
--- a/arch/arm/mach-bcm/bcm_kona_smc.c
+++ b/arch/arm/mach-bcm/bcm_kona_smc.c
@@ -79,11 +79,11 @@ static void __bcm_kona_smc(void *info)
 	/* Check map in the bounce area */
 	BUG_ON(!bridge_data.initialized);
 
-	/* Copy one 32 bit word into the bounce area */
-	args[0] = data->arg0;
-	args[1] = data->arg1;
-	args[2] = data->arg2;
-	args[3] = data->arg3;
+	/* Copy the four 32 bit argument values into the bounce area */
+	writel_relaxed(data->arg0, args++);
+	writel_relaxed(data->arg1, args++);
+	writel_relaxed(data->arg2, args++);
+	writel(data->arg3, args);
 
 	/* Flush caches for input data passed to Secure Monitor */
 	if (data->service_id != SSAPI_BRCM_START_VC_CORE)
-- 
1.7.9.5
