From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 19 Aug 2013 13:39:49 -0300
Subject: [PATCH v4 5/6] clocksource: armada-370-xp: Fix device-tree binding
In-Reply-To: <1459049.v9II6MKhh6@flatron>
References: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130817164319.GA2772@localhost> <521159BE.1020206@gmail.com>
 <1459049.v9II6MKhh6@flatron>
Message-ID: <20130819163948.GA22511@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 01:01:12AM +0200, Tomasz Figa wrote:
> On Monday 19 of August 2013 01:33:18 Sebastian Hesselbarth wrote:
> > On 08/17/2013 06:43 PM, Ezequiel Garcia wrote:
> > > On Sat, Aug 17, 2013 at 02:29:28PM +0200, Sebastian Hesselbarth wrote:
> > > 
> > > In fact: I'm not sure. I'm slightly inclined towards considering both
> > > clocks as clock sources, just as Stephen and Tomasz are proposing.
> > > 
> > >> But in the end, passing it by DT should be the way to go. I cannot
> > >> look
> > >> into the XP datasheet, but I would guess that the exact feature of
> > >> the
> > >> ip is not to use _the_ fixed 25MHz clock but XTAL as reference. Maybe
> > >> one of the free-electrons guys can look it up?
> > > 
> > > No, the documentation has a register bit for "25Mhz frequency enable",
> > > for each timer/watchdog.
> > > 
> > > ---
> > > 
> > > Anyway, I (almost) agree that the 25Mhz fixed clock must be somehow
> > > represented in the device-tree, but I'm not exactly sure how.
> > > Gregory: maybe you can help in this?
> > 
> > In armada-370-xp.dtsi add a 25MHz ref clock node and modify timer node
> > to reference it:
> > 
> > cpus { ... };
> > 
> > clocks {
> > 	ref25M: timer-clock {
> > 		compatible = "fixed-clock";
> > 		clock-frequency = <25000000>;
> > 	};
> > }
> > 
> > ...
> > 
> > internal-regs {
> > 	timer at 20300 {
> > 		compatible = "marvell,armada-370-xp-timer";
> > 		reg = <0x20300 0x30>, <0x21040 0x30>;
> > 		interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
> > 		clocks = <&coreclk 2>, <&ref25M>;
> > 		clock-names = "fabric", "fixed";
> 
> These names look more like SoC-level clock names, not clock input names of 
> the IP. Are they referenced by such names in documentation?
> 

The L2/Coherency fabric clock is called "nbclk" both in marvell's documentation
and in Documentation/device-tree/binding/clock/mvebu-core-clock.txt.

The 25 MHz clock is (very scarcely) called "refclk".

> > 	};
> > };
> > 
> > Then use of_clk_get_by_name(np, "fabric") and of_clk_get_by_name(np,
> > "fixed") respectively. Clock select strategy should be, (a) fail if
> > no clock, (b) use fabric/fixed if just one clock, (c) use fixed if
> > both clocks.
> 
> This basically sounds good, except those names.
> 

Okey, I've just sent a new patchset, on top of the previous (already
applied) work.

Feel free to comment on that.

Sebastian: Thanks a lot for suggesting this!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
