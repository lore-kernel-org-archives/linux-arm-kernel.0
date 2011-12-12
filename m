From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2011 13:46:15 +0000
Subject: [PATCH 3/4] ARM: smp_twd: get the rate from a clock
In-Reply-To: <1323683847-23902-1-git-send-email-linus.walleij@stericsson.com>
References: <1323683847-23902-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20111212134614.GU14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 10:57:27AM +0100, Linus Walleij wrote:
> +static struct clk *twd_get_clock(void)
> +{
> +	struct clk *clk;
> +	int err;
> +
> +	clk = clk_get_sys("smp_twd", NULL);
> +	if (IS_ERR(clk)) {
> +		pr_err("smp_twd: clock not found: %d\n", (int)PTR_ERR(clk));
> +		return clk;
> +	}
> +
> +	err = clk_enable(clk);
> +	if (err) {
> +		pr_err("smp_twd: clock failed to enable: %d\n", err);
> +		clk_put(clk);
> +		return ERR_PTR(err);
> +	}

NAK.  No clk_prepare().
