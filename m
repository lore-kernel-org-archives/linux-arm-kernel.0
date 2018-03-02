From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 02 Mar 2018 16:43:09 +0100
Subject: [PATCH] soc: rockchip: power-domain: use clk_bulk APIs
In-Reply-To: <20180228124143.8364-1-jeffy.chen@rock-chips.com>
References: <20180228124143.8364-1-jeffy.chen@rock-chips.com>
Message-ID: <2683576.o9hXnVZqaR@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

Am Mittwoch, 28. Februar 2018, 13:41:43 CET schrieb Jeffy Chen:
> Use clk_bulk APIs, and also add error handling for clk enable.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

[...]

> -	for (i = 0; i < clk_cnt; i++) {
> -		clk = of_clk_get(node, i);
> -		if (IS_ERR(clk)) {
> -			error = PTR_ERR(clk);
> +	pd->num_clks = of_count_phandle_with_args(node, "clocks",
> +						  "#clock-cells");
> +
> +	pd->clks = devm_kzalloc(pmu->dev, pd->num_clks * sizeof(pd->clks[0]),

applied for 4.17, after changing to devm_kcalloc like below:

pd->clks = devm_kcalloc(pmu->dev, pd->num_clks, sizeof(*pd->clks),


Thanks
Heiko
