From: robh@kernel.org (Rob Herring)
Date: Thu, 12 Jul 2018 08:17:29 -0600
Subject: [PATCH v2 1/3] clk: meson: add DT documentation for emmc clock
 controller
In-Reply-To: <f2eb8632-1113-3bb8-506f-ac0d4e838fd4@amlogic.com>
References: <20180710163658.6175-1-yixun.lan@amlogic.com>
 <20180710163658.6175-2-yixun.lan@amlogic.com>
 <20180711194346.GA32414@rob-hp-laptop>
 <f2eb8632-1113-3bb8-506f-ac0d4e838fd4@amlogic.com>
Message-ID: <CABGGisw64MpYx7Pvp+XGt6gfZzie6EKeHdchqS6CPDjmAHBuVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 8:47 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
>
> Hi Rob
>
> see my comments
>
> On 07/12/18 03:43, Rob Herring wrote:
> > On Tue, Jul 10, 2018 at 04:36:56PM +0000, Yixun Lan wrote:
> >> Document the MMC sub clock controller driver, the potential consumer
> >> of this driver is MMC or NAND.
> >
> > So you all have decided to properly model this now?
> >
> Yes, ;-)
>
> >>
> >> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> >> ---
> >>  .../bindings/clock/amlogic,mmc-clkc.txt       | 31 +++++++++++++++++++
> >>  1 file changed, 31 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >> new file mode 100644
> >> index 000000000000..ff6b4bf3ecf9
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >> @@ -0,0 +1,31 @@
> >> +* Amlogic MMC Sub Clock Controller Driver
> >> +
> >> +The Amlogic MMC clock controller generates and supplies clock to support
> >> +MMC and NAND controller
> >> +
> >> +Required Properties:
> >> +
> >> +- compatible: should be:
> >> +            "amlogic,meson-gx-mmc-clkc"
> >> +            "amlogic,meson-axg-mmc-clkc"
> >> +
> >> +- #clock-cells: should be 1.
> >> +- clocks: phandles to clocks corresponding to the clock-names property
> >> +- clock-names: list of parent clock names
> >> +    - "clkin0", "clkin1"
> >> +
> >> +Parent node should have the following properties :
> >> +- compatible: "syscon", "simple-mfd, and "amlogic,meson-axg-mmc-clkc"
> >
> > You don't need "simple-mfd" and probably not syscon either. The order is
> > wrong too. Most specific first.
> >
> Ok, I will drop "simple-mfd"..
>
> but the syscon is a must, since this mmc clock model access registers
> via the regmap interface

A syscon compatible should not be the only way to get a regmap.
Removing lines 56/57 of drivers/mfd/syscon.c should be sufficient.

Why do you need a regmap in the first place? What else needs to access
this register directly? Don't you need a patch removing the clock code
from within the emmc driver? It's not even using regmap, so using
regmap here doesn't help.

Rob
