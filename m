From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 23 Jan 2012 13:29:53 -0200
Subject: [PATCH] ARM: mx28: Remove duplicate OCOTP error message
Message-ID: <1327332593-27534-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxs_get_ocotp() function already prints an error message in the case of 
a timeout, so no need to print them again in the board files.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mxs/mach-m28evk.c  |    5 +----
 arch/arm/mach-mxs/mach-mx28evk.c |    6 +-----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-m28evk.c b/arch/arm/mach-mxs/mach-m28evk.c
index 2f27582..eec1257 100644
--- a/arch/arm/mach-mxs/mach-m28evk.c
+++ b/arch/arm/mach-mxs/mach-m28evk.c
@@ -247,11 +247,8 @@ static int __init m28evk_fec_get_mac(void)
 	u32 val;
 	const u32 *ocotp = mxs_get_ocotp();
 
-	if (!ocotp) {
-		pr_err("%s: timeout when reading fec mac from OCOTP\n",
-			__func__);
+	if (!ocotp)
 		return -ETIMEDOUT;
-	}
 
 	/*
 	 * OCOTP only stores the last 4 octets for each mac address,
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index fdb0a56..f1cbf34 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -278,7 +278,7 @@ static int __init mx28evk_fec_get_mac(void)
 	const u32 *ocotp = mxs_get_ocotp();
 
 	if (!ocotp)
-		goto error;
+		return -ETIMEDOUT;
 
 	/*
 	 * OCOTP only stores the last 4 octets for each mac address,
@@ -295,10 +295,6 @@ static int __init mx28evk_fec_get_mac(void)
 	}
 
 	return 0;
-
-error:
-	pr_err("%s: timeout when reading fec mac from OCOTP\n", __func__);
-	return -ETIMEDOUT;
 }
 
 /*
-- 
1.7.1
