From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 1 Dec 2016 01:43:03 +0000
Subject: [alsa-devel] [PATCH v2] clkdev: add devm_of_clk_get()
In-Reply-To: <874m2pbwsn.wl%kuninori.morimoto.gx@renesas.com>
References: <87ziptixv7.wl%kuninori.morimoto.gx@renesas.com>
 <20160707122636.GP1041@n2100.armlinux.org.uk>
 <8760shgfzu.wl%kuninori.morimoto.gx@renesas.com>
 <146794140875.73491.7115209079607438738@resonance>
 <871t34hlin.wl%kuninori.morimoto.gx@renesas.com>
 <878twndi54.wl%kuninori.morimoto.gx@renesas.com>
 <8737isvwc6.wl%kuninori.morimoto.gx@renesas.com>
 <20161123191037.GE25626@codeaurora.org>
 <87a8cpejn5.wl%kuninori.morimoto.gx@renesas.com>
 <87y409cw71.wl%kuninori.morimoto.gx@renesas.com>
 <20161129210556.GC6095@codeaurora.org>
 <874m2pbwsn.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87oa0w77dw.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stephen, again

Can I confirm ??
Was I misunderstanding ??

> I understand your point, but I think devm_get_clk_from_child()
> needs new DT setings, and it can't keep compatibility, or
> it makes driver complex.
> I think it is nice to have. but, I want to keep current style.
> Thus, I will try to use current of_clk_get() as-is, and
> call clk_free() somehow in this driver.

	------ Pattern1 -----------
	sound_soc {
		clocks = <&xxx>, <&xxx>;
		clock-names = "cpu", "codec";
		...
		cpu { /* of_cpu_node */
			...
		};
		codec { /* of_codec_node */
			...
		};
	};
	----------------------------

Do you mean, this case we can use

	devm_get_clk_from_child(dev, of_cpu_node,   "cpu");
	devm_get_clk_from_child(dev, of_codec_node, "codec");

	------ Pattern2 -----------
	sound_soc {
		...
		cpu { /* of_cpu_node */
			clocks = <&xxx>;
			...
		};
		codec { /* of_codec_node */
			clocks = <&xxx>;
			...
		};
	};
	----------------------------

And, this case, we can use

	devm_get_clk_from_child(dev, of_cpu_node,   NULL);
	devm_get_clk_from_child(dev, of_codec_node, NULL);

If so, I can use it without DT change.
