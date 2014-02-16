From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 16 Feb 2014 11:45:20 -0300
Subject: [REGRESSION] 3.14-rc2 boot failure on Kirkwood (qnap ts-119p+)
In-Reply-To: <21248.39509.418884.931848@gargle.gargle.HOWL>
References: <21248.39509.418884.931848@gargle.gargle.HOWL>
Message-ID: <20140216143735.GA8680@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mikael,

On Sun, Feb 16, 2014 at 12:00:37PM +0100, Mikael Pettersson wrote:
> My Kirkwood box worked fine with the 3.13 kernel, but with 3.14-rc2
> boot always fails due to a kernel NULL dereference in __clk_put.
> 
> This is a non-DT kernel, with:
> 
> CONFIG_ARCH_KIRKWOOD=y
> CONFIG_KIRKWOOD_LEGACY=y
> CONFIG_MACH_TS219=y
> # CONFIG_ARCH_KIRKWOOD_DT is not set
> 

Thanks for the report. I thought this issue was already fixed, but I
cannot find it on either the mailing lists or linux-next.

So, in case it hasn't been fixed here's an untested fix for you to test.
Please try this patch and let us know.

Your SATA won't work but if the patch is OK the kernel wont't blow away.

Andrew? Do we support the new phy requirement in non-DT platforms?

>From 5d4010ba3c485e7e22887408663fb260f628b9b2 Mon Sep 17 00:00:00 2001
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date: Sun, 16 Feb 2014 11:21:50 -0300
Subject: [PATCH] ata: sata_mv: Cleanup only the initialized ports

When an error occurs in the port initialization loop, currently the
driver tries to cleanup all the ports. This results in a NULL pointer
dereference if the ports were only partially initialized.

Fix this by updating only the number of initialized ports (either
with failure or successfully), before jumping to the error path
and looping over that number in the cleanup loop.

Cc: Andrew Lunn <andrew@lunn.ch>
Reported-by: Mikael Pettersson <mikpelinux@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/ata/sata_mv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 20a7517..9c1a11d 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4104,7 +4104,6 @@ static int mv_platform_probe(struct platform_device *pdev)
 	if (!hpriv->port_phys)
 		return -ENOMEM;
 	host->private_data = hpriv;
-	hpriv->n_ports = n_ports;
 	hpriv->board_idx = chip_soc;
 
 	host->iomap = NULL;
@@ -4132,11 +4131,17 @@ static int mv_platform_probe(struct platform_device *pdev)
 			hpriv->port_phys[port] = NULL;
 			if ((rc != -EPROBE_DEFER) && (rc != -ENODEV))
 				dev_warn(&pdev->dev, "error getting phy");
+
+			/* Cleanup only the initialized ports */
+			hpriv->n_ports = port;
 			goto err;
 		} else
 			phy_power_on(hpriv->port_phys[port]);
 	}
 
+	/* All the ports have been initialized */
+	hpriv->n_ports = n_ports;
+
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
 	 */
@@ -4174,7 +4179,7 @@ err:
 		clk_disable_unprepare(hpriv->clk);
 		clk_put(hpriv->clk);
 	}
-	for (port = 0; port < n_ports; port++) {
+	for (port = 0; port < hpriv->n_ports; port++) {
 		if (!IS_ERR(hpriv->port_clks[port])) {
 			clk_disable_unprepare(hpriv->port_clks[port]);
 			clk_put(hpriv->port_clks[port]);
-- 
1.8.1.5


-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
