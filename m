From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Mar 2017 10:49:35 +0100
Subject: [PATCH v2 07/22] PCI: ECAM: use ioremap_nopost() to map config region
In-Reply-To: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170327094954.7162-8-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current ECAM kernel implementation uses ioremap() to map the ECAM
configuration space memory region; this is not safe in that on some
architectures the ioremap interface provides mappings that allow posted
write transactions. This, as highlighted in the PCIe specifications
(4.0 - Rev0.3, "Ordering Considerations for the Enhanced Configuration
Address Mechanism"), can create ordering issues for software because
posted writes transactions on the CPU host bus are non posted in the
PCI express fabric.

Update the ioremap() interface to use ioremap_nopost() whose
mapping attributes guarantee that non-posted writes transactions
are issued for memory writes within the ECAM memory mapped address
region.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ecam.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 2fee61b..70d722a 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -84,12 +84,13 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 		if (!cfg->winp)
 			goto err_exit_malloc;
 		for (i = 0; i < bus_range; i++) {
-			cfg->winp[i] = ioremap(cfgres->start + i * bsz, bsz);
+			cfg->winp[i] = ioremap_nopost(cfgres->start + i * bsz,
+						      bsz);
 			if (!cfg->winp[i])
 				goto err_exit_iomap;
 		}
 	} else {
-		cfg->win = ioremap(cfgres->start, bus_range * bsz);
+		cfg->win = ioremap_nopost(cfgres->start, bus_range * bsz);
 		if (!cfg->win)
 			goto err_exit_iomap;
 	}
-- 
2.10.0
