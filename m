From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 28 Jun 2017 12:49:10 +0200
Subject: [PATCH 4/4] arm64: dts: add RK3399-Q7 (Puma) SoM
In-Reply-To: <3F2C0996-F298-4628-BCF3-DE721F3B818D@theobroma-systems.com>
References: <20170626191854.58253-1-klaus.goger@theobroma-systems.com>
 <2336478.rsaXP0O2Er@diego>
 <3F2C0996-F298-4628-BCF3-DE721F3B818D@theobroma-systems.com>
Message-ID: <3683842.NarJoYnXid@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 28. Juni 2017, 12:40:01 CEST schrieb Dr. Philipp Tomsich:
> 
> > On 28 Jun 2017, at 12:26, Heiko St?bner <heiko@sntech.de> wrote:
> > 
> > Hi Klaus,
> > 
> > [added Kever from Rockchip concerning the cluster1-opps below]
> > 
> > 
> > Am Montag, 26. Juni 2017, 21:18:54 CEST schrieb Klaus Goger:
> >> The RK3399-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
> >> connector) system-on-module from Theobroma Systems, featuring the
> >> Rockchip RK3399.
> >> 
> >> It provides the following feature set:
> >> * up to 4GB DDR3
> >> * on-module SPI-NOR flash
> >> * on-module eMMC (with 8-bit 1.8V interface)
> >> * SD card (on a baseboad) via edge connector
> >> * Gigabit Ethernet with on-module Micrel KSZ9031 GbE PHY
> >> * HDMI/eDP/2x MIPI-DSI
> >> * 2x MIPI-CSI
> >> * USB
> >>   - 1x USB 3.0 dual-role (direct connection)
> >>   - 2x USB 3.0 host + 1x USB 2.0 (on-module USB 3.0 hub)
> >> * on-module STM32 Cortex-M0 companion controller, implementing:
> >>   - low-power RTC functionality (ISL1208 emulation)
> >>   - fan controller (AMC6821 emulation)
> >>   - USB<->CAN bridge controller
> >> 
> >> Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
> >> 
> >> ---
> > 
> > [...]
> > 
> >> +	leds {
> >> +		compatible = "gpio-leds";
> >> +		pinctrl-names = "default";
> >> +
> >> +		module_led {
> > 
> > phandles use underscores, node names are supposed to use dashes "-"
> > 
> >> +			label = "module_led";
> >> +			gpios = <&gpio2 RK_PD1 GPIO_ACTIVE_HIGH>;
> >> +			linux,default-trigger = "heartbeat";
> >> +			panic-indicator;
> >> +		};
> >> +
> >> +		sd_card_led {
> >> +			label = "sd_card_led";
> >> +			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
> >> +			linux,default-trigger = "mmc0";
> >> +		};
> >> +	};
> >> +
> >> +	cluster1_opp: opp-table1 {
> >> +		compatible = "operating-points-v2";
> >> +		opp-shared;
> >> +
> >> +		opp00 {
> >> +			opp-hz = /bits/ 64 <408000000>;
> >> +			opp-microvolt = <800000>;
> >> +			clock-latency-ns = <40000>;
> >> +		};
> >> +		opp01 {
> >> +			opp-hz = /bits/ 64 <600000000>;
> >> +			opp-microvolt = <800000>;
> >> +		};
> >> +		opp02 {
> >> +			opp-hz = /bits/ 64 <816000000>;
> >> +			opp-microvolt = <830000>;
> > 
> > this is 5mV higher than the "official" OPPs used by Rockchip, so
> > I'd like to know its background :-) . Especially as I really would like
> > to keep the number of per-board OPPs minimal.
> 
> The on-board regulators differ and can?t hit the voltages specified
> in the original OPP table? this is the next closest value we can
> set and is at least what Rockchip uses in the ref-design.
> 
> > So does this make the board run more stable or something else?
> > And might this be applicable for all "standard" rk3399 boards?
> > Especially as other OPPs in your list use the regular voltages.
> 
> It avoids ugly issues with OPPs being deactivated due to the the
> exact voltage used in the ?official? OPPs not being supported by
> our regulator.
> 
> We decided against reusing the original OPP table and modifying it
> (to use ranges) as that was likely to cause even more harm in the
> long term.

ok, thanks for that explanation, which also satisfies my reservations :-) .

When fixing the other things, please also add a comment above opp-table
with the above explanation, so future changers don't need to remember
this mail thread :-) .

Also, you might want to add something like

/delete-node/ opp-table1;

before defining your new opp table to prevent the subnode changes
from interfering with your new table.


> >> +			opp-suspend;
> >> +		};
> >> +		opp03 {
> >> +			opp-hz = /bits/ 64 <1008000000>;
> >> +			opp-microvolt = <880000>;
> > 
> > same as above
> > 
> >> +		};
> >> +		opp04 {
> >> +			opp-hz = /bits/ 64 <1200000000>;
> >> +			opp-microvolt = <950000>;
> >> +		};
> >> +		opp05 {
> >> +			opp-hz = /bits/ 64 <1416000000>;
> >> +			opp-microvolt = <1030000>;
> > 
> > same as above
> > 
> >> +		};
> >> +		opp06 {
> >> +			opp-hz = /bits/ 64 <1608000000>;
> >> +			opp-microvolt = <1100000>;
> >> +		};
> >> +		opp07 {
> >> +			opp-hz = /bits/ 64 <1800000000>;
> >> +			opp-microvolt = <1200000>;
> >> +		};
> >> +		opp08 {
> >> +			opp-hz = /bits/ 64 <1992000000>;
> >> +			opp-microvolt = <1230000>;
> >> +			turbo-mode;
> > 
> > Is this part of the soc-spec or more like wishful thinking? :-)
> > Again with the question in mind if this applies to all rk3399.
> 
> Tested in our lab on a decent population of boards using various
> forms of stress-testing (incl. a 6-way and 8-way SPEC).
> 
> This one is marked ?turbo-mode? as we do recommend to only
> enable it if a (Qseven-style) heat-sink is mounted.

ok then.


Heiko
