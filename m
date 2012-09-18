From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 18 Sep 2012 15:12:51 -0600
Subject: [PATCH 2/3] ARM: OMAP4+: hwmod code: remove clkdm requirement in
 _omap4_wait_target_*()
In-Reply-To: <20120918211146.16484.85893.stgit@dusk.lan>
References: <20120918211146.16484.85893.stgit@dusk.lan>
Message-ID: <20120918211248.16484.93533.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're no longer requiring struct omap_hwmod records to contain a
clockdomain.  So we shouldn't return -EINVAL any more from
_omap4_wait_target_disable() or _omap4_wait_target_ready() if there's
no clockdomain defined, since that just gets passed back to the
caller.  This can result in pointless warnings under the relaxed data
format.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 37afbd1..80cea5b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -878,10 +878,10 @@ static void _omap4_enable_module(struct omap_hwmod *oh)
  */
 static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 {
-	if (!oh || !oh->clkdm)
+	if (!oh)
 		return -EINVAL;
 
-	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
+	if (oh->_int_flags & _HWMOD_NO_MPU_PORT || !oh->clkdm)
 		return 0;
 
 	if (oh->flags & HWMOD_NO_IDLEST)
@@ -2531,10 +2531,10 @@ static int _omap2_wait_target_ready(struct omap_hwmod *oh)
  */
 static int _omap4_wait_target_ready(struct omap_hwmod *oh)
 {
-	if (!oh || !oh->clkdm)
+	if (!oh)
 		return -EINVAL;
 
-	if (oh->flags & HWMOD_NO_IDLEST)
+	if (oh->flags & HWMOD_NO_IDLEST || !oh->clkdm)
 		return 0;
 
 	if (!_find_mpu_rt_port(oh))
