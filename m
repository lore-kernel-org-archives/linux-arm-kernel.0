From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  6 Nov 2012 22:55:32 +0100
Subject: [PATCH 7/8] ata: highbank: mark ahci_highbank_probe as __devinit
In-Reply-To: <1352238933-4886-1-git-send-email-arnd@arndb.de>
References: <1352238933-4886-1-git-send-email-arnd@arndb.de>
Message-ID: <1352238933-4886-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ahci_highbank_probe function is incorrectly marked as __init,
which means it can get discarded at boot time, which might be
a problem if for some reason the device only becomes operational
after loading another module.

Using __devinit instead avoids seeing this warning for every build:

WARNING: vmlinux.o(.data+0xf7b0): Section mismatch in reference from the
variable ahci_highbank_driver to the function .init.text:ahci_highbank_probe()
The variable ahci_highbank_driver references
the function __init ahci_highbank_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Jeff Garzik <jgarzik@redhat.com>
---
 drivers/ata/sata_highbank.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 0d7c4c2..36a141a 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -260,7 +260,7 @@ static const struct of_device_id ahci_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
 
-static int __init ahci_highbank_probe(struct platform_device *pdev)
+static int __devinit ahci_highbank_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
-- 
1.7.10
