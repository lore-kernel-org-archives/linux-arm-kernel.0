From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Apr 2012 08:45:19 +0200
Subject: [PATCH 02/40] clk: add a fixed factor clock
In-Reply-To: <4F8F8AF1.3070802@st.com>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-3-git-send-email-s.hauer@pengutronix.de>
 <4F8F8AF1.3070802@st.com>
Message-ID: <20120419064519.GI3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 09:18:01AM +0530, Viresh Kumar wrote:
> On 4/10/2012 7:15 PM, Sascha Hauer wrote:
> > Having fixed factors/dividers in hardware is a common pattern, so
> > add a basic clock type doing this. It basically describes a fixed
> > factor clock using a nominator and a denominator.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/clk/Makefile           |    2 +-
> >  drivers/clk/clk-fixed-factor.c |   97 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/clk-provider.h   |    4 ++
> >  3 files changed, 102 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/clk/clk-fixed-factor.c
> 
> @Mike: It would be better if you can take this patch atleast ASAP in your next,
> so that Arnd can pull in SPEAr clk patches.
> 
> Hi Sascha/Mike,
> 
> Please see if following can be squashed with this patch. This clock is
> used for SPEAr too :)

Generally yes, but I want to delay this until we have an official branch
for clk-common-next (In which probably clk_register copies the parent
names)

Sascha

> 
> ---
>  drivers/clk/clk-fixed-factor.c |   12 ++----------
>  1 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> index 7c5e1fc..aaf5a88 100644
> --- a/drivers/clk/clk-fixed-factor.c
> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -16,7 +16,6 @@ struct clk_fixed_factor {
>  	struct clk_hw	hw;
>  	unsigned int	mult;
>  	unsigned int	div;
> -	char		*parent[1];
>  };
>  
>  #define to_clk_fixed_factor(_hw) container_of(_hw, struct clk_fixed_factor, hw)
> @@ -75,22 +74,15 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
>  	fix->mult = mult;
>  	fix->div = div;
>  
> -	if (parent_name) {
> -		fix->parent[0] = kstrdup(parent_name, GFP_KERNEL);
> -		if (!fix->parent[0])
> -			goto out;
> -	}
> -
>  	clk = clk_register(dev, name,
>  			&clk_fixed_factor_ops, &fix->hw,
> -			fix->parent,
> +			&parent_name,
>  			(parent_name ? 1 : 0),
>  			flags);
> +
>  	if (clk)
>  		return clk;
>  
> -out:
> -	kfree(fix->parent[0]);
>  	kfree(fix);
>  
>  	return NULL;
> -- 
> 1.7.9
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
