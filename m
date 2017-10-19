From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 19 Oct 2017 13:26:06 +0200
Subject: [RFC resend] arm64: mt8173: Fix Acer Chromebooks mmsys probe problem
Message-ID: <20171019112610.13645-1-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In theory the MMSYS device tree identifier is matches twice, by the clk driver 
and the DRM subsystem. But the kernel only matches the first driver for a 
device (clk) and discards the second one. This breaks graphics on mt8173 and 
most probably on mt2701 as well.

MMSYS in Mediatek SoCs has some registers to control clock gates (which is 
used in the clk driver) and some registers to enable the differnet blocks of 
the display subsystem. The kernel uses the binding to load the central 
comoponent of the distplay subsystem, which in place probes all the other 
components and enables the present ones in the MMSYS.

We found us with the problem, that we need to change and therefor break one 
of the two bindings, or the DRM one or the clock driver one.

Apart from that the DRM subysystem does access the MMSYS registers via relaxed 
reads/writes. But the it should to so via regmap, as the registers are shared.

Possible solutions:
1) We add a new mediatek,mt8173-mmsys-clk node, which lives as a simple-mfd 
under the actual mmsys node. We change the clock driver to probe on this 
binding. This would make sense as the clock gate register live completly in 
the MMSYS configuration registers.

2) As the nodes of the DRM subsystem just need some of the registers of MMSYS 
we add a new binding mediatek,mt8173-dispsys which probes the central 
component of the DRM system. It has only a handle to mt8173-mmsys to access 
the registerspace via regmap functions.

In this patchset I implemented 2). Please take into account, that this is a 
RFC. I had no time to actually test the verison on real HW. Some of the 
register accesses should be done using regmap_update instead of 
regmap_read + regmap_write.

This RFC shall only show how solution 2) would look like. We can use it as 
discussion to see how we circumvent the actual situation.
