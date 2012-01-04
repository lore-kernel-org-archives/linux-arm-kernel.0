From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 4 Jan 2012 12:46:21 +0800
Subject: linux-next: manual merge of the net-next tree with the arm-soc
 tree
In-Reply-To: <20120104150658.aafd5ae8ebce944e897f1079@canb.auug.org.au>
References: <20120104150658.aafd5ae8ebce944e897f1079@canb.auug.org.au>
Message-ID: <20120104044620.GL2414@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 03:06:58PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in
> drivers/net/ethernet/freescale/fec.c between commit 0ebafefcaa7a ("net:
> fec: add clk_prepare/clk_unprepare") from the arm-soc tree and commit
> e163cc97f9ac ("net/fec: fix the .remove code") from the net-next tree.
> 
> Just context changes.  I fixed it up (see below) and can carry the fix as
> necessary.
It's good. 

Thanks
Richard
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc drivers/net/ethernet/freescale/fec.c
> index 112af9b,b0b0445..0000000
> --- a/drivers/net/ethernet/freescale/fec.c
> +++ b/drivers/net/ethernet/freescale/fec.c
> @@@ -1638,13 -1657,18 +1657,18 @@@ fec_drv_remove(struct platform_device *
>   	struct net_device *ndev = platform_get_drvdata(pdev);
>   	struct fec_enet_private *fep = netdev_priv(ndev);
>   	struct resource *r;
> + 	int i;
>   
> - 	fec_stop(ndev);
> + 	unregister_netdev(ndev);
>   	fec_enet_mii_remove(fep);
> + 	for (i = 0; i < FEC_IRQ_NUM; i++) {
> + 		int irq = platform_get_irq(pdev, i);
> + 		if (irq > 0)
> + 			free_irq(irq, ndev);
> + 	}
>  -	clk_disable(fep->clk);
>  +	clk_disable_unprepare(fep->clk);
>   	clk_put(fep->clk);
>   	iounmap(fep->hwp);
> - 	unregister_netdev(ndev);
>   	free_netdev(ndev);
>   
>   	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
