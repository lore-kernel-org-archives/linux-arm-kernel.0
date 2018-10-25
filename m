From: dlan@gentoo.org (Yixun Lan)
Date: Thu, 25 Oct 2018 15:29:15 +0800
Subject: [PATCH v5 2/3] clk: meson: add DT documentation for emmc clock
 controller
In-Reply-To: <ca95948abd58876a23b2eb3e52b96124e9eed793.camel@baylibre.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-3-git-send-email-jianxin.pan@amlogic.com>
 <ca95948abd58876a23b2eb3e52b96124e9eed793.camel@baylibre.com>
Message-ID: <20181024145513.GA6647@ofant>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome, Jianxin:

see my comments

On 10:58 Wed 24 Oct     , Jerome Brunet wrote:
> On Thu, 2018-10-18 at 13:07 +0800, Jianxin Pan wrote:
> > From: Yixun Lan <yixun.lan@amlogic.com>
> > 
> > Document the MMC sub clock controller driver, the potential consumer
> > of this driver is MMC or NAND. Also add four clock bindings IDs which
> > provided by this driver.
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> > Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> > ---
> >  .../devicetree/bindings/clock/amlogic,mmc-clkc.txt | 31 ++++++++++++++++++++++
> >  include/dt-bindings/clock/amlogic,mmc-clkc.h       | 17 ++++++++++++
> >  2 files changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> >  create mode 100644 include/dt-bindings/clock/amlogic,mmc-clkc.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> > new file mode 100644
> > index 0000000..9e6d343
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
> > @@ -0,0 +1,31 @@
> > +* Amlogic MMC Sub Clock Controller Driver
> > +
> > +The Amlogic MMC clock controller generates and supplies clock to support
> > +MMC and NAND controller
> > +
> > +Required Properties:
> > +
> > +- compatible: should be:
> > +		"amlogic,gx-mmc-clkc"
> > +		"amlogic,axg-mmc-clkc"
> > +
> > +- #clock-cells: should be 1.
> > +- clocks: phandles to clocks corresponding to the clock-names property
> > +- clock-names: list of parent clock names
> > +	- "clkin0", "clkin1"
> > +
> > +Parent node should have the following properties :
> > +- compatible: "amlogic,axg-mmc-clkc", "syscon".
> > +- reg: base address and size of the MMC control register space.
> 
> I get why Stephen is confused by your description, I am too. The example
> contradict the documentation.
> 
> The  documentation above says that the parent node should be a syscon with the
> mmc register space.
> 
> But your example shows this in the node itself.
> 

yes, I think the documentation need to be fixed

for the final solution, we decide to make 'mmc-clkc' an independent node
instead of being a sub-node of 'mmc', so both of them may exist in parallel..

the DT part may like this:

			sd_emmc_c_clkc: clock-controller at 7000 {
				compatible = "amlogic,axg-mmc-clkc", "syscon";
				reg = <0x0 0x7000 0x0 0x4>;
				...
			};

			sd_emmc_c: mmc at 7000 {
				compatible = "amlogic,axg-mmc";
				reg = <0x0 0x7000 0x0 0x800>;
				...
			};


> > +
> > +Example: Clock controller node:
> > +
> > +sd_mmc_c_clkc: clock-controller at 7000 {
> > +	compatible = "amlogic,axg-mmc-clkc", "syscon";
> > +	reg = <0x0 0x7000 0x0 0x4>;
> > +	#clock-cells = <1>;
> > +
> > +	clock-names = "clkin0", "clkin1";
> > +	clocks = <&clkc CLKID_SD_MMC_C_CLK0>,
> > +		 <&clkc CLKID_FCLK_DIV2>;
> > +};
> > diff --git a/include/dt-bindings/clock/amlogic,mmc-clkc.h b/include/dt-bindings/clock/amlogic,mmc-clkc.h
> > new file mode 100644
> > index 0000000..162b949
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/amlogic,mmc-clkc.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> > +/*
> > + * Meson MMC sub clock tree IDs
> > + *
> > + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> > + * Author: Yixun Lan <yixun.lan@amlogic.com>
> > + */
> > +
> > +#ifndef __MMC_CLKC_H
> > +#define __MMC_CLKC_H
> > +
> > +#define CLKID_MMC_DIV				1
> > +#define CLKID_MMC_PHASE_CORE			2
> > +#define CLKID_MMC_PHASE_TX			3
> > +#define CLKID_MMC_PHASE_RX			4
> > +
> > +#endif
> 
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
