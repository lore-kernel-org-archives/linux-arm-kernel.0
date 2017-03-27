From: mturquette@baylibre.com (Michael Turquette)
Date: Mon, 27 Mar 2017 12:53:55 -0700
Subject: [PATCH v4 3/3] ARM64: dts: meson-gx: Add MALI nodes for GXBB and
 GXL
In-Reply-To: <m237e2iirk.fsf@baylibre.com>
References: <1490177935-9646-1-git-send-email-narmstrong@baylibre.com>
 <1490177935-9646-4-git-send-email-narmstrong@baylibre.com>
 <m237e2iirk.fsf@baylibre.com>
Message-ID: <149064443540.54062.12740186024138662455@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kevin Hilman (2017-03-24 12:20:31)
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
> > The same MALI-450 MP3 GPU is present in the GXBB and GXL SoCs.
> >
> > The node is simply added in the meson-gxbb.dtsi file.
> >
> > For GXL, since a lot is shared with the GXM that has a MALI-T820 IP, this
> > patch adds a new meson-gxl-mali.dtsi and is included in the SoC specific
> > dtsi files.
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> LGTM, I can apply this when the clk driver changes are merged (feel free
> to let me know when that happens, in case I'm not paying attention.)

Applied to clk-meson, a stable branch, which has been merged into
clk-next.

Kevin, the dtsi is all yours.

Regards,
Mike

> 
> <bikeshed>
> nit: This series (and previous ones) use MALI, but I believe the correct
> way is Mali. Could you standarize on that throughout the series?
> </bikeshed>
> 
> Kevin
> 
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi      | 37 ++++++++++++++++++++
> >  arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi  | 43 ++++++++++++++++++++++++
> >  arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi |  1 +
> >  arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi |  1 +
> >  4 files changed, 82 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> > index 04b3324..0617a3d 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> > @@ -478,6 +478,43 @@
> >       };
> >  };
> >  
> > +&apb {
> > +     mali: gpu at c0000 {
> > +             compatible = "amlogic,meson-gxbb-mali", "arm,mali-450";
> > +             reg = <0x0 0xc0000 0x0 0x40000>;
> > +             interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> > +             interrupt-names = "gp", "gpmmu", "pp", "pmu",
> > +                     "pp0", "ppmmu0", "pp1", "ppmmu1",
> > +                     "pp2", "ppmmu2";
> > +             clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
> > +             clock-names = "bus", "core";
> > +
> > +             /*
> > +              * Mali clocking is provided by two identical clock paths
> > +              * MALI_0 and MALI_1 muxed to a single clock by a glitch
> > +              * free mux to safely change frequency while running.
> > +              */
> > +             assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
> > +                               <&clkc CLKID_MALI_0>,
> > +                               <&clkc CLKID_MALI>; /* Glitch free mux */
> > +             assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
> > +                                      <0>, /* Do Nothing */
> > +                                      <&clkc CLKID_MALI_0>;
> > +             assigned-clock-rates = <0>, /* Do Nothing */
> > +                                    <666666666>,
> > +                                    <0>; /* Do Nothing */
> > +     };
> > +};
> > +
> >  &i2c_A {
> >       clocks = <&clkc CLKID_I2C>;
> >  };
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
> > new file mode 100644
> > index 0000000..f06cc234
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi
> > @@ -0,0 +1,43 @@
> > +/*
> > + * Copyright (c) 2017 BayLibre SAS
> > + * Author: Neil Armstrong <narmstrong@baylibre.com>
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > + */
> > +
> > +&apb {
> > +     mali: gpu at c0000 {
> > +             compatible = "amlogic,meson-gxbb-mali", "arm,mali-450";
> > +             reg = <0x0 0xc0000 0x0 0x40000>;
> > +             interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> > +             interrupt-names = "gp", "gpmmu", "pp", "pmu",
> > +                     "pp0", "ppmmu0", "pp1", "ppmmu1",
> > +                     "pp2", "ppmmu2";
> > +             clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
> > +             clock-names = "bus", "core";
> > +
> > +             /*
> > +              * Mali clocking is provided by two identical clock paths
> > +              * MALI_0 and MALI_1 muxed to a single clock by a glitch
> > +              * free mux to safely change frequency while running.
> > +              */
> > +             assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
> > +                               <&clkc CLKID_MALI_0>,
> > +                               <&clkc CLKID_MALI>; /* Glitch free mux */
> > +             assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
> > +                                      <0>, /* Do Nothing */
> > +                                      <&clkc CLKID_MALI_0>;
> > +             assigned-clock-rates = <0>, /* Do Nothing */
> > +                                    <666666666>,
> > +                                    <0>; /* Do Nothing */
> > +     };
> > +};
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi
> > index 615308e..5a90e30 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi
> > @@ -42,6 +42,7 @@
> >   */
> >  
> >  #include "meson-gxl.dtsi"
> > +#include "meson-gxl-mali.dtsi"
> >  
> >  / {
> >       compatible = "amlogic,s905d", "amlogic,meson-gxl";
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
> > index 08237ee..0f78d83 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi
> > @@ -42,6 +42,7 @@
> >   */
> >  
> >  #include "meson-gxl.dtsi"
> > +#include "meson-gxl-mali.dtsi"
> >  
> >  / {
> >       compatible = "amlogic,s905x", "amlogic,meson-gxl";
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
