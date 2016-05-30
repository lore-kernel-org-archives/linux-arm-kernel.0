From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon, 30 May 2016 17:14:15 +0200
Subject: [PATCH V8 2/9] PCI: ecam: Add parent device field to pci_config_window
In-Reply-To: <1464621262-26770-1-git-send-email-tn@semihalf.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
Message-ID: <1464621262-26770-3-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jayachandran C <jchandra@broadcom.com>

Add a parent device field to struct pci_config_window. The parent
is not saved now, but will be useful to save it in some cases.
Specifically in case of ACPI for ARM64, it can be used to setup
ACPI companion and domain.

Since the parent dev is in struct pci_config_window now, we need
not pass it to he init function as a separate argument.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/pci/ecam.c                 | 3 ++-
 drivers/pci/host/pci-thunder-pem.c | 3 ++-
 include/linux/pci-ecam.h           | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 820e26b..66e0d71 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -51,6 +51,7 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 	if (!cfg)
 		return ERR_PTR(-ENOMEM);
 
+	cfg->parent = dev;
 	cfg->ops = ops;
 	cfg->busr.start = busr->start;
 	cfg->busr.end = busr->end;
@@ -94,7 +95,7 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 	}
 
 	if (ops->init) {
-		err = ops->init(dev, cfg);
+		err = ops->init(cfg);
 		if (err)
 			goto err_exit;
 	}
diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index 5020d3d..91f6fc6 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -284,8 +284,9 @@ static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
 	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
-static int thunder_pem_init(struct device *dev, struct pci_config_window *cfg)
+static int thunder_pem_init(struct pci_config_window *cfg)
 {
+	struct device *dev = cfg->parent;
 	resource_size_t bar4_start;
 	struct resource *res_pem;
 	struct thunder_pem_pci *pem_pci;
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 9878beb..7adad20 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -27,8 +27,7 @@ struct pci_config_window;
 struct pci_ecam_ops {
 	unsigned int			bus_shift;
 	struct pci_ops			pci_ops;
-	int				(*init)(struct device *,
-						struct pci_config_window *);
+	int				(*init)(struct pci_config_window *);
 };
 
 /*
@@ -45,6 +44,7 @@ struct pci_config_window {
 		void __iomem		*win;	/* 64-bit single mapping */
 		void __iomem		**winp; /* 32-bit per-bus mapping */
 	};
+	struct device			*parent;/* ECAM res was from this dev */
 };
 
 /* create and free pci_config_window */
-- 
1.9.1
