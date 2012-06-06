From: tony@atomide.com (Tony Lindgren)
Date: Wed, 06 Jun 2012 01:22:48 -0700
Subject: [PATCH 2/3] ARM: OMAP3: Fix omap3_l3_block_irq warning when
 CONFIG_BUG is not set
In-Reply-To: <20120606082156.727.42730.stgit@muffinssi.local>
References: <20120606082156.727.42730.stgit@muffinssi.local>
Message-ID: <20120606082248.727.37364.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we will get:

arch/arm/mach-omap2/omap_l3_smx.c: In function ?omap3_l3_block_irq?:
arch/arm/mach-omap2/omap_l3_smx.c:156: warning: unused variable ?address?
arch/arm/mach-omap2/omap_l3_smx.c:155: warning: unused variable ?multi?
arch/arm/mach-omap2/omap_l3_smx.c:154: warning: unused variable ?initid?
arch/arm/mach-omap2/omap_l3_smx.c:153: warning: unused variable ?code?
arch/arm/mach-omap2/omap_l3_smx.c: At top level:
arch/arm/mach-omap2/omap_l3_smx.c:68: warning: ?omap3_l3_code_string? defined but not used
arch/arm/mach-omap2/omap_l3_smx.c:90: warning: ?omap3_l3_initiator_string? defined but not used

Fix it by always showing the L3 error.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_l3_smx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
index a05a62f..acc2164 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.c
+++ b/arch/arm/mach-omap2/omap_l3_smx.c
@@ -155,10 +155,11 @@ static irqreturn_t omap3_l3_block_irq(struct omap3_l3 *l3,
 	u8 multi = error & L3_ERROR_LOG_MULTI;
 	u32 address = omap3_l3_decode_addr(error_addr);
 
-	WARN(true, "%s seen by %s %s at address %x\n",
+	pr_err("%s seen by %s %s at address %x\n",
 			omap3_l3_code_string(code),
 			omap3_l3_initiator_string(initid),
 			multi ? "Multiple Errors" : "", address);
+	WARN_ON(1);
 
 	return IRQ_HANDLED;
 }
