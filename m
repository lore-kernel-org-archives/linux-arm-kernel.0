From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 13 Apr 2012 12:01:33 +0200
Subject: [PATCH] clk: Allocate and add clock lookups from clk_register()
In-Reply-To: <9fa570d09d94cdc4892b4e413ef3a0edc6f9dcef.1334298848.git.viresh.kumar@st.com>
References: <9fa570d09d94cdc4892b4e413ef3a0edc6f9dcef.1334298848.git.viresh.kumar@st.com>
Message-ID: <20120413100133.GI3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 12:04:57PM +0530, Viresh Kumar wrote:
> clock lookups are required for few clocks for which we do clk_get() or
> clk_get_sys(). Adding clock lookups for them with new clock framework, would
> mean a lot of code for each platform. Simplify this by doing this allocation and
> addition to global list in clk_register() only.
> 
> This is done on request by the caller, i.e. only if user passes valid pointers
> in "dev_id" OR "con_id" fields.
> 
> A lot of changes at other places/files/comments are also required, that i would
> do separately. This is the initial version to get initial feedback.
> 
> Pointer to original discussion:
> http://www.spinics.net/lists/arm-kernel/msg169133.html

For reasons mentioned in this thread (long argument list, line wraps in
clk_register calls, only leaf nodes need lookups) I don't think this is
a good idea.

>   */
>  struct clk *clk_register(struct device *dev, const char *name,
>  		const struct clk_ops *ops, struct clk_hw *hw,
> -		const char **parent_names, u8 num_parents, unsigned long flags)
> +		const char **parent_names, u8 num_parents, unsigned long flags,
> +		struct clk_lookup **cl, const char *dev_id, const char *con_id)
>  {

Also this doesn't handle the case when multiple lookups are associated
with a single clock (which is quite a common case on some SoCs). Yes,
we could still use the returned clk to register the additional lookups,
but that would make the advantage of this patch even smaller.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
