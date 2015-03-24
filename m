From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 24 Mar 2015 18:06:15 +0000 (UTC)
Subject: [PATCH 2/2] ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4
In-Reply-To: <1426539294-28375-3-git-send-email-s-anna@ti.com>
References: <1426539294-28375-1-git-send-email-s-anna@ti.com>
 <1426539294-28375-3-git-send-email-s-anna@ti.com>
Message-ID: <alpine.DEB.2.02.1503241805060.16497@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Mar 2015, Suman Anna wrote:

> GPTimer 4 is a regular timer and not a secure timer, so fix
> the hwmod to use the correct hwmod class (even though there
> are no differences in the class definition itself).
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

This one results in compiler warnings:

arch/arm/mach-omap2/omap_hwmod_7xx_data.c:1776:32: warning: 
?dra7xx_timer_secure_hwmod_class? defined but not used [-Wunused-variable]
 static struct omap_hwmod_class dra7xx_timer_secure_hwmod_class = {

Have queued the following for v4.1.


- Paul

From: Suman Anna <s-anna@ti.com>
Date: Mon, 16 Mar 2015 15:54:54 -0500
Subject: [PATCH] ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4

GPTimer 4 is a regular timer and not a secure timer, so fix
the hwmod to use the correct hwmod class (even though there
are no differences in the class definition itself).

Signed-off-by: Suman Anna <s-anna@ti.com>
[paul at pwsan.com: dropped dra7xx_timer_secure_hwmod_class and
 dra7xx_timer_secure_sysc to avoid compiler warnings]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index d0f03e73add4..701234d8db1b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1763,21 +1763,6 @@ static struct omap_hwmod_class dra7xx_timer_1ms_hwmod_class = {
 	.sysc	= &dra7xx_timer_1ms_sysc,
 };
 
-static struct omap_hwmod_class_sysconfig dra7xx_timer_secure_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x0010,
-	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_RESET_STATUS |
-			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type2,
-};
-
-static struct omap_hwmod_class dra7xx_timer_secure_hwmod_class = {
-	.name	= "timer",
-	.sysc	= &dra7xx_timer_secure_sysc,
-};
-
 static struct omap_hwmod_class_sysconfig dra7xx_timer_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
@@ -1841,7 +1826,7 @@ static struct omap_hwmod dra7xx_timer3_hwmod = {
 /* timer4 */
 static struct omap_hwmod dra7xx_timer4_hwmod = {
 	.name		= "timer4",
-	.class		= &dra7xx_timer_secure_hwmod_class,
+	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.main_clk	= "timer4_gfclk_mux",
 	.prcm = {
-- 
2.1.4
