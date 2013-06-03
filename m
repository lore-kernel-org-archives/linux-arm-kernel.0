From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Jun 2013 11:22:35 +0200
Subject: [PATCH 10/10] arm: add basic support for Rockchip RK3066a boards
In-Reply-To: <201306031023.49364.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de> <5760087.7O4UgypAot@wuerfel>
 <201306031023.49364.heiko@sntech.de>
Message-ID: <9452845.qTGjLPCfXq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013 10:23:49 Heiko St?bner wrote:
> Am Montag, 3. Juni 2013, 04:15:46 schrieb Arnd Bergmann:
> > 
> > Can't you use
> > 
> > 	of_clk_init(NULL);
> > 	clocksource_of_init();
> > 
> > here and change the two drivers to provide the respective macros?
> 
> hmm, while this would make a lot of things easier I don't see right now how 
> this would work.
> 
> The dw_apb_timer clocksource does not have its own device node, but instead 
> uses two timer devices as clocksource and clockevent.
> 
> Hmm ... one idea would be to wrap them in the dt, like
> 
> 	clocksource {
> 		compatible = "snps,dw-apb-clocksource"
> 
> 		timer at 2003a000 {
> 			compatible = "snps,dw-apb-timer-osc";
> 			reg = <0x2003a000 0x100>;
> 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> 			clocks = <&clk_gates1 1>, <&clk_gates7 8>;
> 			clock-names = "timer", "pclk";
> 		};
> 
> 		timer at 2000e000 {
> 			compatible = "snps,dw-apb-timer-osc";
> 			reg = <0x2000e000 0x100>;
> 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> 			clocks = <&clk_gates1 2>, <&clk_gates7 9>;
> 			clock-names = "timer", "pclk";
> 		};
> 	};

Can't you just have multiple CLOCKSOURCE_OF_DECLARE() lines, one
for each of the nodes?
 
> > > +DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
> > > +       .map_io         = debug_ll_io_init,
> > > +       .init_machine   = rockchip_dt_init,
> > > +       .init_time      = rockchip_timer_init,
> > > +       .dt_compat      = rockchip_board_dt_compat,
> > > +MACHINE_END
> > 
> > The map_io line can already get removed.
> 
> Yesterday I did grep thru the linux-next I was using as base looking for the 
> debug_ll_io_init default I read about but was not able to find it ... most 
> likely my linux-next is a tad to old.

Yes, it only showed up in today's linux-next. I thought it was older.

	Arnd
