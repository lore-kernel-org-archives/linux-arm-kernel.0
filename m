From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 19:00:19 +0000
Subject: [PATCH v2 08/14] clk: hs: add clock support
In-Reply-To: <1363108124-17484-9-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <201303121900.19441.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 March 2013, Haojian Zhuang wrote:
> +void __init hs_init_clocks(void)
> +{
> +       struct device_node *node;
> +
> +       /* map pmctrl registers */
> +       node = of_find_compatible_node(NULL, NULL, "hisilicon,pmctrl");
> +       hs_clk.pmctrl = of_iomap(node, 0);
> +       WARN_ON(!hs_clk.pmctrl);
> +
> +       node = of_find_compatible_node(NULL, NULL, "hisilicon,sctrl");
> +       hs_clk.sctrl = of_iomap(node, 0);
> +
> +       of_clk_init(hs_clk_match);
> +}

You should be able to just use CLK_OF_DECLARE() with each member of
hs_clk_match[] now and call of_clk_init(NULL) from platform code.

This requires moving the of_iomap() calls somewhere else, but it
could be a function that gets called by whichever setup function
gets run first.

	Arnd
