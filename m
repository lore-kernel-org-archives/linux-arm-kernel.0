From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon,  3 Mar 2014 17:33:15 +0000
Subject: [PATCH v4 5/6] pci: Use parent domain number when allocating child
 busses.
In-Reply-To: <1393867996-32299-1-git-send-email-Liviu.Dudau@arm.com>
References: <1393867996-32299-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1393867996-32299-6-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_alloc_child_bus() uses the newly allocated child bus to figure
out the domain number that is going to use for setting the device
name. A better option is to use the parent bus domain number.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 26237a0..a12cda5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -677,7 +677,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	 * now as the parent is not properly set up yet.
 	 */
 	child->dev.class = &pcibus_class;
-	dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(child), busnr);
+	dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(parent), busnr);
 
 	/*
 	 * Set up the primary, secondary and subordinate
-- 
1.9.0
