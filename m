From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 11 Oct 2017 14:18:06 +1030
Subject: [PATCH 11/11] ARM: dts: Add PCLK to the Aspeed watchdogs
In-Reply-To: <20170812184318.10144-12-linus.walleij@linaro.org>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-12-linus.walleij@linaro.org>
Message-ID: <1507693686.5452.174.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-08-12 at 20:43 +0200, Linus Walleij wrote:
> This adds the PCLK clock to the Aspeed watchdog blocks.
> I am not directly familiar with the Aspeed clocking, but
> since the IP is derived from Faraday FTWDT010 it probably
> has the ability to run the watchdog on the PCLK if
> desired

This is true for the AST2400, but not the AST2500 where the only option
is EXTCLK (1MHz).

>  so to obtain the frequency from it, it needs to
> be present in the device tree, and for completeness the
> PCLK should also be referenced and enabled anyways.
> 
> Take this opportunity to add the "faraday,ftwdt010"
> compatible as fallback to the watchdog IP blocks.
> 
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ?arch/arm/boot/dts/aspeed-g4.dtsi |??7 +++++--
> ?arch/arm/boot/dts/aspeed-g5.dtsi | 12 +++++++++---
> ?2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 8a04c7e2d818..23b100383c15 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -895,16 +895,19 @@
> > ?			};
> ?
> > > ?			wdt1: wdt at 1e785000 {
> > -				compatible = "aspeed,ast2400-wdt";
> > +				compatible = "aspeed,ast2400-wdt", "faraday,ftwdt010";
> > ?				reg = <0x1e785000 0x1c>;
> > ?				interrupts = <27>;
> > +				clocks = <&clk_apb>;
> > +				clock-names = "PCLK";
> > ?			};
> ?
> > > ?			wdt2: wdt at 1e785020 {
> > -				compatible = "aspeed,ast2400-wdt";
> > +				compatible = "aspeed,ast2400-wdt", "faraday,ftwdt010";
> > ?				reg = <0x1e785020 0x1c>;
> > ?				interrupts = <27>;
> > ?				clocks = <&clk_apb>;
> > +				clock-names = "PCLK";
> > ?				status = "disabled";
> > ?			};
> ?
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 9cffe347b828..2322d72cd8a9 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -1003,21 +1003,27 @@
> ?
> ?
> > > ?			wdt1: wdt at 1e785000 {
> > -				compatible = "aspeed,ast2500-wdt";
> > +				compatible = "aspeed,ast2500-wdt", "faraday,ftwdt010";
> > ?				reg = <0x1e785000 0x20>;
> > ?				interrupts = <27>;
> > +				clocks = <&clk_apb>;
> +				clock-names = "PCLK";

Given the comment above, shouldn't we be doing something like the
following instead for each of the watchdogs?

+				faraday,use-extclk;
+				clock-names = "EXTCLK";

Andrew

> ?			};
> ?
> > > ?			wdt2: wdt at 1e785020 {
> > -				compatible = "aspeed,ast2500-wdt";
> > +				compatible = "aspeed,ast2500-wdt", "faraday,ftwdt010";
> > ?				reg = <0x1e785020 0x20>;
> > ?				interrupts = <27>;
> > +				clocks = <&clk_apb>;
> > +				clock-names = "PCLK";
> > ?				status = "disabled";
> > ?			};
> ?
> > > ?			wdt3: wdt at 1e785040 {
> > -				compatible = "aspeed,ast2500-wdt";
> > +				compatible = "aspeed,ast2500-wdt", "faraday,ftwdt010";
> > ?				reg = <0x1e785040 0x20>;
> > +				clocks = <&clk_apb>;
> > +				clock-names = "PCLK";
> > ?				status = "disabled";
> > ?			};
> ?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171011/7cd46879/attachment.sig>
