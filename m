From: mturquette@ti.com (Mike Turquette)
Date: Mon, 16 Jul 2012 17:12:28 -0700
Subject: [PATCH] clk: fix compile for OF && !COMMON_CLK
In-Reply-To: <1342475161-20402-1-git-send-email-robherring2@gmail.com>
References: <1342475161-20402-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120717001228.GA28886@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120716-16:46, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> With commit 766e6a4ec602d0c107 (clk: add DT clock binding support),
> compiling with OF && !COMMON_CLK is broken.
> 

Hi Rob,

Thanks for sending this quickly.

<snip>
> @@ -313,19 +314,19 @@ int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
>  struct device_node;
>  struct of_phandle_args;
>  
> -#ifdef CONFIG_OF
> +#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
>  struct clk *of_clk_get(struct device_node *np, int index);
>  struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
>  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
>  #else
>  static inline struct clk *of_clk_get(struct device_node *np, int index)
>  {
> -	return NULL;
> +	return ERR_PTR(-EINVAL);

This change seems unrelated?

>  }
>  static inline struct clk *of_clk_get_by_name(struct device_node *np,
>  					     const char *name)
>  {
> -	return NULL;
> +	return ERR_PTR(-EINVAL);

Ditto.

Thanks,
Mike

>  }
>  #endif
>  
> -- 
> 1.7.9.5
> 
