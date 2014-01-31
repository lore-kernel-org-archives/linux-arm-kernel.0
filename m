From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jan 2014 23:49:18 +0100
Subject: [PATCH 3/3] spi: switch to devm_spi_alloc_master
In-Reply-To: <52EBCCCD.301@wwwdotorg.org>
References: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391163792-21819-4-git-send-email-maxime.ripard@free-electrons.com>
 <52EBCCCD.301@wwwdotorg.org>
Message-ID: <20140131224918.GJ2950@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 09:18:21AM -0700, Stephen Warren wrote:
> On 01/31/2014 03:23 AM, Maxime Ripard wrote:
> > Make the existing users of devm_spi_register_master use the
> > devm_spi_alloc_master function to avoid leaking memory.
> 
> > diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> 
> > @@ -1087,14 +1085,13 @@ static int tegra_spi_probe(struct platform_device *pdev)
> >  	if (ret < 0) {
> >  		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
> >  					tspi->irq);
> > -		goto exit_free_master;
> > +		return ret;
> >  	}
> >  
> >  	tspi->clk = devm_clk_get(&pdev->dev, "spi");
> >  	if (IS_ERR(tspi->clk)) {
> >  		dev_err(&pdev->dev, "can not get clock\n");
> > -		ret = PTR_ERR(tspi->clk);
> > -		goto exit_free_irq;
> > +		return PTR_ERR(tspi->clk);
> >  	}
> >  
> >  	tspi->max_buf_size = SPI_FIFO_DEPTH << 2;
> > @@ -1152,8 +1149,6 @@ exit_rx_dma_free:
> >  	tegra_spi_deinit_dma_param(tspi, true);
> >  exit_free_irq:
> >  	free_irq(spi_irq, tspi);
> > -exit_free_master:
> > -	spi_master_put(master);
> >  	return ret;
> 
> Doesn't that s/goto exit_free_irq/return/ leak spi_irq? It's only OK to
> replace goto free_master with a direct return.
> 
> The other two Tegra drivers don't seem to have this problem.

Ah, right. Thanks for noticing.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/282a6769/attachment.sig>
