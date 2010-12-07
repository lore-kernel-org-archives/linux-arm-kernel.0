From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 06 Dec 2010 18:25:09 -0700
Subject: [PATCH 06/14] OMAP4: powerdomain: Add pwrdm_clear_all_prev_pwrst
In-Reply-To: <20101207012242.3708.45451.stgit@twilight.localdomain>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
Message-ID: <20101207012508.3708.67922.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Like OMAP3, OMAP4430 ES2 has additional bitfields in PWRSTST register
which help identify the previous power state entered by the
powerdomain.  Add pwrdm_clear_all_prev_pwrst to the OMAP4 powerdomains
implementation to support this.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[paul at pwsan.com: clarified commit message]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/powerdomain44xx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index 123a25f..2903c7c 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -55,6 +55,14 @@ static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 	return 0;
 }
 
+static int omap4_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
+{
+	prm_rmw_mod_reg_bits(OMAP4430_LASTPOWERSTATEENTERED_MASK,
+				OMAP4430_LASTPOWERSTATEENTERED_MASK,
+				pwrdm->prcm_offs, OMAP4_PM_PWSTST);
+	return 0;
+}
+
 static int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 {
 	u32 v;
@@ -155,6 +163,7 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
 	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
 	.pwrdm_set_lowpwrstchange	= omap4_pwrdm_set_lowpwrstchange,
+	.pwrdm_clear_all_prev_pwrst	= omap4_pwrdm_clear_all_prev_pwrst,
 	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
 	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
 	.pwrdm_read_logic_retst	= omap4_pwrdm_read_logic_retst,
