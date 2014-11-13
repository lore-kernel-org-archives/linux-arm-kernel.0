From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 13 Nov 2014 11:24:16 +0100
Subject: [PATCH] ahci_sunxi: Drop AHCI_HFLAG_NO_PMP flag
Message-ID: <1415874256-6580-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is something which we inherited from the Allwinner android kernel sources,
and I've always wanted to test if this is really necessary.

So recently I've bought a sata port multiplexer, and I've given this a test
spin on both A10 and A20 devices, and it seems to work fine:

[    2.154456] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.161092] ata1.15: Port Multiplier 1.2, 0x197b:0x0325 r0, 5 ports, feat 0x5/0xf
[    2.175511] ata1.00: hard resetting link
[    2.524929] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    2.531430] ata1.01: hard resetting link
[    2.974465] ata1.01: link resume succeeded after 1 retries
[    3.094932] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.101431] ata1.02: hard resetting link
[    4.174466] ata1.02: failed to resume link (SControl 0)
[    4.180065] ata1.02: SATA link down (SStatus 0 SControl 0)
(and the same for links 3 and 4)

Once the NO_PMP flag is removed it correctly sees the 2 disks which I've
attached, and I can mount and use them just fine, so lets drop the flag.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci_sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index e44d675..3dd0224 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -184,7 +184,7 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 		goto disable_resources;
 
 	hpriv->flags = AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
-		       AHCI_HFLAG_NO_PMP | AHCI_HFLAG_YES_NCQ;
+		       AHCI_HFLAG_YES_NCQ;
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_sunxi_port_info);
 	if (rc)
-- 
2.1.0
