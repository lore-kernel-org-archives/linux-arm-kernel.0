From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Jan 2014 18:44:27 +0000
Subject: imx6 eSATA
Message-ID: <20140118184427.GJ15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, I see we have AHCI support for SATA on the iMX6.  Great... but it
doesn't work on the cubox-i, because the phy settings are wrong.

The Cubox-i requires GPR13 set to 0x0593A044 - I haven't decoded what
this means yet, but it's different from the 0x0593E4A4 which is
currently hard-coded into the driver (and I've independently tested
that this is indeed required.)

So, there's presently no DT properties for this - given that these
parameters would be board specific, it surprises me that this has not
been thought about, and properties already generated, because now it
means that we need to _add_ new properties to this driver.

Also, this PDDQ mode thing, which can't be recovered except by reset.
This is another illustration why Linux is unfriendly - the thing can
silently go into this power down mode which is irrecoverable without
any messages being generated nor any hints how to avoid it - maybe
this should also be a DT property, not just a command line option.

More importantly, maybe we should print a message when we discover
that there's nothing connected and we're going to enter this mode -
maybe something like this:

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 3e23e9941dad..0a1ae7213992 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -77,6 +77,10 @@ static void ahci_imx_error_handler(struct ata_port *ap)
 			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
 	clk_disable_unprepare(imxpriv->sata_ref_clk);
 	imxpriv->no_device = true;
+
+	dev_info(ap->dev, "no device, link disabled until next reset.\n");
+	dev_info(ap->dev, "pass " MODULE_PARAM_PREFIX
+		 ".hotplug=1 to enable link hotplug support\n");
 }
 
 static struct ata_port_operations ahci_imx_ops = {


-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
