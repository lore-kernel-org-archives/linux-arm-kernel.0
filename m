From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 08:32:05 -0700
Subject: [PATCH v13 6/8] clk: qcom: cpu-8996: Add support to switch to
 alternate PLL
In-Reply-To: <20180614215358.11264-7-ilia.lin@gmail.com>
References: <20180614215358.11264-1-ilia.lin@gmail.com>
 <20180614215358.11264-7-ilia.lin@gmail.com>
Message-ID: <153979032539.5275.12064078400966025600@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting ilia.lin at gmail.com (2018-06-14 14:53:53)
> @@ -227,6 +232,26 @@ clk_cpu_8996_mux_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
>         return 0;
>  }
>  
> +int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,

static? And name it something like clk_cpu_8996_notifier?

> +                       void *data)
> +{
> +       int ret;
> +       struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_nb(nb);
> +
> +       switch (event) {
> +       case PRE_RATE_CHANGE:
> +               ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, ALT_INDEX);
> +               break;
> +       case POST_RATE_CHANGE:
> +               ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw, PLL_INDEX);
> +               break;
> +       default:
> +               ret = 0;
> +               break;
> +       }
> +
> +       return notifier_from_errno(ret);
> +};
