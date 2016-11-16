From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 16 Nov 2016 05:17:11 +0000
Subject: [alsa-devel] [PATCH v2] clkdev: add devm_of_clk_get()
In-Reply-To: <878twndi54.wl%kuninori.morimoto.gx@renesas.com>
References: <87wpl2yyuw.wl%kuninori.morimoto.gx@renesas.com>
 <146785219147.73491.2827268663638530377@resonance>
 <87ziptixv7.wl%kuninori.morimoto.gx@renesas.com>
 <20160707122636.GP1041@n2100.armlinux.org.uk>
 <8760shgfzu.wl%kuninori.morimoto.gx@renesas.com>
 <146794140875.73491.7115209079607438738@resonance>
 <871t34hlin.wl%kuninori.morimoto.gx@renesas.com>
 <878twndi54.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <8737isvwc6.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Rob, Michael, Russell


What is the conclusion of this patch ?
We shouldn't add devm_of_clk_get() ? or can I continue ?

The problem of current [devm_]clk_get() handles *dev only,
but I need to get clocks from DT node, not dev

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

> > Thank you for your feedback
> > 
> > > > struct clk *clk_get(struct device *dev, const char *con_id)
> > > > {
> > > >         ...
> > > >         if (dev) {
> > > >                 clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
> > > >                                            ~~~~~~~~~~~~
> > > >                 ...
> > > >         }
> > > > }
> > > > 
> > > > I would like to select specific device_node.
> > > 
> > > Do you have access to the struct device that you want to target? Can you
> > > pass that device into either clk_get or devm_clk_get?
> > 
> > If my understanding was correct, I think I can't.
> > In below case, "sound_soc" has its *dev, but "cpu" and "codec" doesn't
> > have *dev, it has node only. Thus, we are using of_clk_get() for these now.
> > 
> > 	clk = of_clk_get(cpu, xxx);
> > 	clk = of_clk_get(codec, xxx);
> > 
> > 	sound_soc {
> > 		...
> > 		cpu {
> > 			...
> > =>			clocks = <&xxx>;
> > 		};
> > 		codec {
> > 			...
> > =>			clocks = <&xxx>;
> > 		};
> > 	};


Best regards
---
Kuninori Morimoto
