From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Sat, 7 Nov 2009 14:56:15 +0100
Subject: [PATCH,
	RFC] PCI: deal with device incorrectly reporting I/O decoding being
	enabled
Message-ID: <20091107135615.GE18639@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least the Lava Quattro quad-port 16550A card can incorrectly report
I/O decoding being enabled while it is in fact not, which means that
the check in pcibios_enable_device() to see whether the new command
word that we're intending to write into the device is different from
the old current can trigger inadvertently, resulting in the write to
enable I/O decoding never being done, and I/O decoding never being
enabled.

Work around this by doing the write unconditionally (while still
only doing the printk if the new word is different from the old one,
to avoid dmesg spam).

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
--
This is probably at least slightly controversial.  Any thoughts?

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 8096819..cf170b9 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -662,11 +662,17 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
 		cmd |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
 
-	if (cmd != old_cmd) {
+	/*
+	 * Some devices (e.g. the Lava Quattro quad-port 16550A card)
+	 * can incorrectly report I/O decoding being enabled while it
+	 * is in fact not, so unconditionally perform the config space
+	 * write.
+	 */
+	if (cmd != old_cmd)
 		printk("PCI: enabling device %s (%04x -> %04x)\n",
 		       pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
+
 	return 0;
 }
 
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 706f82d..96fe13d 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -322,10 +322,16 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 			cmd |= PCI_COMMAND_MEMORY;
 	}
 
-	if (cmd != old_cmd) {
+	/*
+	 * Some devices (e.g. the Lava Quattro quad-port 16550A card)
+	 * can incorrectly report I/O decoding being enabled while it
+	 * is in fact not, so unconditionally perform the config space
+	 * write.
+	 */
+	if (cmd != old_cmd)
 		dev_info(&dev->dev, "enabling device (%04x -> %04x)\n",
 			 old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
+
 	return 0;
 }

--
