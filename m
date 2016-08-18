From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Aug 2016 10:04:37 +0100
Subject: [PATCH v3 1/4] ARM: davinci: da8xx-dt: Add ti-aemif lookup for
 clock matching
In-Reply-To: <20160818073319.GA18481@gobelin>
References: <20160816223338.20776-1-kbeldan@baylibre.com>
 <20160816223338.20776-2-kbeldan@baylibre.com>
 <9e47844e-413b-4f85-5fbc-6b73cdd7fade@ti.com>
 <20160818073319.GA18481@gobelin>
Message-ID: <20160818090437.GR1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 07:33:19AM +0000, Karl Beldan wrote:
> Checking clk_get:
> 
> struct clk *clk_get(struct device *dev, const char *con_id)
> {       
> 	[...]
> 	if (dev) {
> 		struct clk *__of_clk_get_by_name(struct device_node *np,
> 						 const char *dev_id,
> 						 const char *name)
> 		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
> 		[...]
> 	}
> 	return clk_get_sys(dev_id, con_id);
> }
> 
> In DT case the con_id _is_ the clock name, so the assertion "clk_get()
> does not look up a clock by name" would be false ?

Wrong.

	clocks = <&provider 0>, <&provider 1>;
	clock-names = "fck", "ick";

	fck = clk_get(dev, "fck");

	ick = clk_get(dev, "ick");

Works just the same.  The whole point of the string is to identify an
_individual_ _input_ _to_ _the_ _device_ and not a global clock name.

Think what happens if you specify a clock name.  Where does that name
come from?  What if the clock is named differently on another SoC?
With that approach, we need to define a new set of APIs to allow a
device to determine the global clock name for the clock that it's
interested in - which is completely absurd when we've already got
that within clk_get().

The whole point of the clk API is to abstract those differences.  That's
why it takes a _connection_ _id_ and not a clock name.

I really can't understand why people keep getting this wrong in their
heads.  It makes no sense to me for this to take a global clock name.

> Also, numerous commits refer to *clk_get(*, NULL) as getting an unnamed
> clock, although it only really is accurate to the point in DT cases.

Table-driven clkdev copes fine with that, and will try to locate an
appropriate table entry with a NULL connection ID, not matching any
non-NULL connection ID entry.

In the DT case, it's always the first specified clock.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
