From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Oct 2017 12:28:33 +0100
Subject: linux-next: manual merge of the arm64 tree with Linus' tree
Message-ID: <20171019112833.2h5ah7tidjnkvo7o@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Today's linux-next merge of the arm64 tree got a conflict in:

  drivers/acpi/arm64/iort.c

between commit:

  37f6b42e9c296 ("ACPI/IORT: Fix PCI ACS enablement")

from Linus' tree and commit:

  896dd2c324842 ("ACPI/IORT: Make platform devices initialization code SMMU agnostic")

from the arm64 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/acpi/arm64/iort.c
index de56394dd161,7dc964f4d8f1..000000000000
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@@ -1215,7 -1326,7 +1357,8 @@@ static void __init iort_init_platform_d
  	struct acpi_table_iort *iort;
  	struct fwnode_handle *fwnode;
  	int i, ret;
 +	bool acs_enabled = false;
+ 	const struct iort_dev_config *ops;
  
  	/*
  	 * iort_table and iort both point to the start of IORT table, but
@@@ -1235,12 -1346,8 +1378,11 @@@
  			return;
  		}
  
 +		if (!acs_enabled)
 +			acs_enabled = iort_enable_acs(iort_node);
 +
- 		if ((iort_node->type == ACPI_IORT_NODE_SMMU) ||
- 			(iort_node->type == ACPI_IORT_NODE_SMMU_V3)) {
- 
+ 		ops = iort_get_dev_cfg(iort_node);
+ 		if (ops) {
  			fwnode = acpi_alloc_fwnode_static();
  			if (!fwnode)
  				return;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171019/31989025/attachment.sig>
