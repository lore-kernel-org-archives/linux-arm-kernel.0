From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 24 Sep 2013 11:20:05 +0200
Subject: [PATCH V2 1/6] clk: exynos-audss: convert to platform device
In-Reply-To: <1379982078-23381-1-git-send-email-abrestic@chromium.org>
References: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
 <1379982078-23381-1-git-send-email-abrestic@chromium.org>
Message-ID: <3549301.xmRx49e0Zc@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

I'd like to ack this series, but there is one more thing that I think
should be fixed. Please see my comment inline.

On Monday 23 of September 2013 17:21:13 Andrew Bresticker wrote:
> @@ -128,8 +135,53 @@ static void __init exynos_audss_clk_init(struct device_node *np)
>  #endif
>  
>  	pr_info("Exynos: Audss: clock setup completed\n");

nit (not the thing I mentioned above): This (and possibly other uses of
pr_*() could be replaced with dev_*().

> +
> +	return 0;
> +}
> +
> +static int exynos_audss_clk_remove(struct platform_device *pdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < EXYNOS_AUDSS_MAX_CLKS; i++) {
> +		if (clk_table[i])

I believe clk_register_* functions return ERR_PTR() in case of failure,
not NULL, so this should be accounted for either here or at probe time.
Possibly checking for registration error in probe() would be the best
solution, although bloating the code a bit (but what error path isn't?).

Best regards,
Tomasz
