From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Apr 2012 22:52:59 +0200
Subject: [PATCH 13/13] clk: basic: improve parent_names & return errors
In-Reply-To: <1334192572-12499-14-git-send-email-mturquette@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334192572-12499-14-git-send-email-mturquette@linaro.org>
Message-ID: <20120416205259.GI20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 06:02:51PM -0700, Mike Turquette wrote:
> This patch is the basic clk version of 'clk: core: copy parent_names &
> return error codes'.
> 
> The registration functions are changed to allow the core code to copy
> the array of strings and allow platforms to declare those arrays as
> __initdata.
> 
> This patch also converts all of the basic clk registration functions to
> return error codes which better aligns them with the existing clk.h api.
> 
> 
> + */
>  struct clk *clk_register_divider(struct device *dev, const char *name,
>  		const char *parent_name, unsigned long flags,
>  		void __iomem *reg, u8 shift, u8 width,
>  		u8 clk_divider_flags, spinlock_t *lock)
>  {
>  	struct clk_divider *div;
> -	struct clk *clk;
> +	struct clk *clk = ERR_PTR(-ENOMEM);
> +	const char *parent_names[1];
>  
> +	/* allocate the divider */
>  	div = kzalloc(sizeof(struct clk_divider), GFP_KERNEL);
> -
>  	if (!div) {
>  		pr_err("%s: could not allocate divider clk\n", __func__);
>  		return NULL;

You missed a conversion to ERR_PTR here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
