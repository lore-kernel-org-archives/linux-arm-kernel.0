From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 08 Feb 2012 16:37:29 +0000
Subject: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Message-ID: <E1RvAWP-0006H3-1A@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While testing on my OMAP3430 platform, this error message was emitted:

omap_vc_init_channel: PMIC info requried to configure vc forvdd_core not populated.Hence cannot initialize vc

Trying to find this message was difficult because it was wrapped across
several lines.  It also mis-spells "required", doesn't read very well,
and has spaces lacking.  Let's replace it with a more concise:

omap_vc_init_channel: No PMIC info for vdd_core

While we're here, fix a simple spelling error in a comment.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/vc.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 031d116..ce45695 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -247,7 +247,7 @@ static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
  * omap_vc_i2c_init - initialize I2C interface to PMIC
  * @voltdm: voltage domain containing VC data
  *
- * Use PMIC supplied seetings for I2C high-speed mode and
+ * Use PMIC supplied settings for I2C high-speed mode and
  * master code (if set) and program the VC I2C configuration
  * register.
  *
@@ -292,8 +292,7 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	u32 val;
 
 	if (!voltdm->pmic || !voltdm->pmic->uv_to_vsel) {
-		pr_err("%s: PMIC info requried to configure vc for"
-			"vdd_%s not populated.Hence cannot initialize vc\n",
+		pr_err("%s: No PMIC info for vdd_%s\n",
 			__func__, voltdm->name);
 		return;
 	}
-- 
1.7.4.4
