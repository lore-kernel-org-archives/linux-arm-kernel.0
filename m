From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 15 Nov 2013 17:59:46 -0800
Subject: [RFC PATCH RESEND 1/2] clk: add clk accuracy retrieval support
In-Reply-To: <1381684631-10835-2-git-send-email-b.brezillon@overkiz.com>
References: <1381684631-10835-1-git-send-email-b.brezillon@overkiz.com>
 <1381684631-10835-2-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20131116015946.19193.29895@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris BREZILLON (2013-10-13 10:17:10)
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 73bdb69..942811d 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
...
> @@ -194,6 +204,7 @@ struct clk_hw {
>  struct clk_fixed_rate {
>         struct          clk_hw hw;
>         unsigned long   fixed_rate;
> +       unsigned long   fixed_accuracy;

This change belongs in patch #2. Please also update the kerneldoc above
this struct definition.

Regards,
Mike

>         u8              flags;
>  };
>  
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 9a6d045..2fe3b54 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -85,6 +85,23 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb);
>  #endif
>  
>  /**
> + * clk_get_accuracy - obtain the clock accuracy in ppb (parts per billion)
> + *                   for a clock source.
> + * @clk: clock source
> + *
> + * This gets the clock source accuracy expressed in ppb.
> + * A perfect clock returns 0.
> + */
> +#ifdef CONFIG_HAVE_CLK_GET_ACCURACY
> +unsigned long clk_get_accuracy(struct clk *clk);
> +#else
> +static inline unsigned long clk_get_accuracy(struct clk *clk)
> +{
> +       return 0;
> +}
> +#endif
> +
> +/**
>   * clk_prepare - prepare a clock source
>   * @clk: clock source
>   *
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
