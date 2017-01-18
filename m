From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 18 Jan 2017 14:21:33 +0800
Subject: [PATCH v11 08/12] drm/mediatek: add dsi interrupt control
In-Reply-To: <1484117473-46644-9-git-send-email-yt.shen@mediatek.com>
References: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
 <1484117473-46644-9-git-send-email-yt.shen@mediatek.com>
Message-ID: <1484720493.26941.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Wed, 2017-01-11 at 14:51 +0800, YT Shen wrote:
> From: shaoming chen <shaoming.chen@mediatek.com>
> 
> add dsi interrupt control
> 
> Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>

Acked-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 92 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 6f4b3bb..474861a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -18,6 +18,7 @@
>  #include <drm/drm_panel.h>
>  #include <linux/clk.h>
>  #include <linux/component.h>
> +#include <linux/irq.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_graph.h>
> @@ -29,6 +30,16 @@
>  
>  #define DSI_START		0x00
>  
> +#define DSI_INTEN		0x08
> +
> +#define DSI_INTSTA		0x0c
> +#define LPRX_RD_RDY_INT_FLAG		BIT(0)
> +#define CMD_DONE_INT_FLAG		BIT(1)
> +#define TE_RDY_INT_FLAG			BIT(2)
> +#define VM_DONE_INT_FLAG		BIT(3)
> +#define EXT_TE_RDY_INT_FLAG		BIT(4)
> +#define DSI_BUSY			BIT(31)
> +
>  #define DSI_CON_CTRL		0x10
>  #define DSI_RESET			BIT(0)
>  #define DSI_EN				BIT(1)
> @@ -71,6 +82,9 @@
>  
>  #define DSI_HSTX_CKL_WC		0x64
>  
> +#define DSI_RACK		0x84
> +#define RACK				BIT(0)
> +
>  #define DSI_PHY_LCCON		0x104
>  #define LC_HS_TX_EN			BIT(0)
>  #define LC_ULPM_EN			BIT(1)
> @@ -137,6 +151,8 @@ struct mtk_dsi {
>  	struct videomode vm;
>  	int refcount;
>  	bool enabled;
> +	u32 irq_data;
> +	wait_queue_head_t irq_wait_queue;
>  };
>  
>  static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
> @@ -469,6 +485,64 @@ static void mtk_dsi_start(struct mtk_dsi *dsi)
>  	writel(1, dsi->regs + DSI_START);
>  }
>  
> +static void mtk_dsi_set_interrupt_enable(struct mtk_dsi *dsi)
> +{
> +	u32 inten = LPRX_RD_RDY_INT_FLAG | CMD_DONE_INT_FLAG | VM_DONE_INT_FLAG;
> +
> +	writel(inten, dsi->regs + DSI_INTEN);
> +}
> +
> +static void mtk_dsi_irq_data_set(struct mtk_dsi *dsi, u32 irq_bit)
> +{
> +	dsi->irq_data |= irq_bit;
> +}
> +
> +static __maybe_unused void mtk_dsi_irq_data_clear(struct mtk_dsi *dsi, u32 irq_bit)
> +{
> +	dsi->irq_data &= ~irq_bit;
> +}
> +
> +static __maybe_unused s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *dsi, u32 irq_flag,
> +				     unsigned int timeout)
> +{
> +	s32 ret = 0;
> +	unsigned long jiffies = msecs_to_jiffies(timeout);
> +
> +	ret = wait_event_interruptible_timeout(dsi->irq_wait_queue,
> +					       dsi->irq_data & irq_flag,
> +					       jiffies);
> +	if (ret == 0) {
> +		DRM_WARN("Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
> +
> +		mtk_dsi_enable(dsi);
> +		mtk_dsi_reset_engine(dsi);
> +	}
> +
> +	return ret;
> +}
> +
> +static irqreturn_t mtk_dsi_irq(int irq, void *dev_id)
> +{
> +	struct mtk_dsi *dsi = dev_id;
> +	u32 status, tmp;
> +	u32 flag = LPRX_RD_RDY_INT_FLAG | CMD_DONE_INT_FLAG | VM_DONE_INT_FLAG;
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
>  static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
>  {
>  	if (WARN_ON(dsi->refcount == 0))
> @@ -517,6 +591,7 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
>  
>  	mtk_dsi_ps_control_vact(dsi);
>  	mtk_dsi_config_vdo_timing(dsi);
> +	mtk_dsi_set_interrupt_enable(dsi);
>  
>  	mtk_dsi_set_mode(dsi);
>  	mtk_dsi_clk_hs_mode(dsi, 1);
> @@ -818,6 +893,7 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *remote_node, *endpoint;
>  	struct resource *regs;
> +	int irq_num;
>  	int comp_id;
>  	int ret;
>  
> @@ -894,6 +970,22 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	irq_num = platform_get_irq(pdev, 0);
> +	if (irq_num < 0) {
> +		dev_err(&pdev->dev, "failed to request dsi irq resource\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	irq_set_status_flags(irq_num, IRQ_TYPE_LEVEL_LOW);
> +	ret = devm_request_irq(&pdev->dev, irq_num, mtk_dsi_irq,
> +			       IRQF_TRIGGER_LOW, dev_name(&pdev->dev), dsi);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request mediatek dsi irq\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	init_waitqueue_head(&dsi->irq_wait_queue);
> +
>  	platform_set_drvdata(pdev, dsi);
>  
>  	return component_add(&pdev->dev, &mtk_dsi_component_ops);
