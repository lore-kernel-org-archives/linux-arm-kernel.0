From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 14 Oct 2009 11:09:15 +0100
Subject: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare
	I2C clock source
In-Reply-To: <4AD5514B.4090504@necel.com>
References: <4AD3E974.8080200@necel.com> <4AD3EB09.8050304@necel.com>
	<20091013224123.GB13398@fluff.org.uk> <4AD5514B.4090504@necel.com>
Message-ID: <20091014100915.GA24540@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2009 at 01:19:23PM +0900, Shinya Kuribayashi wrote:

> * And clk_get() is expected to pick up a clock source with:

> 1) dev_id + clk_id ... strict matching condition (default)
> 2) dev_id only ... fuzzy extension1 (clk_id can be regarded as wildcard)
> 3) clk_id only ... fuzzy extension2 (dev_id can be regarded as wildcard)

>  2) and 3) might be sort of ARM's clkdev extensions
>  (I think it's useful), but that's not my point.
>  I'll leave that alone for now.

Part of the reason I was querying this is that you were using the clock
name "dw_i2c_clk" which looks like a globally namespaced name which
would be used with option 3 above.  Several clock frameworks just
completely ignore dev_id which creates a lot of problems down the line.
If it had just been i2c_clk I'd have been less likely to follow up.

Option 3 has never been the intended use of the clock API and is
basically a bug in any clock implementation that requires it for most
drivers but it does need to be used in a few limited cases where the
relevant kernel subsystem doesn't provide a struct device (cpufreq is
the major offender here).

> * From the point of drivers, we're never interested in clk_get()
>  implementation, and which matching pattern 1) - 3) is taken.

>  Supplying only "dev_id" could be regarded as misuse of clk_get(),

As far as I can tell from what rmk is saying it seems that the use of a
NULL string is actually an intended usage for devices where the clocks
aren't otherwise named.  I had the concerns when I first saw this usage
but it does seem to be an expected and intended use.

> and will increase dependence on clk framework implementation.

To a certain extent this is good in that it applies pressure to improve
the clock API implementations concerned.
