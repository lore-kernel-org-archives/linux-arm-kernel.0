From: fugang.duan@nxp.com (Andy Duan)
Date: Thu, 20 Oct 2016 12:29:44 +0000
Subject: Handling of enet_out on i.MX28
In-Reply-To: <20161020091126.jdoexu6iuu3jjzsm@pengutronix.de>
References: <20161020091126.jdoexu6iuu3jjzsm@pengutronix.de>
Message-ID: <AM4PR0401MB22607753FB012789493C9C2EFFD50@AM4PR0401MB2260.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> Sent: Thursday, October 20, 2016 5:11 PM
> To: Andy Duan <fugang.duan@nxp.com>; Fabio Estevam Estevam
> <fabio.estevam@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
> devicetree at vger.kernel.org
> Cc: kernel at pengutronix.de; linux-arm-kernel at lists.infradead.org
> Subject: Handling of enet_out on i.MX28
> 
> Hello,
> 
> The i.MX28 reference manual specifies for HW_CLKCTRL_ENET.CLK_OUT_EN:
> "NOTE: This bit must be configured before ENET PLL is enabled.".
> 
> Currently this is not implemented: ENET PLL (aka pll2) is the parent of
> enet_out and so common clk enables the PLL first and only then sets
> HW_CLKCTRL_ENET.CLK_OUT_EN.
> 
> For now this is a theoretical problem because I don't see any issues. I only
> notice the discrepancy between manual and reality.
> 
> Do you think this is a problem?
> 
I don't know the history. But I think this is a problem. Maybe it bring some clock glitch that may cause PHY (with RMII)  abnormal.

> Apart from that I'm not happy with the handling of this clk. IMHO it should
> better be called "enet-ref" or similar (for the fec). imx28.dtsi specifies that
> the clk is in use[1] and if my machine doesn't I have to
> do:
> 
> 	&mac0 {
> 		...
> 		/* overwrite clocks and clock-names to remove enet_out */
> 		clocks = <&clks 57>, <&clks 57>;
> 		clock-names = "ipg", "ahb";
> 		...
> 	};
> 
> in my board.dts. This is ugly because I have to repeat stuff that is already in
> imx28.dtsi and it's not understandable without the comment.
> 
> It would be nice if dtc allowed to modify an array, then we could do:
> 
> 	clocks += <&clks 64>;
> 	clock-names = += "enet_out";
> 
> (assuming the included dtsi doesn't specify this clock).
> 
> I first though it would be a good idea to specify the enet-ref clk as
> follows:
> 
> 	&mac0 {
> 		...
> 		mdio {
> 			clocks = <&clks 64>;
> 			clock-names = "enet-ref";
> 			...
> 		};
> 	};
>
In RMII mode,  this clock is for phy and MAC reference clock.
It is better to specify this clock as "enet_clk_ref" and "enet_out" that is easy to understand.
In dtsi file, we can just define ipg and ahb clock.
clocks = <&clks 57>, <&clks 57>;
clock-names = "ipg","ahb";
In dts file, different boards may have design mode like RMII/MII, RMII mode needs to define enet_out and enet_clk_ref,  MII mode doesn't need this clocks.
So it depends on board design, we can overwrite the clock in dts board file.   
Like in RMII mode: 
clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 64>;
clock-names = "ipg","ahb", "enet_clk_ref","enet_out";
In MII mode: no necessary to overwrite them. 

> but while this makes it easier for the board.dts to add (or remove) it, it's not
> really right this way because the reference clock is needed for data RX and TX,
> not the mdio bus. Technically these are two different buses even though the
> "passengers" are often the same. (Even if two MACs are in use, the enet-ref
> signal is shared.)
> 
> What do you think?
> 
> Best regards
> Uwe
> 
> [1] clocks = <&clks 57>, <&clks 57>, <&clks 64>; clock-names = "ipg",
>     "ahb", "enet_out"; in &mac0.
> 
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
