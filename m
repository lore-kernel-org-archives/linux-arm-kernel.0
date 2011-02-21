From: weitway@gmail.com (Jason Chen)
Date: Mon, 21 Feb 2011 13:38:32 +0800
Subject: [PATCH 1/7] Add a mfd IPUv3 driver
In-Reply-To: <1297865452-32181-2-git-send-email-s.hauer@pengutronix.de>
References: <1297865452-32181-1-git-send-email-s.hauer@pengutronix.de>
	<1297865452-32181-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <AANLkTinQrXUwyRjehLr4YFiR66CRxT8ocEQMLXOEzHJx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Sascha,

I have few comments for this patch.

> +#define MX51_IPU_CHANNEL_CSI0 ? ? ? ? ? ? ? ? ? 0
> +#define MX51_IPU_CHANNEL_CSI1 ? ? ? ? ? ? ? ? ? 1
> +#define MX51_IPU_CHANNEL_CSI2 ? ? ? ? ? ? ? ? ? 2
> +#define MX51_IPU_CHANNEL_CSI3 ? ? ? ? ? ? ? ? ? 3
> +#define MX51_IPU_CHANNEL_MEM_BG_SYNC ? ? ? ? ? 23
> +#define MX51_IPU_CHANNEL_MEM_FG_SYNC ? ? ? ? ? 27
> +#define MX51_IPU_CHANNEL_MEM_DC_SYNC ? ? ? ? ? 28
> +#define MX51_IPU_CHANNEL_MEM_FG_SYNC_ALPHA ? ? 31
> +#define MX51_IPU_CHANNEL_MEM_DC_ASYNC ? ? ? ? ?41
> +#define MX51_IPU_CHANNEL_ROT_ENC_MEM ? ? ? ? ? 45
> +#define MX51_IPU_CHANNEL_ROT_VF_MEM ? ? ? ? ? ?46
> +#define MX51_IPU_CHANNEL_ROT_PP_MEM ? ? ? ? ? ?47
> +#define MX51_IPU_CHANNEL_ROT_ENC_MEM_OUT ? ? ? 48
> +#define MX51_IPU_CHANNEL_ROT_VF_MEM_OUT ? ? ? ? ? ? ? ?49
> +#define MX51_IPU_CHANNEL_ROT_PP_MEM_OUT ? ? ? ? ? ? ? ?50
> +#define MX51_IPU_CHANNEL_MEM_BG_SYNC_ALPHA ? ? 51
Had better use MX5_IPU as prefix because it's same value in MX5X.

> +
> + ? ? ? ipu_idmac_reg = ioremap(ipu_base + IPU_IDMAC_REG_BASE, PAGE_SIZE);
> + ? ? ? if (!ipu_idmac_reg) {
> + ? ? ? ? ? ? ? ret = -ENOMEM;
> + ? ? ? ? ? ? ? goto failed_ioremap2;
> + ? ? ? }
> +
> + ? ? ? ret = ipu_mipi_setup();
> + ? ? ? if (ret)
> + ? ? ? ? ? ? ? goto failed_mipi_setup;
I dont know what's the best way to do it, but I think you had better
consider mx53 platform, so maybe this mipi_setup function and also
below ipu hw reset could be set in platform data.
> +
> + ? ? ? ipu_clk = clk_get(&pdev->dev, "ipu");
> + ? ? ? if (IS_ERR(ipu_clk)) {
> + ? ? ? ? ? ? ? ret = PTR_ERR(ipu_clk);
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "clk_get failed with %d", ret);
> + ? ? ? ? ? ? ? goto failed_clk_get;
> + ? ? ? }
> +
> + ? ? ? ipu_get();
> +
> + ? ? ? ret = request_irq(irq1, ipu_irq_handler, IRQF_DISABLED, pdev->name,
> + ? ? ? ? ? ? ? ? ? ? ? &pdev->dev);
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "request irq %d failed with: %d\n", irq1, ret);
> + ? ? ? ? ? ? ? goto failed_request_irq1;
> + ? ? ? }
> +
> + ? ? ? ret = request_irq(irq2, ipu_irq_handler, IRQF_DISABLED, pdev->name,
> + ? ? ? ? ? ? ? ? ? ? ? &pdev->dev);
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "request irq %d failed with: %d\n", irq2, ret);
> + ? ? ? ? ? ? ? goto failed_request_irq2;
> + ? ? ? }
> +
> + ? ? ? ipu_reset();
