From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez)
Date: Tue, 12 Jul 2016 02:39:54 +0200
Subject: [PATCH] amba: Support clk parents and rates assigned in DT
In-Reply-To: <20160711210852.31553-1-sboyd@codeaurora.org>
References: <20160711210852.31553-1-sboyd@codeaurora.org>
Message-ID: <57843C5A.4040806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2016 11:08 PM, Stephen Boyd wrote:
> Add the call to of_clk_set_defaults() into the amba probe path so
> that devices on the amba bus can use the assigned rates and
> parents feature of the common clock framework.
>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jorge Ramirez Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Tested-by: Jorge Ramirez Ortiz <jorge.ramirez-ortiz@linaro.org>

> ---
>   drivers/amba/bus.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index a5b5c87e2114..a56fa2a1e9aa 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -19,6 +19,7 @@
>   #include <linux/amba/bus.h>
>   #include <linux/sizes.h>
>   #include <linux/limits.h>
> +#include <linux/clk/clk-conf.h>
>   
>   #include <asm/irq.h>
>   
> @@ -237,6 +238,10 @@ static int amba_probe(struct device *dev)
>   	int ret;
>   
>   	do {
> +		ret = of_clk_set_defaults(dev->of_node, false);
> +		if (ret < 0)
> +			break;
> +
>   		ret = dev_pm_domain_attach(dev, true);
>   		if (ret == -EPROBE_DEFER)
>   			break;
