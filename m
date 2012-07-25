From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 25 Jul 2012 12:02:38 -0600
Subject: [PATCH] ARM: tegra: fix PCIe resource calculation
Message-ID: <1343239358-3239-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Commit 0acc43c "ARM: tegra: use fixed PCI i/o mapping" re-numbered the
resource array entries that the driver used, but missed one location. This
causes request_resource() to fail, and the driver to panic.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Rob, I'm not sure if you can squash this into your PCIE commit, or if
we need to apply it on top?

 arch/arm/mach-tegra/pcie.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 576347a..3463fb5 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -406,7 +406,7 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	pp->res[1].name = pp->prefetch_space_name;
 	if (pp->index == 0) {
 		pp->res[1].start = PREFETCH_MEM_BASE_0;
-		pp->res[1].end = pp->res[2].start + PREFETCH_MEM_SIZE_0 - 1;
+		pp->res[1].end = pp->res[1].start + PREFETCH_MEM_SIZE_0 - 1;
 	} else {
 		pp->res[1].start = PREFETCH_MEM_BASE_1;
 		pp->res[1].end = pp->res[1].start + PREFETCH_MEM_SIZE_1 - 1;
-- 
1.7.0.4
