From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 13 Sep 2016 16:55:04 +0800
Subject: [PATCH v8 6/9] drm/mediatek: add dsi interrupt control
In-Reply-To: <1473681672-47144-7-git-send-email-yt.shen@mediatek.com>
References: <1473681672-47144-1-git-send-email-yt.shen@mediatek.com>
 <1473681672-47144-7-git-send-email-yt.shen@mediatek.com>
Message-ID: <1473756904.28437.32.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Mon, 2016-09-12 at 20:01 +0800, YT Shen wrote:
> From: shaoming chen <shaoming.chen@mediatek.com>
> 
> add dsi interrupt control
> 
> Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 78 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 

[snip...]

>  
> +static void mtk_dsi_set_interrupt_enable(struct mtk_dsi *dsi)
> +{
> +	u32 inten = DSI_INT_ALL_BITS;
> +
> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO)
> +		inten &= ~(TE_RDY_INT_FLAG | EXT_TE_RDY_INT_FLAG);
> +
> +	writel(inten, dsi->regs + DSI_INTEN);
> +}
> +

[snip...]

> +
> +static irqreturn_t mtk_dsi_irq(int irq, void *dev_id)
> +{
> +	struct mtk_dsi *dsi = dev_id;
> +	u32 status, tmp;
> +	u32 flag = LPRX_RD_RDY_INT_FLAG | CMD_DONE_INT_FLAG | VM_DONE_INT_FLAG;

Why do you only process these three irq? You also enable TE_RDY_INT_FLAG
& EXT_TE_RDY_INT_FLAG in mtk_dsi_set_interrupt_enable(). Process these
two irq here or not enable them in mtk_dsi_set_interrupt_enable().

Regards,
CK

> +
> +	status = readl(dsi->regs + DSI_INTSTA) & flag;
> +
> +	if (status) {
> +		do {
> +			mtk_dsi_mask(dsi, DSI_RACK, RACK, RACK);
> +			tmp = readl(dsi->regs + DSI_INTSTA);
> +		} while (tmp & DSI_BUSY);
> +
> +		mtk_dsi_mask(dsi, DSI_INTSTA, status, 0);
> +		mtk_dsi_irq_data_set(dsi, status);
> +		wake_up_interruptible(&dsi->irq_wait_queue);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
