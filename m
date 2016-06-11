From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 11 Jun 2016 10:27:54 +0200
Subject: [PATCH v2 08/15] clk: sunxi-ng: Add divider
In-Reply-To: <20160607204154.31967-9-maxime.ripard@free-electrons.com>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160607204154.31967-9-maxime.ripard@free-electrons.com>
Message-ID: <20160611102754.394c28863c2f50d5d29b94a1@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  7 Jun 2016 22:41:47 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Add support for the various dividers (linear, table or pow-of-two based)
> found in the CCU.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/Makefile  |   1 +
>  drivers/clk/sunxi-ng/ccu_div.c | 136 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_div.h | 135 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 272 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu_div.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu_div.h
> 
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index c47cbd309d59..67a2559fe283 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -3,6 +3,7 @@ obj-y += ccu_reset.o
>  
>  obj-y += ccu_frac.o
>  
> +obj-y += ccu_div.o
>  obj-y += ccu_fixed_factor.o
>  obj-y += ccu_gate.o
>  obj-y += ccu_mux.o
> diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
> new file mode 100644
> index 000000000000..8659b4cb6c20
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_div.c
> @@ -0,0 +1,136 @@
	[snip]
> diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
> new file mode 100644
> index 000000000000..5edbdc1a98c8
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_div.h
> @@ -0,0 +1,135 @@
	[snip]
> +#define SUNXI_CCU_M_WITH_GATE(_struct, _name, _parent, _reg,		\
> +			      _mshift, _mwidth,	_gate,			\
> +			      _flags)					\
> +	struct ccu_div _struct = {					\
> +		.enable	= _gate,					\
> +		.div	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
> +		.common	= {						\
> +			.reg		= _reg,				\
> +			.features	= CCU_FEATURE_GATE,		\
> +			.hw.init	= SUNXI_HW_INIT(_name,		\
> +							_parent,	\
> +							&ccu_div_ops,	\
> +							_flags),	\
> +		},							\
> +	}
> +
> +#define SUNXI_CCU_M(_struct, _name, _parent, _reg, _mshift, _mwidth,	\
> +		    _flags)						\
> +	SUNXI_CCU_M_WITH_GATE(_struct, _name, _parent, _reg,		\
> +			      _mshift, _mwidth, 0, _flags)
	[snip]

This shows that the flag CCU_FEATURE_GATE is perfectly useless...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
