From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 20 Nov 2018 12:38:33 +0200
Subject: [PATCH] clk: Add (devm_)clk_get_optional() functions
In-Reply-To: <20181119141259.11992-1-phil.edworthy@renesas.com>
References: <20181119141259.11992-1-phil.edworthy@renesas.com>
Message-ID: <20181120103832.GV10650@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 02:12:59PM +0000, Phil Edworthy wrote:
> This adds clk_get_optional() and devm_clk_get_optional() functions to get
> optional clocks.
> They behave the same as (devm_)clk_get except where there is no clock
> producer. In this case, instead of returning -ENOENT, the function
> returns NULL. This makes error checking simpler and allows
> clk_prepare_enable, etc to be called on the returned reference
> without additional checks.

>  - Instead of messing with the core functions, simply wrap them for the
>    _optional() versions. By putting clk_get_optional() inline in the header
>    file, we can get rid of the arch specific patches as well.

Fine if it would have no surprises with error handling.

> +	if (ERR_PTR(-ENOENT))
> +		return NULL;
> +	else
> +		return clk;

return clk == ERR_PTR(-ENOENT) ? NULL : clk;

?

> +	if (clk == ERR_PTR(-ENOENT))
> +		return NULL;
> +	else
> +		return clk;

Ditto.


-- 
With Best Regards,
Andy Shevchenko
