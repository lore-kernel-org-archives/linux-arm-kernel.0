From: julien.grall@linaro.org (Julien Grall)
Date: Thu, 12 Feb 2015 06:34:57 +0000
Subject: [PATCH 1/2] arm/xen: Correctly check if the event channel interrupt
 is present
In-Reply-To: <1423722898-16110-1-git-send-email-julien.grall@linaro.org>
References: <1423722898-16110-1-git-send-email-julien.grall@linaro.org>
Message-ID: <1423722898-16110-2-git-send-email-julien.grall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function irq_of_parse_and_map returns 0 when the IRQ is not found.

Furthermore xen_events_irq is only read when the CPU is bring up, so
it's not necessary to use the attribute __read_mostly.

Lastly, move the check before notifying the user that we are running on
Xen.

Signed-off-by: Julien Grall <julien.grall@linaro.org>
---
 arch/arm/xen/enlighten.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 263a204..90101c8 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -51,7 +51,7 @@ EXPORT_SYMBOL_GPL(xen_have_vector_callback);
 int xen_platform_pci_unplug = XEN_UNPLUG_ALL;
 EXPORT_SYMBOL_GPL(xen_platform_pci_unplug);
 
-static __read_mostly int xen_events_irq = -1;
+static unsigned int xen_events_irq;
 
 /* map fgmfn of domid to lpfn in the current domain */
 static int map_foreign_page(unsigned long lpfn, unsigned long fgmfn,
@@ -251,12 +251,14 @@ static int __init xen_guest_init(void)
 		return 0;
 	grant_frames = res.start;
 	xen_events_irq = irq_of_parse_and_map(node, 0);
+	if (!xen_events_irq) {
+		pr_debug("Xen event channel interrupt not found\n");
+		return -ENODEV;
+	}
+
 	pr_info("Xen %s support found, events_irq=%d gnttab_frame=%pa\n",
 			version, xen_events_irq, &grant_frames);
 
-	if (xen_events_irq < 0)
-		return -ENODEV;
-
 	xen_domain_type = XEN_HVM_DOMAIN;
 
 	xen_setup_features();
-- 
2.1.0
