From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jun 2016 09:40:28 +0200
Subject: [PATCH v2 08/15] clk: sunxi-ng: Add divider
In-Reply-To: <20160607204154.31967-9-maxime.ripard@free-electrons.com>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160607204154.31967-9-maxime.ripard@free-electrons.com>
Message-ID: <20160609094028.490c9d38599cda31fdd069be@free.fr>
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
	[snip]
> diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
> new file mode 100644
> index 000000000000..5edbdc1a98c8
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu_div.h
> @@ -0,0 +1,135 @@
> +/*
> + * Copyright (c) 2016 Maxime Ripard. All rights reserved.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _CCU_DIV_H_
> +#define _CCU_DIV_H_
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_mux.h"
> +
> +struct _ccu_div {
> +	u8			shift;
> +	u8			width;
> +
> +	u32			flags;
> +
> +	struct clk_div_table	*table;
> +};
> +
> +#define _SUNXI_CCU_DIV_TABLE_FLAGS(_shift, _width, _table, _flags)	\
> +	{								\
> +		.shift	= _shift,					\
> +		.width	= _width,					\
> +		.flags	= _flags,					\
> +		.table	= _table,					\
> +	}
> +
> +#define _SUNXI_CCU_DIV_FLAGS(_shift, _width, _flags)			\
> +	_SUNXI_CCU_DIV_TABLE_FLAGS(_shift, _width, NULL, _flags)
> +
> +#define _SUNXI_CCU_DIV_TABLE(_shift, _width, _table)			\
> +	_SUNXI_CCU_DIV_TABLE_FLAGS(_shift, _width, _table, 0)
> +
> +#define _SUNXI_CCU_DIV(_shift, _width)					\
> +	_SUNXI_CCU_DIV_TABLE_FLAGS(_shift, _width, NULL, 0)
> +
> +struct ccu_div {
> +	u32			enable;
> +
> +	struct _ccu_div		div;
> +	struct ccu_mux_internal	mux;
> +	struct ccu_common	common;
> +};
> +
> +#define SUNXI_CCU_DIV_TABLE_WITH_GATE(_struct, _name, _parent, _reg,	\
> +				      _shift, _width,			\
> +				      _table, _gate, _flags)		\
> +	struct ccu_div _struct = {					\

The gate is missing
		.enable = _gate,

(I was really afraid when I saw 217?C as the board temperature!)

> +		.div		= _SUNXI_CCU_DIV_TABLE(_shift, _width,	\
> +						       _table),		\
> +		.common	= {						\
> +			.reg		= _reg,				\
> +			.features	= CCU_FEATURE_GATE,		\
> +			.hw.init	= SUNXI_HW_INIT(_name,		\
> +							_parent,	\
> +							&ccu_div_ops,	\
> +							_flags),	\
> +		}							\
> +	}
> +
> +
> +#define SUNXI_CCU_DIV_TABLE(_struct, _name, _parent, _reg,		\
> +			    _shift, _width,				\
> +			    _table, _flags)				\
	[snip]

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
