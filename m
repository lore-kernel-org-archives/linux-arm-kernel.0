From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 16 Sep 2014 12:37:16 +0200
Subject: [PATCH 3/3] CNS3xxx: Fix PCIe read size limit.
In-Reply-To: <m3d2av3lgt.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of "Tue, 16 Sep 2014 12:31:46 +0200")
References: <m3d2av3lgt.fsf@t19.piap.pl>
Message-ID: <m3zjdz26n7.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Max_Read_Request_Size is 3 bits wide, not 2 bits.
Also fix the message.

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 4ddb974..85e2135 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -299,12 +299,15 @@ static void __init cns3xxx_pcie_hw_init(struct cns3xxx_pcie *cnspci)
 	devfn = PCI_DEVFN(0, 0);
 	pos = pci_bus_find_capability(&bus, devfn, PCI_CAP_ID_EXP);
 	pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
-	dc &= ~(0x3 << 12);	/* Clear Device Control Register [14:12] */
-	pci_bus_write_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, dc);
-	pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
-	if (!(dc & (0x3 << 12)))
-		pr_info("PCIe: Set Device Max_Read_Request_Size to 128 byte\n");
-
+	if (dc & PCI_EXP_DEVCTL_READRQ) {
+		dc &= ~PCI_EXP_DEVCTL_READRQ;
+		pci_bus_write_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, dc);
+		pci_bus_read_config_word(&bus, devfn, pos + PCI_EXP_DEVCTL, &dc);
+		if (dc & PCI_EXP_DEVCTL_READRQ)
+			pr_warn("PCIe: Unable to set device Max_Read_Request_Size\n");
+		else
+			pr_info("PCIe: Max_Read_Request_Size set to 128 bytes\n");
+	}
 	/* Disable PCIe0 Interrupt Mask INTA to INTD */
 	__raw_writel(~0x3FFF, MISC_PCIE_INT_MASK(port));
 }
