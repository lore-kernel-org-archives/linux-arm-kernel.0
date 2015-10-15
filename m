From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 15 Oct 2015 12:08:09 -0700
Subject: [PATCH 06/13] clk: versatile-icst: convert to use regmap
In-Reply-To: <1444916813-31024-7-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-7-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151015190809.GL4558@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Linus Walleij wrote:
> @@ -151,10 +174,19 @@ struct clk *icst_clk_register(struct device *dev,
>  	init.flags = CLK_IS_ROOT;
>  	init.parent_names = (parent_name ? &parent_name : NULL);
>  	init.num_parents = (parent_name ? 1 : 0);
> +	icst->map = regmap_init_mmio(NULL, base, &icst_regmap_conf);
> +	if (IS_ERR(icst->map)) {
> +		int ret;
> +
> +		pr_err("could not initialize ICST regmap\n");
> +		kfree(icst);
> +		ret = PTR_ERR(icst->map);

drivers/clk/versatile/clk-icst.c:183
icst_clk_register() error: dereferencing freed memory 'icst'
drivers/clk/versatile/clk-icst.c:184
icst_clk_register() warn: possible memory leak of 'pclone'


> +		return ERR_PTR(ret);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
