From: Frank.Li@nxp.com (Frank Li)
Date: Tue, 5 Jan 2016 11:17:17 -0600
Subject: [PATCH v2 4/4] ARM: imx7d: correct chip version information
In-Reply-To: <1452014237-12848-1-git-send-email-Frank.Li@nxp.com>
References: <1452014237-12848-1-git-send-email-Frank.Li@nxp.com>
Message-ID: <1452014237-12848-4-git-send-email-Frank.Li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

The commond 'cat /sys/devices/soc0/revision' can
show correct soc version information.

"unknow revision" message in imx_print_silicon_rev()
will never work for digprog.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
Change from v1 to v2:
 fix grammer issues in comments.

 arch/arm/mach-imx/anatop.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 231bb25..bd3555e 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -151,7 +151,14 @@ void __init imx_init_revision_from_anatop(void)
 		revision = IMX_CHIP_REVISION_1_5;
 		break;
 	default:
-		revision = IMX_CHIP_REVISION_UNKNOWN;
+		/*
+		 * Fail back to return raw register value instead of 0xff.
+		 * It will be easy to know version information in SOC if it
+		 * can't be recognized by known version. And some chip's (i.MX7D)
+		 * digprog value match linux version format, so it needn't map
+		 * again and we can use register value directly.
+		 */
+		revision = digprog & 0xff;
 	}
 
 	mxc_set_cpu_type(digprog >> 16 & 0xff);
-- 
2.5.2
