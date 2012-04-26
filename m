From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Apr 2012 10:39:24 +0200
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
Message-ID: <20120426083924.GE17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 10:58:56PM -0700, Saravana Kannan wrote:
> Create a struct clk_init_data to hold all data that needs to be passed from
> the platfrom specific driver to the common clock framework during clock
> registration. Add a pointer to this struct inside clk_hw.
> 
> This has several advantages:
> * Completely hides struct clk from many clock platform drivers and static
>   clock initialization code that don't care for static initialization of
>   the struct clks.
> * For platforms that want to do complete static initialization, it removed
>   the need to directly mess with the struct clk's fields while still
>   allowing to statically allocate struct clk. This keeps the code more
>   future proof even if they include clk-private.h.
> * Simplifies the generic clk_register() function and allows adding optional
>   fields in the future without modifying the function signature.
> * Simplifies the static initialization of clocks on all platforms by
>   removing the need for forward delcarations or convoluted macros.

Can we please stop messing with the function prototypes? So you prefer
passing a struct to clk_register which is fine and yes, it may have
advantages. But do we really need to change the prototype? Why can't we
just add a new function?

I am generally open to do these changes, but we have come to the point
where people actually want to *use* the clock framework instead of
rebasing their stuff onto the latest patches.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
