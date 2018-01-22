From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 22 Jan 2018 12:28:00 -0500
Subject: [PATCH] PCI/ASPM: Suppress common clock mode setting failure
Message-ID: <1516642093-15633-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code is emitting warnings when it tries to set the common clock mode for
ASPM and ASPM is already configured to common clock mode by the UEFI BIOS.
Let's bail out silently in such a case.

pci 0004:00:00.0: ASPM: Could not configure common clock

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 9783e10..072178a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -253,6 +253,11 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 
 	/* Configure upstream component */
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
+
+	/* Port might be already in common clock mode */
+	if ((same_clock) && (reg16 & PCI_EXP_LNKCTL_CCC))
+		return;
+
 	parent_reg = reg16;
 	if (same_clock)
 		reg16 |= PCI_EXP_LNKCTL_CCC;
-- 
1.9.1
