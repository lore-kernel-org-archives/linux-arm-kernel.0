From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 13 May 2016 15:30:23 +0300
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAzLzNdIEFSTTogZHRzOiBjbHBzNzExeDogQWRkIGJhc2lj?=
 =?UTF-8?B?IENpcnJ1cyBMb2dpYyBDREI4OTcxMiBEZXZlbG9wbWVudCBib2FyZA==?=
In-Reply-To: <9407200.bOeiVUkGKT@wuerfel>
References: <1463138788-5390-1-git-send-email-shc_work@mail.ru>
 <1463138788-5390-4-git-send-email-shc_work@mail.ru>
 <9407200.bOeiVUkGKT@wuerfel>
Message-ID: <1463142623.38124260@f381.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> ???????, 13 ??? 2016, 15:00 +03:00 ?? Arnd Bergmann <arnd@arndb.de>:
> 
> On Friday 13 May 2016 14:26:28 Alexander Shiyan wrote:
...
> > +	soc {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "simple-bus";
> > +		interrupt-parent = <&intc>;
> > +		ranges;
> 
> All child devices seem to be in the 0x80000000-0x90000000
> range, maybe set the ranges property accordingly?

I do not quite understand that you want to change here.

> 
> > +		clks: clks at 80000000 {
> > +			#clock-cells = <1>;
> > +			compatible = "cirrus,clps711x-clk";
> > +			reg = <0x80000000 0xc000>;
> > +			startup-frequency = <73728000>;
> > +		};
...
> > +		intc: intc at 80000000 {
> > +			compatible = "cirrus,clps711x-intc";
> > +			reg = <0x80000000 0x4000>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <1>;
> > +		};
> 
> Better make the register ranges non-overlapping. This appears
> to start at the same place as the 'clks' node.

CLK driver uses:
#define CLPS711X_SYSCON1 (0x0100)
#define CLPS711X_SYSCON2 (0x1100)
...
#define CLPS711X_PLLR (0xa5a8)

IRQCHIP driver uses:
#define CLPS711X_INTSR1 (0x0240)
...
#define CLPS711X_INTSR2 (0x1240)
...
#define CLPS711X_INTMR3 (0x2280)

So there is no way to do any else.

> > +		porta: gpio at 80000000 {
> > +			compatible = "cirrus,clps711x-gpio";
> > +			reg = <0x80000000 0x1 0x80000040 0x1>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +		};
> > +
> > +		portb: gpio at 80000001 {
> > +			compatible = "cirrus,clps711x-gpio";
> > +			reg = <0x80000001 0x1 0x80000041 0x1>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +		};
> > +
> > +		portc: gpio at 80000002 {
> > +			compatible = "cirrus,clps711x-gpio";
> > +			reg = <0x80000002 0x1 0x80000042 0x1>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			status = "disabled";
> > +		};
> > +
> > +		portd: gpio at 80000003 {
> > +			compatible = "cirrus,clps711x-gpio";
> > +			reg = <0x80000003 0x1 0x80000043 0x1>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +		};
> 
> These are all just single bytes. My guess is that there is
> actually one IP block that contains all the gpios, not
> four identical blocks.

These is a 8-bit registers with different properties, which parses in the
GPIO driver depending of alias (GPIO count, inverted logic etc.).

Thanks.

---
