From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 4 Jan 2012 15:06:58 +1100
Subject: linux-next: manual merge of the net-next tree with the arm-soc tree
Message-ID: <20120104150658.aafd5ae8ebce944e897f1079@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the net-next tree got a conflict in
drivers/net/ethernet/freescale/fec.c between commit 0ebafefcaa7a ("net:
fec: add clk_prepare/clk_unprepare") from the arm-soc tree and commit
e163cc97f9ac ("net/fec: fix the .remove code") from the net-next tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/net/ethernet/freescale/fec.c
index 112af9b,b0b0445..0000000
--- a/drivers/net/ethernet/freescale/fec.c
+++ b/drivers/net/ethernet/freescale/fec.c
@@@ -1638,13 -1657,18 +1657,18 @@@ fec_drv_remove(struct platform_device *
  	struct net_device *ndev = platform_get_drvdata(pdev);
  	struct fec_enet_private *fep = netdev_priv(ndev);
  	struct resource *r;
+ 	int i;
  
- 	fec_stop(ndev);
+ 	unregister_netdev(ndev);
  	fec_enet_mii_remove(fep);
+ 	for (i = 0; i < FEC_IRQ_NUM; i++) {
+ 		int irq = platform_get_irq(pdev, i);
+ 		if (irq > 0)
+ 			free_irq(irq, ndev);
+ 	}
 -	clk_disable(fep->clk);
 +	clk_disable_unprepare(fep->clk);
  	clk_put(fep->clk);
  	iounmap(fep->hwp);
- 	unregister_netdev(ndev);
  	free_netdev(ndev);
  
  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120104/5e7f6e25/attachment.sig>
