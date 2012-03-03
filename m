From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 3 Mar 2012 14:31:58 +0100
Subject: [PATCH v5 3/4] clk: introduce the common clock framework
In-Reply-To: <1330763341-3437-4-git-send-email-mturquette@linaro.org>
References: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
 <1330763341-3437-4-git-send-email-mturquette@linaro.org>
Message-ID: <20120303133158.GA26882@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 12:29:00AM -0800, Mike Turquette wrote:
> The common clock framework defines a common struct clk useful across
> most platforms as well as an implementation of the clk api that drivers
> can use safely for managing clocks.
> 
> The net result is consolidation of many different struct clk definitions
> and platform-specific clock framework implementations.
> 
> This patch introduces the common struct clk, struct clk_ops and an
> implementation of the well-known clock api in include/clk/clk.h.
> Platforms may define their own hardware-specific clock structure and
> their own clock operation callbacks, so long as it wraps an instance of
> struct clk_hw.
> 
> See Documentation/clk.txt for more details.
> 
> This patch is based on the work of Jeremy Kerr, which in turn was based
> on the work of Ben Herrenschmidt.
> 
> +
> +/**
> + * struct clk_hw - handle for traversing from a struct clk to its corresponding
> + * hardware-specific structure.  struct clk_hw should be declared within struct
> + * clk_foo and then referenced by the struct clk instance that uses struct
> + * clk_foo's clk_ops
> + *
> + * clk: pointer to the struct clk instance that points back to this struct
> + * clk_hw instance
> + */
> +struct clk_hw {
> +	struct clk *clk;
> +};

The reason for doing this is that struct clk should be an opaque cookie
for both drivers and implementers of clocks. I recently had the idea whether
the roles of these two structs could be swapped. So instead of the above we
could do:

struct clk {
	struct clk_hw *hw;
}

The effect would be the same, but this version would make the struct clk
pointer known at compile time thus making it possible for static
initializers to specify their parent clock.

I just saw that clk_register now takes a parent name array, that may
make this change unnecessary anyway.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
