From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 15 Oct 2015 12:26:26 -0700
Subject: [PATCH 09/13] clk: versatile-icst: add device tree support
In-Reply-To: <1444916813-31024-10-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-10-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151015192626.GO4558@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Linus Walleij wrote:
> +
> +	if (of_device_is_compatible(np, "arm,syscon-icst525"))
> +		icst_desc.params = &icst525_params;
> +	else if (of_device_is_compatible(np, "arm,syscon-icst307"))
> +		icst_desc.params = &icst307_params;

I guess if we add anymore here we should use an of_device_id
array instead.

> +	else {
> +		pr_info("unknown ICST clock %s\n", name);

pr_warn? pr_err?

> +		return;
> +	}
> +
> +	/* Parent clock name is not the same as node parent */
> +	parent_name = of_clk_get_parent_name(np, 0);
> +
> +	regclk = icst_clk_setup(NULL, &icst_desc, name, parent_name, map);
> +	if (IS_ERR(regclk)) {
> +		pr_err("error setting up syscon ICST clock %s\n", name);
> +		return;
> +	}
> +	of_clk_add_provider(np, of_clk_src_simple_get, regclk);
> +	pr_info("registered syscon ICST clock %s\n", name);

debug print? Please remove debug noise.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
