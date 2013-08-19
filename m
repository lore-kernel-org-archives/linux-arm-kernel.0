From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 18 Aug 2013 22:35:30 -0300
Subject: [PATCH v4 5/6] clocksource: armada-370-xp: Fix device-tree binding
In-Reply-To: <521159BE.1020206@gmail.com>
References: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130815162751.GA2403@localhost> <520EB5BC.4060102@wwwdotorg.org>
 <1982398.OuHBuuDmYS@flatron> <520F6CA8.1090401@gmail.com>
 <20130817164319.GA2772@localhost> <521159BE.1020206@gmail.com>
Message-ID: <20130819013529.GA2300@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 01:33:18AM +0200, Sebastian Hesselbarth wrote:
> On 08/17/2013 06:43 PM, Ezequiel Garcia wrote:
> > On Sat, Aug 17, 2013 at 02:29:28PM +0200, Sebastian Hesselbarth wrote:
> >
> > In fact: I'm not sure. I'm slightly inclined towards considering both
> > clocks as clock sources, just as Stephen and Tomasz are proposing.
> >
> >> But in the end, passing it by DT should be the way to go. I cannot look
> >> into the XP datasheet, but I would guess that the exact feature of the
> >> ip is not to use _the_ fixed 25MHz clock but XTAL as reference. Maybe
> >> one of the free-electrons guys can look it up?
> >>
> >
> > No, the documentation has a register bit for "25Mhz frequency enable",
> > for each timer/watchdog.
> >
> > ---
> >
> > Anyway, I (almost) agree that the 25Mhz fixed clock must be somehow represented
> > in the device-tree, but I'm not exactly sure how. Gregory: maybe you can help
> > in this?
> >
> 
> In armada-370-xp.dtsi add a 25MHz ref clock node and modify timer node
> to reference it:
> 
> cpus { ... };
> 
> clocks {
> 	ref25M: timer-clock {
> 		compatible = "fixed-clock";
> 		clock-frequency = <25000000>;
> 	};
> }
> 
> ...
> 
> internal-regs {
> 	timer at 20300 {
> 		compatible = "marvell,armada-370-xp-timer";
> 		reg = <0x20300 0x30>, <0x21040 0x30>;
> 		interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
> 		clocks = <&coreclk 2>, <&ref25M>;
> 		clock-names = "fabric", "fixed";
> 	};
> };
> 
> Then use of_clk_get_by_name(np, "fabric") and of_clk_get_by_name(np,
> "fixed") respectively. Clock select strategy should be, (a) fail if
> no clock, (b) use fabric/fixed if just one clock, (c) use fixed if
> both clocks.
> 
> Does that answer your questions? :)
> 

Indeed this looks nice :-)

However, I still have a few concerns. I thought we would describe the
clock selection in the DT. With the above we return to the single
compatible string "armada-370-xp-timer" for both SoCs.

I'm not entirely convinced. Isn't it better to distinguish them?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
