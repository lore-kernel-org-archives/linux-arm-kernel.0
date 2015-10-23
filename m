From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 23 Oct 2015 05:19:22 +0000
Subject: [PATCH v6] can: xilinx: Convert to runtime_pm
In-Reply-To: <20151022221320.GQ5257@xsjsorenbubuntu>
References: <1445489120-10933-1-git-send-email-appanad@xilinx.com>
 <20151022221320.GQ5257@xsjsorenbubuntu>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A4F357F@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

> -----Original Message-----
> From: S?ren Brinkmann [mailto:soren.brinkmann at xilinx.com]
> Sent: Friday, October 23, 2015 3:43 AM
> To: Appana Durga Kedareswara Rao
> Cc: Anirudha Sarangi; wg at grandegger.com; mkl at pengutronix.de; Michal
> Simek; linux-can at vger.kernel.org; netdev at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Appana Durga
> Kedareswara Rao
> Subject: Re: [PATCH v6] can: xilinx: Convert to runtime_pm
> 
> Hi Kedar,
> 
> On Thu, 2015-10-22 at 10:15AM +0530, Kedareswara rao Appana wrote:
> > Instead of enabling/disabling clocks at several locations in the
> > driver, Use the runtime_pm framework. This consolidates the actions
> > for runtime PM In the appropriate callbacks and makes the driver more
> readable and mantainable.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> [...]
> >  /**
> >   * xcan_probe - Platform registration call @@ -1072,7 +1103,7 @@
> > static int xcan_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >
> >  	priv = netdev_priv(ndev);
> > -	priv->dev = ndev;
> > +	priv->dev = &pdev->dev;
> >  	priv->can.bittiming_const = &xcan_bittiming_const;
> >  	priv->can.do_set_mode = xcan_do_set_mode;
> >  	priv->can.do_get_berr_counter = xcan_get_berr_counter; @@ -
> 1114,21
> > +1145,30 @@ static int xcan_probe(struct platform_device *pdev)
> >  		}
> >  	}
> >
> > -	ret = clk_prepare_enable(priv->can_clk);
> > +	ret = clk_prepare(priv->can_clk);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "unable to enable device clock\n");
> >  		goto err_free;
> >  	}
> >
> > -	ret = clk_prepare_enable(priv->bus_clk);
> > +	ret = clk_prepare(priv->bus_clk);
> 
> Are these clk_prepare calls needed here? The runtime PM calls do
> clk_prepare_enable and clk_disable_unprepare.

Ok Sure will remove.

> 
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "unable to enable bus clock\n");
> > -		goto err_unprepare_disable_dev;
> > +		goto err_unprepare_dev;
> >  	}
> >
> >  	priv->write_reg = xcan_write_reg_le;
> >  	priv->read_reg = xcan_read_reg_le;
> >
> > +	pm_runtime_irq_safe(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +	ret = pm_runtime_get_sync(&pdev->dev);
> > +	if (ret < 0) {
> > +		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
> > +			__func__, ret);
> > +		goto err_unprepare_busclk;
> > +	}
> > +
> >  	if (priv->read_reg(priv, XCAN_SR_OFFSET) != XCAN_SR_CONFIG_MASK) {
> >  		priv->write_reg = xcan_write_reg_be;
> >  		priv->read_reg = xcan_read_reg_be;
> > @@ -1141,22 +1181,26 @@ static int xcan_probe(struct platform_device
> *pdev)
> >  	ret = register_candev(ndev);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "fail to register failed (err=%d)\n", ret);
> > -		goto err_unprepare_disable_busclk;
> > +		goto err_disableclks;
> >  	}
> >
> >  	devm_can_led_init(ndev);
> > -	clk_disable_unprepare(priv->bus_clk);
> > -	clk_disable_unprepare(priv->can_clk);
> > +
> > +	pm_runtime_put(&pdev->dev);
> > +
> >  	netdev_dbg(ndev, "reg_base=0x%p irq=%d clock=%d, tx fifo
> depth:%d\n",
> >  			priv->reg_base, ndev->irq, priv->can.clock.freq,
> >  			priv->tx_max);
> >
> >  	return 0;
> >
> > -err_unprepare_disable_busclk:
> > -	clk_disable_unprepare(priv->bus_clk);
> > -err_unprepare_disable_dev:
> > -	clk_disable_unprepare(priv->can_clk);
> > +err_disableclks:
> > +	pm_runtime_put(priv->dev);
> > +err_unprepare_busclk:
> > +	pm_runtime_disable(&pdev->dev);
> > +	clk_unprepare(priv->bus_clk);
> > +err_unprepare_dev:
> > +	clk_unprepare(priv->can_clk);
> >  err_free:
> >  	free_candev(ndev);
> >  err:
> > @@ -1175,11 +1219,11 @@ static int xcan_remove(struct platform_device
> *pdev)
> >  	struct net_device *ndev = platform_get_drvdata(pdev);
> >  	struct xcan_priv *priv = netdev_priv(ndev);
> >
> > -	if (set_reset_mode(ndev) < 0)
> > -		netdev_err(ndev, "mode resetting failed!\n");
> > -
> >  	unregister_candev(ndev);
> > +	pm_runtime_disable(&pdev->dev);
> >  	netif_napi_del(&priv->napi);
> > +	clk_unprepare(priv->bus_clk);
> > +	clk_unprepare(priv->can_clk);
> 
> I think this can go away when the prepare calls in probe go away.

Ok will fix and will send next version of the patch.

Regards,
Kedar.

> 
> 	Thanks,
> 	S?ren
