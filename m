From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 6 Dec 2017 22:47:23 -0800
Subject: [PATCH V6 01/12] drivers: move clock common macros out from
 vendor directories
In-Reply-To: <20171127100115.20655-2-chunyan.zhang@spreadtrum.com>
References: <20171127100115.20655-1-chunyan.zhang@spreadtrum.com>
 <20171127100115.20655-2-chunyan.zhang@spreadtrum.com>
Message-ID: <20171207064723.GV4283@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27, Chunyan Zhang wrote:
> These macros are used by more than one SoC vendor platforms, avoid to
> have many copies of these code, this patch moves them to the common
> clock directory which every clock drivers can access to.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  drivers/clk/clk_common.h | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 drivers/clk/clk_common.h
> 
> diff --git a/drivers/clk/clk_common.h b/drivers/clk/clk_common.h
> new file mode 100644
> index 0000000..21e93d2
> --- /dev/null
> +++ b/drivers/clk/clk_common.h
> @@ -0,0 +1,60 @@
> +/*
> + * drivers/clk/clk_common.h

We don't need this in the file too. Please remove this line.

> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> +
> +#ifndef _CLK_COMMON_H_
> +#define _CLK_COMMON_H_
> +
> +#include <linux/clk-provider.h>

Maybe these macros should just go into clk-provider.h?

> +
> +#define CLK_HW_INIT(_name, _parent, _ops, _flags)		\
> +	(&(struct clk_init_data) {				\
> +		.flags		= _flags,			\
> +		.name		= _name,			\
> +		.parent_names	= (const char *[]) { _parent },	\
> +		.num_parents	= 1,				\
> +		.ops		= _ops,				\
> +	})

Hopefully we don't extend the init structure anymore to have
something else. I guess we'll do something if that happens.

> +
> +#define CLK_HW_INIT_PARENTS(_name, _parents, _ops, _flags)	\
> +	(&(struct clk_init_data) {				\
> +		.flags		= _flags,			\
> +		.name		= _name,			\
> +		.parent_names	= _parents,			\
> +		.num_parents	= ARRAY_SIZE(_parents),		\
> +		.ops		= _ops,				\
> +	})
> +
> +#define CLK_HW_INIT_NO_PARENT(_name, _ops, _flags)     \
> +	(&(struct clk_init_data) {                      \
> +		.flags          = _flags,               \
> +		.name           = _name,                \
> +		.parent_names   = NULL,                 \
> +		.num_parents    = 0,                    \
> +		.ops            = _ops,                 \
> +	})
> +
> +#define CLK_FIXED_FACTOR(_struct, _name, _parent,			\
> +			_div, _mult, _flags)				\
> +	struct clk_fixed_factor _struct = {				\
> +		.div		= _div,					\
> +		.mult		= _mult,				\
> +		.hw.init	= CLK_HW_INIT(_name,			\
> +					      _parent,			\
> +					      &clk_fixed_factor_ops,	\
> +					      _flags),			\
> +	}
> +
> +#define CLK_FIXED_RATE(_struct, _name, _flags,				\
> +		       _fixed_rate, _fixed_accuracy)			\
> +	struct clk_fixed_rate _struct = {				\
> +		.fixed_rate	= _fixed_rate,				\
> +		.fixed_accuracy	= _fixed_accuracy,			\
> +		.hw.init	= CLK_HW_INIT_NO_PARENT(_name,		\
> +					  &clk_fixed_rate_ops,		\
> +							_flags),	\
> +	}

Maybe don't add this one? Usually fixed rate clks come from DT.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
