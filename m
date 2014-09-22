From: rric@kernel.org (Robert Richter)
Date: Mon, 22 Sep 2014 11:32:28 +0200
Subject: [PATCH v11 08/10] OF: PCI: Add support for parsing PCI host
 bridge resources from DT
In-Reply-To: <1411003825-21521-9-git-send-email-Liviu.Dudau@arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-9-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20140922093228.GA20256@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.09.14 02:30:23, Liviu Dudau wrote:
> +int of_pci_get_host_bridge_resources(struct device_node *dev,
> +			unsigned char busno, unsigned char bus_max,
> +			struct list_head *resources, resource_size_t *io_base)
> +{
> +	struct resource *res;
> +	struct resource *bus_range;
> +	struct of_pci_range range;
> +	struct of_pci_range_parser parser;
> +	char range_type[4];
> +	int err;
> +
> +	if (!io_base)
> +		return -EINVAL;
> +	*io_base = OF_BAD_ADDR;

This breaks for mem-mapped pci host controllers. The patch below fixes
this.

This series was tested with the fix on top for Cavium Thunder.

Tested-by: Robert Richter <rrichter@cavium.com>

-Robert



>From e798af4fc2f664d1aff7e863489b8298f90e716e Mon Sep 17 00:00:00 2001
From: Robert Richter <rrichter@cavium.com>
Date: Mon, 22 Sep 2014 10:46:01 +0200
Subject: [PATCH] OF: PCI: Fix creation of mem-mapped pci host bridges

The pci host bridge was not created if io_base was not set when
calling of_pci_get_host_bridge_resources(). This is esp. the case for
mem-mapped io (IORESOURCE_MEM). This patch fixes this. Function
parameter io_base is optional now.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/of/of_pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index ffdb45ed8682..1f0e7c2505ee 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -182,9 +182,8 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 	char range_type[4];
 	int err;
 
-	if (!io_base)
-		return -EINVAL;
-	*io_base = OF_BAD_ADDR;
+	if (io_base)
+		*io_base = OF_BAD_ADDR;
 
 	bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
 	if (!bus_range)
@@ -242,7 +241,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 			goto parse_failed;
 		}
 
-		if (resource_type(res) == IORESOURCE_IO) {
+		if (io_base && resource_type(res) == IORESOURCE_IO) {
 			if (*io_base != OF_BAD_ADDR)
 				pr_warn("More than one I/O resource converted. CPU offset for old range lost!\n");
 			*io_base = range.cpu_addr;
-- 
2.1.0
