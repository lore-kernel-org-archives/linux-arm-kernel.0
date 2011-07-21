From: balbi@ti.com (Felipe Balbi)
Date: Thu, 21 Jul 2011 20:43:07 +0300
Subject: [PATCH] OMAP: omap_device: replace pr_* prints with dev_*
In-Reply-To: <1311269976-4035-1-git-send-email-khilman@ti.com>
References: <1311269976-4035-1-git-send-email-khilman@ti.com>
Message-ID: <20110721174306.GD32058@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 10:39:36AM -0700, Kevin Hilman wrote:
> For consistency in kernel printk output for devices, use dev_dbg(),
> dev_warn(), dev_err() instead of pr_debug(), pr_warning() and
> pr_err(), some of which currently use direct access of name from
> platform_device and others of which use dev_name().  Using the dev_*
> versions uses the standard device naming from the driver core.
> 
> Some pr_* prints were not converted with this patch since they are
> used before the platform_device and struct device are created so
> neither the dev_* prints or dev_name() is valid.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

BTW, I tried applying this to today's linus/master, but it fails
(rejects below), are you depending on some other changes ?

--- arch/arm/plat-omap/omap_device.c
+++ arch/arm/plat-omap/omap_device.c
@@ -242,28 +239,27 @@
 	if (!clk_alias || !clk_name)
 		return;
 
-	pr_debug("omap_device: %s: Creating %s -> %s\n",
-		 dev_name(&od->pdev.dev), clk_alias, clk_name);
+	dev_dbg(&od->pdev.dev, "Creating %s -> %s\n", clk_alias, clk_name);
 
 	r = clk_get_sys(dev_name(&od->pdev.dev), clk_alias);
 	if (!IS_ERR(r)) {
-		pr_warning("omap_device: %s: alias %s already exists\n",
-			   dev_name(&od->pdev.dev), clk_alias);
+		dev_warn(&od->pdev.dev,
+			 "alias %s already exists\n", clk_alias);
 		clk_put(r);
 		return;
 	}
 
 	r = omap_clk_get_by_name(clk_name);
 	if (IS_ERR(r)) {
-		pr_err("omap_device: %s: omap_clk_get_by_name for %s failed\n",
-		       dev_name(&od->pdev.dev), clk_name);
+		dev_err(&od->pdev.dev,
+			"omap_clk_get_by_name for %s failed\n", clk_name);
 		return;
 	}
 
 	l = clkdev_alloc(r, clk_alias, dev_name(&od->pdev.dev));
 	if (!l) {
-		pr_err("omap_device: %s: clkdev_alloc for %s failed\n",
-		       dev_name(&od->pdev.dev), clk_alias);
+		dev_err(&od->pdev.dev,
+			"clkdev_alloc for %s failed\n", clk_alias);
 		return;
 	}
 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110721/ac50781d/attachment-0001.sig>
