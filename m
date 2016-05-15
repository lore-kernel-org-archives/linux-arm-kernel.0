From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 15 May 2016 09:07:48 +0300
Subject: [PATCH 3/3] ARM: dts: clps711x: Add basic Cirrus Logic CDB89712
 Development board
In-Reply-To: <6057172.X40sTfvRlk@wuerfel>
References: <1463138788-5390-1-git-send-email-shc_work@mail.ru>
 <9407200.bOeiVUkGKT@wuerfel> <1463142623.38124260@f381.i.mail.ru>
 <6057172.X40sTfvRlk@wuerfel>
Message-ID: <20160515090748.05db9e6cdff743f26bd6c1fb@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 May 2016 15:41:11 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 13 May 2016 15:30:23 Alexander Shiyan wrote:
> > Hello.
> > 
> > > ???????, 13 ??? 2016, 15:00 +03:00 ?? Arnd Bergmann <arnd@arndb.de>:
> > > 
> > > On Friday 13 May 2016 14:26:28 Alexander Shiyan wrote:
> > ...
...
> > > > +		clks: clks at 80000000 {
> > > > +			#clock-cells = <1>;
> > > > +			compatible = "cirrus,clps711x-clk";
> > > > +			reg = <0x80000000 0xc000>;
> > > > +			startup-frequency = <73728000>;
> > > > +		};
> > ...
> > > > +		intc: intc at 80000000 {
> > > > +			compatible = "cirrus,clps711x-intc";
> > > > +			reg = <0x80000000 0x4000>;
> > > > +			interrupt-controller;
> > > > +			#interrupt-cells = <1>;
> > > > +		};
> > > 
> > > Better make the register ranges non-overlapping. This appears
> > > to start at the same place as the 'clks' node.
> > 
> > CLK driver uses:
> > #define CLPS711X_SYSCON1 (0x0100)
> > #define CLPS711X_SYSCON2 (0x1100)
> > ...
> > #define CLPS711X_PLLR (0xa5a8)
> > 
> > IRQCHIP driver uses:
> > #define CLPS711X_INTSR1 (0x0240)
> > ...
> > #define CLPS711X_INTSR2 (0x1240)
> > ...
> > #define CLPS711X_INTMR3 (0x2280)
> > 
> > So there is no way to do any else.
> 
> It sounds like what you have is a large system controller that
> has registers everywhere. Could you use syscon to access the
> individual registers instead?

There are several problems:
- The syscon driver must be initialized before any other devices,
  including the interrupt controller and clk/clocksource subsystems.
- A slight performance impact will be observed in the interrupt handler.
- SYSCON (regmap) is designed to use with equal the width of registers,
  while we need to use different widths (8/16/32) for some subsystems.

-- 
Alexander Shiyan <shc_work@mail.ru>
