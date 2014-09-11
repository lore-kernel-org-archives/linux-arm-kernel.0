From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 Sep 2014 00:04:45 +0200
Subject: [PATCH] clk: don't use __initconst for non-const arrays
In-Reply-To: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140911220445.GQ3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Sep 11, 2014 at 11:04:31PM +0200, Uwe Kleine-K?nig wrote:
>  /* Mux parent lists. */
> -static const char *fin_pll_p[] __initconst = {
> +static const char *fin_pll_p[] __initdata = {
>  	"xxti",
>  	"xusbxti"
>  };
As discussed with Tomasz on irc: The sad thing here is that for this
array only 8 bytes are freed when .init.rodata is thrown away (that is
two pointers). The actual data---5 + 8 bytes + maybe aligning---isn't
freed though.

We wondered if there is a nice and easy way to throw away the
characters, too.

The only way I currently see is:

	const char xxti[] __initconst = "xxti";
	...

	static const char *fin_pll_p[] __initdata = {
		xxti,
		...
	};

but this definitively doesn't qualify as "nice and easy". Is there an
alternative?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
