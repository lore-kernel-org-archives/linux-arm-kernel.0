From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 17 Aug 2017 10:14:22 +0200
Subject: [PATCH v2 2/3] PCI: Avoid bus reset for Cavium cn8xxx root ports
In-Reply-To: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
References: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
Message-ID: <1502957663-5527-3-git-send-email-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

Root ports of cn8xxx do not function after bus reset when used with
some e1000e and LSI HBA devices. Add a quirk to prevent bus reset on
these root ports.

Signed-off-by: David Daney <david.daney@cavium.com>
[jglauber at cavium.com: fixed typo and whitespaces]
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/pci/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6967c6b..85191b8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3364,6 +3364,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
 
+/*
+ * Root port on some Cavium CN8xxx chips do not successfully complete
+ * a bus reset when used with certain types of child devices. Config
+ * space access to the child may quit responding. Flag the root port
+ * as not supporting bus reset.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
+
 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
 	/*
-- 
2.9.0.rc0.21.g7777322
