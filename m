From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 23 Feb 2012 10:53:35 +0200
Subject: [PATCH] ARM: OMAP2: fix mailbox init code
Message-ID: <1329987215-28227-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix this:

arch/arm/mach-omap2/mailbox.c: In function 'omap2_mbox_probe':
arch/arm/mach-omap2/mailbox.c:354: error: 'omap2_mboxes' undeclared (first use in this function)
arch/arm/mach-omap2/mailbox.c:354: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/mailbox.c:354: error: for each function it appears in.)

Which happens on CONFIG_ARCH_OMAP2 && !CONFIG_SOC_OMAP2420, due to
missing omap2_mboxes declaration.

In addition, make sure we declare the right mailbox instances for 2430.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 609ea2d..415a6f1 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -281,8 +281,16 @@ static struct omap_mbox mbox_iva_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_iva_priv,
 };
+#endif
 
-struct omap_mbox *omap2_mboxes[] = { &mbox_dsp_info, &mbox_iva_info, NULL };
+#ifdef CONFIG_ARCH_OMAP2
+struct omap_mbox *omap2_mboxes[] = {
+	&mbox_dsp_info,
+#ifdef CONFIG_SOC_OMAP2420
+	&mbox_iva_info,
+#endif
+	NULL
+};
 #endif
 
 #if defined(CONFIG_ARCH_OMAP4)
-- 
1.7.5.4
