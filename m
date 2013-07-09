From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 9 Jul 2013 13:02:14 +0530
Subject: [PATCH 07/12] ARM: DRA7: powerdomain: Handle missing vc/vp
In-Reply-To: <1373355139-12487-1-git-send-email-rnayak@ti.com>
References: <1373355139-12487-1-git-send-email-rnayak@ti.com>
Message-ID: <1373355139-12487-8-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRA7 belongs to the omap4plus devices which reuse the omap4_pwrdm_operations
ops for powerdomain control. DRA7 however has no VC/VP while all the
earlier omap4plus devices did.

So use the .pwrdm_has_voltdm() ops to pass this info on to the core.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 415c7e0..15271b6 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -620,6 +620,15 @@ static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 	return 0;
 }
 
+static int omap4_check_vcvp(void)
+{
+	/* No VC/VP on dra7xx devices */
+	if (soc_is_dra7xx())
+		return 0;
+
+	return 1;
+}
+
 struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
@@ -637,6 +646,7 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_set_mem_onst	= omap4_pwrdm_set_mem_onst,
 	.pwrdm_set_mem_retst	= omap4_pwrdm_set_mem_retst,
 	.pwrdm_wait_transition	= omap4_pwrdm_wait_transition,
+	.pwrdm_has_voltdm	= omap4_check_vcvp,
 };
 
 /*
-- 
1.7.9.5
