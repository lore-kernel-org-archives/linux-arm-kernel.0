From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  3 Sep 2015 13:16:14 +0100
Subject: [PATCH v3 2/4] PCI: pci-host-generic: Fix lookup of linux,
 pci-probe-only property
In-Reply-To: <1441282576-7304-1-git-send-email-marc.zyngier@arm.com>
References: <1441282576-7304-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1441282576-7304-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When pci-host-generic looks for the probe-only property, it seems
to trust the DT to be correctly written, and assumes that there
is a parameter to the property.

Unfortunately, this is not always the case, and some firmware expose
this property naked. The driver ends up making a decision based on
whatever the property pointer points to, which is likely to be junk.

Switch to the common of_pci.c implementation that doesn't suffer
from this problem.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/host/pci-host-generic.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 265dd25..545ff4e 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -210,7 +210,6 @@ static int gen_pci_probe(struct platform_device *pdev)
 	int err;
 	const char *type;
 	const struct of_device_id *of_id;
-	const int *prop;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
@@ -225,13 +224,7 @@ static int gen_pci_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	prop = of_get_property(of_chosen, "linux,pci-probe-only", NULL);
-	if (prop) {
-		if (*prop)
-			pci_add_flags(PCI_PROBE_ONLY);
-		else
-			pci_clear_flags(PCI_PROBE_ONLY);
-	}
+	of_pci_check_probe_only(of_chosen);
 
 	of_id = of_match_node(gen_pci_of_match, np);
 	pci->cfg.ops = of_id->data;
-- 
2.1.4
