From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Jul 2013 21:33:24 +0100
Subject: [PATCH v2 18/24] i2c: mpc: OF clock lookup for MPC512x
In-Reply-To: <1374178858-8683-4-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374178858-8683-4-git-send-email-gsi@denx.de>
Message-ID: <20130718203324.GB24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 10:20:52PM +0200, Gerhard Sittig wrote:
> +	/* enable clock for the I2C peripheral (non fatal) */
> +	clk = of_clk_get_by_name(node, "per");
> +	if (!IS_ERR(clk)) {
> +		clk_prepare_enable(clk);
> +		clk_put(clk);
> +	}
> +

This kind of hacked up approach to the clk API is exactly the thing I
really don't like seeing.  I don't know what it is... is the clk API
somehow difficult to use or what's the problem with doing stuff correctly?

1. Get the clock in your probe function.
2. Prepare it at the appropriate time.
3. Enable it appropriately.  (or if you want to combine 2 and 3, use
   clk_prepare_enable().)
4. Ensure that enables/disables and prepares/unprepares are appropriately
   balanced.
5. 'put' the clock in your remove function.

Certainly do not get-enable-put a clock.  You're supposed to hold on to
the clock all the time that you're actually using it.

Final point - if you want to make it non-fatal, don't play games like:

	clk = clk_get(whatever);
	if (IS_ERR(clk))
		clk = NULL;

	...
	if (clk)
		clk_prepare(clk);

Do this instead:

	clk = clk_get(whatever);
	...

	if (!IS_ERR(clk))
		clk_prepare(clk);
etc.

(And on this subject, I'm considering whether to make a change to the
clk API where clk_prepare() and clk_enable() return zero when passed
an error pointer - this means drivers with optional clocks don't have
to burden themselves with these kinds of checks.)
