From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 30 May 2012 14:58:23 +0530
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <4FC5E837.30702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tuesday 29 May 2012 03:28 PM, Peter De Schrijver wrote:
> Add an extension API for clocks. This allows clocktypes to provide extensions
> for features which are uncommon and cannot be easily mapped onto normal clock
> framework concecpts. eg: resetting blocks, configuring clock phase etc.

I was thinking on similar lines for OMAP wherein I need to control
'hardware-auto-gating' bits on clocks which are otherwise just normal
gates or dividers. We just disable all of them early at boot and
re-enable them late in the boot process once PM kicks in.

regards,
Rajendra

>
> Signed-off-by: Peter De Schrijver<pdeschrijver@nvidia.com>
> ---
>   drivers/clk/clk.c            |    8 ++++++++
>   include/linux/clk-provider.h |    2 ++
>   include/linux/clk.h          |    2 ++
>   3 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index e5d5dc1..39bc458 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -956,6 +956,14 @@ struct clk *clk_get_parent(struct clk *clk)
>   }
>   EXPORT_SYMBOL_GPL(clk_get_parent);
>
> +int clk_ext(struct clk *clk, unsigned int op, unsigned long param)
> +{
> +	if (clk->ops->ext)
> +		return clk->ops->ext(clk->hw, op, param);
> +
> +	return -EINVAL;
> +}
> +
>   /*
>    * .get_parent is mandatory for clocks with multiple possible parents.  It is
>    * optional for single-parent clocks.  Always call .get_parent if it is
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 6803fb4..08025d3 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -109,6 +109,8 @@ struct clk_ops {
>   	int		(*set_rate)(struct clk_hw *hw, unsigned long,
>   				    unsigned long);
>   	void		(*init)(struct clk_hw *hw);
> +	int		(*ext)(struct clk_hw *hw, unsigned int op,
> +					unsigned long param);
>   };
>
>   /**
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 0e078bd..74be656 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -278,4 +278,6 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id);
>   int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
>   			struct device *dev);
>
> +int clk_ext(struct clk *clk, unsigned int op, unsigned long param);
> +
>   #endif
