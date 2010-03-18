From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Mar 2010 09:37:28 +0100
Subject: [PATCH 1/2] [ARM] [IMX]: Removed superfluous checks for
	argument validity.
In-Reply-To: <acc484891003170334p133ee328y2d1b17533b672ac5@mail.gmail.com>
References: <1268809916-6525-1-git-send-email-vzapolskiy@gmail.com>
	<20100317091349.GA16150@pengutronix.de>
	<acc484891003170334p133ee328y2d1b17533b672ac5@mail.gmail.com>
Message-ID: <20100318083728.GB1369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 01:34:50PM +0300, Vladimir Zapolskiy wrote:
> Hello Uwe,
> 
> __clk_enable() and __clk_disable() are recursive with another arguments,
> that means it is hardly possible to remove the checks from them.
ah, at least the check for NULL cannot go away.  However IS_ERR(clk)
should hardly matter, shouldn't it?

Maybe the generated code is more optimal when doing:

	static void __clk_disable(struct clk *clk)
	{
		WARN_ON(!clk->usecount);

		if (clk->parent)
			__clk_disable(clk->parent);

		if (clk->secondary)
			__clk_disable(clk->secondary);

		if (!(--clk->usecount) && clk->disable)
			clk->disable(clk);
	}

	void clk_disable(struct clk *clk)
	{
		BUG_ON(clk == NULL || IS_ERR(clk));
		mutex_lock(&clocks_mutex);
		__clk_disable(clk);
		mutex_unlock(&clocks_mutex);
	}
 
So unless the compiler optimizes well, this reduces the calls of
__clk_disable from three to one for a clock without parent and
secondary.

While at it I wonder if it isn't more correct in __clk_disable to
disable the clock first and only then parent and secondary?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
