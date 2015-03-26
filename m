From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Mar 2015 14:18:34 +0000
Subject: [PATCH 1/4] clk: hisi: add API for allocation clk data struct
In-Reply-To: <1427368419-22222-2-git-send-email-leo.yan@linaro.org>
References: <1427368419-22222-1-git-send-email-leo.yan@linaro.org>
 <1427368419-22222-2-git-send-email-leo.yan@linaro.org>
Message-ID: <20150326141834.GI8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 07:13:36PM +0800, Leo Yan wrote:
> +struct hisi_clock_data __init *hisi_clk_init(struct device_node *np,
> +					     int nr_clks)
> +{
> +	struct hisi_clock_data *clk_data;
> +	void __iomem *base;
> +
> +	if (np) {
> +		base = of_iomap(np, 0);
> +		if (!base) {
> +			pr_err("failed to map Hisilicon clock registers\n");
> +			return NULL;
> +		}
> +		printk("%s: base %p\n", __func__, base);

Did you leave your debugging in?

> +	} else {
> +		pr_err("failed to find Hisilicon clock node in DTS\n");
> +		return NULL;
> +	}

I know you're mostly only moving this code, but it would be far better if
it were written:

	if (!np) {
		pr_err("failed to find Hisilicon clock node in DTS\n");
		return NULL;
	}

	base = of_iomap(np, 0);
	if (!base) {
		pr_err("failed to map Hisilicon clock registers\n");
		return NULL;
	}

Possibly do this first as a separate patch, and then move the code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
