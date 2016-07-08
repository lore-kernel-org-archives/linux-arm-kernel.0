From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 8 Jul 2016 00:03:00 +0000
Subject: [PATCH v2] clkdev: add devm_of_clk_get()
In-Reply-To: <20160707122636.GP1041@n2100.armlinux.org.uk>
References: <87wpl2yyuw.wl%kuninori.morimoto.gx@renesas.com>
 <146785219147.73491.2827268663638530377@resonance>
 <87ziptixv7.wl%kuninori.morimoto.gx@renesas.com>
 <20160707122636.GP1041@n2100.armlinux.org.uk>
Message-ID: <8760shgfzu.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Russell

> > > > +struct clk *devm_of_clk_get(struct device *dev,
> > > > +                           struct device_node *np, int index)
> > > 
> > > Any reason not to use devm_clk_get? Why do we need this helper?
> > 
> > Because of_clk_get() can parse "clocks", "#clock-cells" on DT.
> 
> clk_get() should also work just fine.  clk_get() uses
> __of_clk_get_by_name() internally, which uses "clock-names" to
> locate the index if a connection id is given.  of_clk_get() allows
> lookup of a clock by index only, omitting the name, which means
> you need to coordinate the order of clocks in DT with the order
> that the driver wants... which sounds error prone to me.

Thanks.

But, I have 1 issue on [devm_]clk_get().
It can't select device_node on [devm_]clk_get(), it uses dev->of_node directly.

struct clk *clk_get(struct device *dev, const char *con_id)
{
	...
	if (dev) {
		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
		                           ~~~~~~~~~~~~
		...
	}
}

I would like to select specific device_node.

	sound_soc {
		...
		cpu {
			...
=>			clocks = <&xxx>;
		};

		codec {
			...
=>			clocks = <&xxx>;
		};
	};

But, of_clk_get_by_name() / of_clk_get() doesn't have devm_xxx version
