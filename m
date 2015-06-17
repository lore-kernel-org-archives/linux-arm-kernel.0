From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Wed, 17 Jun 2015 15:30:02 +0200
Subject: [PATCH v2] ahci, msix: Fix build error for !PCI_MSI
In-Reply-To: <5581379C.3090607@linux.intel.com>
References: <1433526566-21136-1-git-send-email-rric@kernel.org>
 <20150616132434.GO10428@rric.localhost>
 <20150616201341.GD22637@mtj.duckdns.org>
 <20150617084852.GL4914@rric.localhost>
 <5581379C.3090607@linux.intel.com>
Message-ID: <20150617133002.GW10428@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tejun, Gerry,

On 17.06.15 17:02:20, Jiang Liu wrote:
> On 2015/6/17 16:48, Robert Richter wrote:

> >  static struct msi_desc *msix_get_desc(struct pci_dev *dev, u16 entry)
> >  {
> > +#ifdef CONFIG_PCI_MSI
> >  	struct msi_desc *desc;
> >  
> >  	list_for_each_entry(desc, &dev->msi_list, list) {
> >  		if (desc->msi_attrib.entry_nr == entry)
> >  			return desc;
> >  	}
> > -
> > +#endif

> Hi Robert,
> 	While at it, could you please help to use  for_each_pci_msi_entry()
> from include/linux/msi.h instead of hard-coding? We are trying to refine
> the msi_list related code,
> so we don't need to touch this code again later.

While looking into this I realized the code can be much more
simplified so that the desc lookup function can be removed at all.
See below.

Sorry for the patch noise.

-Robert


>From e43b79f0afd794d3e37ec0922c75e44b1c3f2e22 Mon Sep 17 00:00:00 2001
From: Robert Richter <rrichter@cavium.com>
Date: Wed, 17 Jun 2015 10:33:22 +0200
Subject: [PATCH v2] ahci, msix: Fix build error for !PCI_MSI
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It turned out the irq vector of the msix can be obtained from struct
msix_entry. This makes the lookup function for msi_desc obsolete.

This fixes a build error if PCI_MSI is unset:

 drivers/ata/ahci.c: In function ?msix_get_desc?:
 drivers/ata/ahci.c:1210:2: error: ?struct pci_dev? has no member named ?msi_list?

Catched by Fengguang's build bot.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/ata/ahci.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index bdedaa4f9d7b..c478a40e32c6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1203,18 +1203,6 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
 {}
 #endif
 
-static struct msi_desc *msix_get_desc(struct pci_dev *dev, u16 entry)
-{
-	struct msi_desc *desc;
-
-	list_for_each_entry(desc, &dev->msi_list, list) {
-		if (desc->msi_attrib.entry_nr == entry)
-			return desc;
-	}
-
-	return NULL;
-}
-
 /*
  * ahci_init_msix() only implements single MSI-X support, not multiple
  * MSI-X per-port interrupts. This is needed for host controllers that only
@@ -1223,7 +1211,6 @@ static struct msi_desc *msix_get_desc(struct pci_dev *dev, u16 entry)
 static int ahci_init_msix(struct pci_dev *pdev, unsigned int n_ports,
 			  struct ahci_host_priv *hpriv)
 {
-	struct msi_desc *desc;
 	int rc, nvec;
 	struct msix_entry entry = {};
 
@@ -1248,13 +1235,7 @@ static int ahci_init_msix(struct pci_dev *pdev, unsigned int n_ports,
 	if (rc < 0)
 		goto fail;
 
-	desc = msix_get_desc(pdev, 0);	/* first entry */
-	if (!desc) {
-		rc = -EINVAL;
-		goto fail;
-	}
-
-	hpriv->irq = desc->irq;
+	hpriv->irq = entry.vector;
 
 	return 1;
 fail:
-- 
2.1.1
