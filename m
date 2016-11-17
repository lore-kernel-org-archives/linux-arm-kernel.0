From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 17 Nov 2016 10:00:27 -0800
Subject: [PATCH fpga 5/9] fpga zynq: Remove priv->dev
In-Reply-To: <alpine.DEB.2.10.1611140913280.3739@atull-VirtualBox>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-6-git-send-email-jgunthorpe@obsidianresearch.com>
 <alpine.DEB.2.10.1611140913280.3739@atull-VirtualBox>
Message-ID: <20161117180027.GA17178@live.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Mon, Nov 14, 2016 at 09:13:49AM -0600, atull wrote:
> On Wed, 9 Nov 2016, Jason Gunthorpe wrote:
> 
> Hi Jason,
> 
>     Acked-by: Alan Tull <atull@opensource.altera.com>
> 
> Alan
> 
> > socfpga uses mgr->dev for debug prints, there should be consistency
> > here, so standardize on that. The only other use was for dma
> > which can be replaced with mgr->dev.parent.
> > 
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

For the priv->dev removal part.

Acked-by: Moritz Fischer <moritz.fischer@ettus.com>

> > ---
> >  drivers/fpga/zynq-fpga.c | 22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> > index 3ffc5fcc3072..ac2deae92dbd 100644
> > --- a/drivers/fpga/zynq-fpga.c
> > +++ b/drivers/fpga/zynq-fpga.c
> > @@ -118,7 +118,6 @@
> >  #define FPGA_RST_NONE_MASK		0x0
> >  
> >  struct zynq_fpga_priv {
> > -	struct device *dev;
> >  	int irq;
> >  	struct clk *clk;
> >  
> > @@ -188,7 +187,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
> >  	 * least the sync word and something else to do anything.
> >  	 */
> >  	if (count <= 4 || (count % 4) != 0) {
> > -		dev_err(priv->dev,
> > +		dev_err(&mgr->dev,
> >  			"Invalid bitstream size, must be multiples of 4 bytes\n");
> >  		return -EINVAL;
> >  	}
> > @@ -200,7 +199,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
> >  	/* don't globally reset PL if we're doing partial reconfig */
> >  	if (!(flags & FPGA_MGR_PARTIAL_RECONFIG)) {
> >  		if (!zynq_fpga_has_sync(buf, count)) {
> > -			dev_err(priv->dev,
> > +			dev_err(&mgr->dev,
> >  				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swaped .bin file\n");
> >  			err = -EINVAL;
> >  			goto out_err;
> > @@ -233,7 +232,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
> >  					     INIT_POLL_DELAY,
> >  					     INIT_POLL_TIMEOUT);
> >  		if (err) {
> > -			dev_err(priv->dev, "Timeout waiting for PCFG_INIT\n");
> > +			dev_err(&mgr->dev, "Timeout waiting for PCFG_INIT\n");
> >  			goto out_err;
> >  		}
> >  
> > @@ -247,7 +246,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
> >  					     INIT_POLL_DELAY,
> >  					     INIT_POLL_TIMEOUT);
> >  		if (err) {
> > -			dev_err(priv->dev, "Timeout waiting for !PCFG_INIT\n");
> > +			dev_err(&mgr->dev, "Timeout waiting for !PCFG_INIT\n");
> >  			goto out_err;
> >  		}
> >  
> > @@ -261,7 +260,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
> >  					     INIT_POLL_DELAY,
> >  					     INIT_POLL_TIMEOUT);
> >  		if (err) {
> > -			dev_err(priv->dev, "Timeout waiting for PCFG_INIT\n");
> > +			dev_err(&mgr->dev, "Timeout waiting for PCFG_INIT\n");
> >  			goto out_err;
> >  		}
> >  	}
> > @@ -278,7 +277,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
> >  	/* check that we have room in the command queue */
> >  	status = zynq_fpga_read(priv, STATUS_OFFSET);
> >  	if (status & STATUS_DMA_Q_F) {
> > -		dev_err(priv->dev, "DMA command queue full\n");
> > +		dev_err(&mgr->dev, "DMA command queue full\n");
> >  		err = -EBUSY;
> >  		goto out_err;
> >  	}
> > @@ -309,7 +308,8 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
> >  
> >  	priv = mgr->priv;
> >  
> > -	kbuf = dma_alloc_coherent(priv->dev, count, &dma_addr, GFP_KERNEL);
> > +	kbuf =
> > +	    dma_alloc_coherent(mgr->dev.parent, count, &dma_addr, GFP_KERNEL);
> >  	if (!kbuf)
> >  		return -ENOMEM;
> >  
> > @@ -356,7 +356,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
> >  	goto out_clk;
> >  
> >  out_report:
> > -	dev_err(priv->dev,
> > +	dev_err(&mgr->dev,
> >  		"%s: INT_STS:0x%x CTRL:0x%x LOCK:0x%x INT_MASK:0x%x STATUS:0x%x MCTRL:0x%x\n",
> >  		why,
> >  		intr_status,
> > @@ -368,7 +368,7 @@ out_report:
> >  out_clk:
> >  	clk_disable(priv->clk);
> >  out_free:
> > -	dma_free_coherent(priv->dev, count, kbuf, dma_addr);
> > +	dma_free_coherent(mgr->dev.parent, count, kbuf, dma_addr);
> >  	return err;
> >  }
> >  
> > @@ -445,8 +445,6 @@ static int zynq_fpga_probe(struct platform_device *pdev)
> >  	if (!priv)
> >  		return -ENOMEM;
> >  
> > -	priv->dev = dev;
> > -
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	priv->io_base = devm_ioremap_resource(dev, res);
> >  	if (IS_ERR(priv->io_base))
> > -- 
> > 2.1.4
> > 
> > 

Thanks,

Moritz
