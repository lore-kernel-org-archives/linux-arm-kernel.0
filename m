From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 16 Oct 2017 17:11:06 +0100
Subject: [GIT PULL v2] ACPI IORT changes for v4.15
Message-ID: <20171016161106.GA18942@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, Will,

this is a v2 of a previous PR:

v1 -> v2:
	 Rebased pull request on top of v4.14-rc3

v1: http://lkml.kernel.org/r/20171013152937.GA13386 at red-moon

Here are the ACPI IORT changes I have queued aimed at the v4.15 kernel
release.

Main changes:

- SMMUv3 MSI enablement work based on IORT issue C spec updates
  (Hanjun Guo)
- Clean-ups/rework in preparation for PMCG support (Lorenzo Pieralisi)

Patches have a compile time dependency on the ACPICA tree that we handled
through an ACPI_CA_VERSION guard; I will remove it at v4.15-rc1 when
dependencies have settled.

Reference discussion:

http://lkml.kernel.org/r/20171013130445.GA27895 at red-moon

I expect no merge conflict with the arm64 tree for-next/core branch.

The content patches will cause a minor conflict when pulled into mainline,
since mainline contains a fix:

commit 37f6b42e9c ("ACPI/IORT: Fix PCI ACS enablement"))

that was merged in v4.14-rc4 and code in this pull request does not
rebase cleanly on top of it; my commit resolution below.

Please consider pulling, thank you.

Lorenzo

-- >8 --
diff --cc drivers/acpi/arm64/iort.c
index de56394,7dc964f..0000000
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
-- >8 --

The following changes since commit 9e66317d3c92ddaab330c125dfe9d06eee268aff:

  Linux 4.14-rc3 (2017-10-01 14:54:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/acpi/iort-for-v4.15

for you to fetch changes up to 65637901a3409f8a7952750e975536bde70fa1f8:

  ACPI/IORT: Enable SMMUv3/PMCG IORT MSI domain set-up (2017-10-16 14:30:15 +0100)

----------------------------------------------------------------
ACPI IORT updates for v4.15; patches content is logically split into
the following subseries:

- Code clean-ups (A.Yadav, L.Pieralisi)
- Platform devices inizialization rework in preparation for IORT PMCG
  handling (L.Pieralisi)
- Mapping API rework to enable MSIs for IORT components as defined in
  IORT specification issue C (H.Guo, L.Pieralisi)

----------------------------------------------------------------
Arvind Yadav (1):
      acpi/arm64: pr_err() strings should end with newlines

Hanjun Guo (3):
      ACPI/IORT: Look up IORT node through struct fwnode_handle pointer
      ACPI/IORT: Enable special index ITS group mappings for IORT nodes
      ACPI/IORT: Add SMMUv3 specific special index mapping handling

Lorenzo Pieralisi (4):
      ACPI/IORT: Remove leftover ACPI_IORT_SMMU_V3_PXM_VALID guard
      ACPI/IORT: Improve functions return type/storage class specifier indentation
      ACPI/IORT: Make platform devices initialization code SMMU agnostic
      ACPI/IORT: Enable SMMUv3/PMCG IORT MSI domain set-up

 drivers/acpi/arm64/gtdt.c |   2 +-
 drivers/acpi/arm64/iort.c | 258 +++++++++++++++++++++++++++++++++++-----------
 include/linux/acpi_iort.h |   4 +-
 3 files changed, 203 insertions(+), 61 deletions(-)
