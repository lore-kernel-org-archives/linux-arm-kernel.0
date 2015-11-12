From: yao.yuan@freescale.com (Yao Yuan)
Date: Thu, 12 Nov 2015 11:21:09 +0000
Subject: [PATCH v2 1/3] dma: Add Freescale qDMA engine driver support
In-Reply-To: <20151111081408.GI25173@localhost>
References: <1445565553-1141-1-git-send-email-yao.yuan@freescale.com>
 <20151111081408.GI25173@localhost>
Message-ID: <BLUPR03MB134E5CC23BB0920FB27095383120@BLUPR03MB134.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 4:14 PM, Vinod Koul wrote:
> On Fri, Oct 23, 2015 at 09:59:11AM +0800, Yuan Yao wrote:
> 
> > +config FSL_QDMA
> > +	tristate "Freescale qDMA engine support"
> > +	depends on SOC_LS1021A || ARCH_LAYERSCAPE
> 
> Where is this ARCH defined, quick grep revealed none
> 
This is a generic  family naming for freescale a set of ARMv8 based SoCs.
The patch is merged in arm soc but not yet merge into Linux next.

> > +static void fsl_qdma_set_tcd_params(struct fsl_qdma_chan *fsl_chan,
> > +					u64 src, u64 dst, u32 nbytes)
> > +{
> > +	void __iomem *addr = fsl_chan->qdma->membase;
> > +	u32 reg;
> > +
> > +	/*
> > +	 * Source address.
> > +	 * Represents address bits 31-0 of a 49-bit source address.
> > +	 */
> > +	qdma_writel(fsl_chan->qdma, (u32)src, addr + FSL_QDMA_DLSAR);
> > +	/*
> > +	 * Source address.
> > +	 * Represents address bits 47-32 of a 49-bit source address.
> > +	 */
> > +	reg = qdma_readl(fsl_chan->qdma, addr + FSL_QDMA_DLSATR);
> > +	reg |= (u16)(src >> 32) & 0xffff;
> > +	reg |= FSL_QDMA_SRTTYPE_R_N;
> > +	qdma_writel(fsl_chan->qdma, reg, addr + FSL_QDMA_DLSATR);
> 
> How does this work on systems with enither endieness ?
[Yuan Yao] I'm sorry for confused. Is there any other endianness?
As I know in SOC_LS1021A and ARCH_LAYERSCAPE, there are just 32BE and 32LE for the register R/W.
> 
> Also why not use readq/writeq helpers, registers seem to be contagious
[Yuan Yao] It's hard to use readq/writeq because of the endianness.
> 
> > +static enum dma_status fsl_qdma_tx_status(struct dma_chan *chan,
> > +		dma_cookie_t cookie, struct dma_tx_state *txstate) {
> > +	return dma_cookie_status(chan, cookie, txstate);
> 
> No residue ?
[Yuan Yao] The QDMA is a strange DMA that I can't find any hardware interface to query the data transfer size.
> 
> > +static irqreturn_t fsl_qdma_controller_handler_err(int irq, void
> > +*dev_id) {
> > +	struct fsl_qdma_engine *fsl_qdma = dev_id;
> > +	u32 reg;
> > +
> > +	reg = qdma_readl(fsl_qdma, fsl_qdma->membase + FSL_QDMA_DLSR);
> > +
> > +	if (reg & FSL_QDMA_DLSR_TE) {
> > +		dev_err(fsl_qdma->dma_dev.dev,
> > +			"Transfer error. Check your address please!\n");
> 
> It would help to print the addresses...
[Yuan Yao] Ok, The bus address or the virtual address?
> 
> > +		ret = devm_request_irq(&pdev->dev, fsl_qdma-
> >controller_irq,
> > +				fsl_qdma_controller_handler, 0,
> > +				"qDMA controller", fsl_qdma);
> > +		if (ret) {
> > +			dev_err(&pdev->dev,
> > +				"Can't register qDMA controller IRQ.\n");
> > +			return  ret;
> > +		}
> > +
> > +		ret = devm_request_irq(&pdev->dev, fsl_qdma->err_irq,
> > +				fsl_qdma_controller_handler_err, 0,
> > +				"qDMA err", fsl_qdma);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Can't register qDMA err
> IRQ.\n");
> > +			return  ret;
> > +		}
> 
> why do you want devm variant here..?
[Yuan Yao] There is a different err IRQ in some SOCs. So I should do like this to support those different hardware. 
> 
> > +	dma_cap_set(DMA_PRIVATE, fsl_qdma->dma_dev.cap_mask);
> > +	dma_cap_set(DMA_MEMCPY, fsl_qdma->dma_dev.cap_mask);
> > +
> > +	fsl_qdma->dma_dev.dev = &pdev->dev;
> > +	fsl_qdma->dma_dev.device_free_chan_resources
> > +		= fsl_qdma_free_chan_resources;
> > +	fsl_qdma->dma_dev.device_tx_status = fsl_qdma_tx_status;
> > +	fsl_qdma->dma_dev.device_prep_dma_memcpy =
> fsl_qdma_prep_memcpy;
> > +	fsl_qdma->dma_dev.device_issue_pending =
> fsl_qdma_issue_pending;
> 
> No terminate_all callback?
[Yuan Yao] QDMA is such a strange DMA that I can't find any hardware interface to stop a  in progress transmission.
> 
> > +static int fsl_qdma_remove(struct platform_device *pdev) {
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct fsl_qdma_engine *fsl_qdma = platform_get_drvdata(pdev);
> > +
> > +	of_dma_controller_free(np);
> > +	dma_async_device_unregister(&fsl_qdma->dma_dev);
> 
> And as i said above, the irq is left enabled, pls free that up
[Yuan Yao] Ok, Thanks.
> 
> > +static int __init fsl_qdma_init(void) {
> > +	return platform_driver_register(&fsl_qdma_driver);
> > +}
> > +subsys_initcall(fsl_qdma_init);
> > +
> > +static void __exit fsl_qdma_exit(void) {
> > +	platform_driver_unregister(&fsl_qdma_driver);
> > +}
> > +module_exit(fsl_qdma_exit);
> 
> module_platform_driver please
[Yuan Yao] Ok ,thanks.
> 
> --
> ~Vinod
