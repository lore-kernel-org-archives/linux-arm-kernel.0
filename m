From: Frank.Li@freescale.com (Frank Li)
Date: Mon, 14 Dec 2015 15:46:22 -0600
Subject: [PATCH 1/1] arm: imx7d: correct chip version information
Message-ID: <1450129582-4261-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

show correct soc version infomation.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/mach-imx/anatop.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 231bb25..23a4fc1 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -151,7 +151,14 @@ void __init imx_init_revision_from_anatop(void)
 		revision = IMX_CHIP_REVISION_1_5;
 		break;
 	default:
-		revision = IMX_CHIP_REVISION_UNKNOWN;
+		/*
+		 * Fail back to return raw register value instead of 0xff.
+		 * It will be easy know version information in SOC if it
+		 * can't recongized by known version. And some chip like
+		 * i.MX7D soc digprog value match linux version format,
+		 * needn't map again and direct use register value.
+		 */
+		revision = digprog & 0xff;
 	}
 
 	mxc_set_cpu_type(digprog >> 16 & 0xff);
-- 
2.5.2
