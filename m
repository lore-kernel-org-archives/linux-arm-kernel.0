From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 May 2015 10:05:16 +0200
Subject: [PATCH 5/5] clk: mediatek: Add USB clock support in MT8173
 APMIXEDSYS
In-Reply-To: <1432192376-6712-6-git-send-email-jamesjj.liao@mediatek.com>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <1432192376-6712-6-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20150526080516.GG6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 03:12:56PM +0800, James Liao wrote:
> Add REF2USB_TX clock support into MT8173 APMIXEDSYS. This clock
> is needed by USB 3.0.
> 
> +
> +static struct clk *mtk_clk_register_ref2usb_tx(const char *name,
> +			void __iomem *reg)
> +{
> +	struct mtk_ref2usb_tx *tx;
> +	struct clk_init_data init = {};
> +	struct clk *clk;
> +	const char *parent_name = "clk26m";
> +
> +	tx = kzalloc(sizeof(*tx), GFP_KERNEL);
> +	if (!tx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	tx->base_addr = reg;
> +	tx->hw.init = &init;
> +
> +	init.name = name;
> +	init.ops = &mtk_ref2usb_tx_ops;
> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +
> +	clk = clk_register(NULL, &tx->hw);
> +
> +	if (IS_ERR(clk)) {
> +		pr_err("Failed to register clk %s: %ld\n", name, PTR_ERR(clk));
> +		kfree(tx);
> +	}
> +
> +	return clk;
> +}
> +
> +static void __init mtk_clk_register_apmixedsys_special(struct device_node *node,
> +			struct clk_onecell_data *clk_data)
> +{
> +	void __iomem *base;
> +	struct clk *clk;
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("%s(): ioremap failed\n", __func__);
> +		return;
> +	}
> +
> +	clk = mtk_clk_register_ref2usb_tx("ref2usb_tx", base + 0x8);

The function seems to be for one special clock only. Why do you pass the
name to it? They will never be called with another name, right?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
