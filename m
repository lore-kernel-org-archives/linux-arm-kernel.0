From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 17 May 2012 17:18:10 +1000
Subject: linux-next: manual merge of the akpm tree with the arm-soc tree
Message-ID: <20120517171810.64d248977f410292c18086cd@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Today's linux-next merge of the akpm tree got a conflict in
drivers/ata/sata_mv.c between commit eee989902aab ("ARM: Orion: SATA: Add
per channel clk/clkdev support") from the arm-soc tree and commit
"ata/sata_mv: remove conditional compilation of clk code" from the akpm
tree.

I fixed it up (see below) and can carry the fix as necessary.

[I used the arm-soc version with all the conditionals on CONFIG_HAVE_CLK
removed.]

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/ata/sata_mv.c
index 24712ad,37503b8..0000000
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@@ -551,10 -551,7 +551,8 @@@ struct mv_host_priv 
  	u32			irq_mask_offset;
  	u32			unmask_all_irqs;
  
- #if defined(CONFIG_HAVE_CLK)
  	struct clk		*clk;
 +	struct clk              **port_clks;
- #endif
  	/*
  	 * These consistent DMA memory pools give us guaranteed
  	 * alignment for hardware-accessed data structures,
@@@ -4028,9 -4025,6 +4026,7 @@@ static int mv_platform_probe(struct pla
  	struct resource *res;
  	int n_ports = 0;
  	int rc;
- #if defined(CONFIG_HAVE_CLK)
 +	int port;
- #endif
  
  	ata_print_version_once(&pdev->dev, DRV_VERSION);
  
@@@ -4058,13 -4052,6 +4054,11 @@@
  
  	if (!host || !hpriv)
  		return -ENOMEM;
- #if defined(CONFIG_HAVE_CLK)
 +	hpriv->port_clks = devm_kzalloc(&pdev->dev,
 +					sizeof(struct clk *) * n_ports,
 +					GFP_KERNEL);
 +	if (!hpriv->port_clks)
 +		return -ENOMEM;
- #endif
  	host->private_data = hpriv;
  	hpriv->n_ports = n_ports;
  	hpriv->board_idx = chip_soc;
@@@ -4074,21 -4061,11 +4068,19 @@@
  				   resource_size(res));
  	hpriv->base -= SATAHC0_REG_BASE;
  
- #if defined(CONFIG_HAVE_CLK)
  	hpriv->clk = clk_get(&pdev->dev, NULL);
  	if (IS_ERR(hpriv->clk))
 -		dev_notice(&pdev->dev, "cannot get clkdev\n");
 +		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
  	else
 -		clk_enable(hpriv->clk);
 +		clk_prepare_enable(hpriv->clk);
 +
 +	for (port = 0; port < n_ports; port++) {
 +		char port_number[16];
 +		sprintf(port_number, "%d", port);
 +		hpriv->port_clks[port] = clk_get(&pdev->dev, port_number);
 +		if (!IS_ERR(hpriv->port_clks[port]))
 +			clk_prepare_enable(hpriv->port_clks[port]);
 +	}
- #endif
  
  	/*
  	 * (Re-)program MBUS remapping windows if we are asked to.
@@@ -4115,18 -4092,10 +4107,16 @@@
  		return 0;
  
  err:
- #if defined(CONFIG_HAVE_CLK)
  	if (!IS_ERR(hpriv->clk)) {
 -		clk_disable(hpriv->clk);
 +		clk_disable_unprepare(hpriv->clk);
  		clk_put(hpriv->clk);
  	}
 +	for (port = 0; port < n_ports; port++) {
 +		if (!IS_ERR(hpriv->port_clks[port])) {
 +			clk_disable_unprepare(hpriv->port_clks[port]);
 +			clk_put(hpriv->port_clks[port]);
 +		}
 +	}
- #endif
  
  	return rc;
  }
@@@ -4142,24 -4111,13 +4132,20 @@@
  static int __devexit mv_platform_remove(struct platform_device *pdev)
  {
  	struct ata_host *host = platform_get_drvdata(pdev);
- #if defined(CONFIG_HAVE_CLK)
  	struct mv_host_priv *hpriv = host->private_data;
 +	int port;
- #endif
  	ata_host_detach(host);
  
- #if defined(CONFIG_HAVE_CLK)
  	if (!IS_ERR(hpriv->clk)) {
 -		clk_disable(hpriv->clk);
 +		clk_disable_unprepare(hpriv->clk);
  		clk_put(hpriv->clk);
  	}
 +	for (port = 0; port < host->n_ports; port++) {
 +		if (!IS_ERR(hpriv->port_clks[port])) {
 +			clk_disable_unprepare(hpriv->port_clks[port]);
 +			clk_put(hpriv->port_clks[port]);
 +		}
 +	}
- #endif
  	return 0;
  }
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120517/a1b6f284/attachment.sig>
