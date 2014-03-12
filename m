From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 Mar 2014 13:31:56 +0900
Subject: [PATCH v2 1/3] arm64: dts: add initial dts for Samsung GH7 SoC and
 SSDK-GH7 board
In-Reply-To: <20140311182922.GD3263@e106331-lin.cambridge.arm.com>
References: <1394491879-5320-1-git-send-email-kgene.kim@samsung.com>
 <1394491879-5320-2-git-send-email-kgene.kim@samsung.com>
 <20140311182922.GD3263@e106331-lin.cambridge.arm.com>
Message-ID: <01c501cf3dac$022879b0$06796d10$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland wrote:
> 
Hi Mark,

> On Mon, Mar 10, 2014 at 10:51:17PM +0000, Kukjin Kim wrote:
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/boot/dts/samsung-gh7.dtsi     | 106
> +++++++++++++++++++++++++++++++
> >  arch/arm64/boot/dts/samsung-ssdk-gh7.dts |  26 ++++++++
> >  2 files changed, 132 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/samsung-gh7.dtsi
> >  create mode 100644 arch/arm64/boot/dts/samsung-ssdk-gh7.dts
> >
> > diff --git a/arch/arm64/boot/dts/samsung-gh7.dtsi
> b/arch/arm64/boot/dts/samsung-gh7.dtsi
> > new file mode 100644
> > index 0000000..b5e8488
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/samsung-gh7.dtsi
> > @@ -0,0 +1,106 @@
> > +/*
> > + * SAMSUNG GH7 SoC device tree source
> > + *
> > + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > +*/
> > +
> > +/memreserve/ 0x80000000 0x0C400000;
> 
> Please have a comment as to what this memreserve is intended to protect.
> This is very large, and we don't want pointless memreserves.
> 
Well, you mean I need to comment about each reserved memory area?

We need the reserved memory for EL3 monitor, UEFI services, secure
interpreter, hypervisor and Scan-chain for debug...BTW isn't it depending on
each hardware platform and usage model?

Just note, I will change the reserve memory area and size. From at
0xf8000000 and size is 128MB(0x8000000).

> What address does the kernel end up getting loaded at on this board?
> 
We load the kernel image from at 0x80080000 after changing the reserve
memory area.

> > +
> > +/ {
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	aliases {
> > +		serial0 = "/amba/uart at 12c00000";
> > +	};
> > +
> > +	cpus {
> > +		#address-cells = <2>;
> > +		#size-cells = <0>;
> > +
> > +		cpu at 000 {
> > +			device_type = "cpu";
> > +			compatible = "arm,armv8";
> 
> The "arm,armv8" should be a fallback rather than the only entry. The
> precise core should be first (see arch/arm64/boot/dts/apm-storm.dtsi for
> an example).
> 
Well, do I really need another name if GH7 has just 'ARMv8 core' exactly?

> > +			reg = <0x0 0x000>;
> 
> Any reason for padding these to three hexadecimal digits (in both the
> reg and unit-address)?
> 
Yes, I already commented on Olof's question before, other cores will be
added and it should be separated from this.

> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0x0 0x8000fff8>;
> > +		};
> > +		cpu at 001 {
> > +			device_type = "cpu";
> > +			compatible = "arm,armv8";
> > +			reg = <0x0 0x001>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0x0 0x8000fff8>;
> > +		};
> > +		cpu at 002 {
> > +			device_type = "cpu";
> > +			compatible = "arm,armv8";
> > +			reg = <0x0 0x002>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0x0 0x8000fff8>;
> > +		};
> > +		cpu at 003 {
> > +			device_type = "cpu";
> > +			compatible = "arm,armv8";
> > +			reg = <0x0 0x003>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0x0 0x8000fff8>;
> > +		};
> > +	};
> > +
> > +	gic: interrupt-controller at 1C000000 {
> > +		compatible = "arm,cortex-a15-gic";
> 
> We should have a more specific compatible string early in the list here
> too.
> 
Well, I think more specific compatible string is not required for gic, there
were discussion about using another compatible string for gic-v2. And
cortex-a15-gic should be fine at this moment and if another name is required
as per previous discussion, we will then.

> > +		#interrupt-cells = <3>;
> > +		interrupt-controller;
> > +		reg = <0x0 0x1C001000 0 0x1000>,	/* GIC Dist */
> > +		      <0x0 0x1C002000 0 0x1000>,	/* GIC CPU */
> > +		      <0x0 0x1C004000 0 0x2000>,	/* GIC VCPU Control
*/
> > +		      <0x0 0x1C006000 0 0x2000>;	/* GIC VCPU */
> > +		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <1 13 0xff01>,	/* Secure Phys IRQ */
> > +			     <1 14 0xff01>,	/* Non-secure Phys IRQ */
> > +			     <1 11 0xff01>,	/* Virt IRQ */
> > +			     <1 10 0xff01>;	/* Hyp IRQ */
> > +	};
> > +
> > +	pmu {
> > +		compatible = "arm,armv8-pmuv3";
> 
> This is missing a specific compatible string.
> 
I don't know why I need another specific compatible string here because I
thought the 'armv8-pmuv3' is enough.

> > +		interrupts = <0 294 0>,
> > +			     <0 295 0>,
> > +			     <0 296 0>,
> > +			     <0 297 0>,
> > +			     <0 298 0>,
> > +			     <0 299 0>,
> > +			     <0 300 0>,
> > +			     <0 301 0>;
> > +	};
> 
> There are four CPUs described, yet eight interrupts here. There should
> be one per CPU.
> 
Yes right. I added them here by mistake, the other four interrupts will be
used for other 4 cores will be added later though.

> > +
> > +	amba {
> > +		compatible = "arm,amba-bus";
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		serial at 12c00000 {
> > +			compatible = "arm,pl011", "arm,primecell";
> > +			reg = <0 0x12c00000 0 0x10000>;
> > +			interrupts = <0 418 0>;
> > +		};
> > +
> > +		serial at 12c20000 {
> > +			compatible = "arm,pl011", "arm,primecell";
> > +			reg = <0 0x12c20000 0 0x10000>;
> > +			interrupts = <0 420 0>;
> > +		};
> 
> These are both missing required clocks.
> 
Yes right.

> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/samsung-ssdk-gh7.dts
> b/arch/arm64/boot/dts/samsung-ssdk-gh7.dts
> > new file mode 100644
> > index 0000000..47afbc4
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/samsung-ssdk-gh7.dts
> > @@ -0,0 +1,26 @@
> > +/*
> > + * SAMSUNG SSDK-GH7 board device tree source
> > + *
> > + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > +*/
> > +
> > +/dts-v1/;
> > +#include "samsung-gh7.dtsi"
> > +
> > +/ {
> > +	model = "SAMSUNG SSDK-GH7 board based on GH7 SoC";
> 
> Is the "based on GH7 SoC" part necessary? Does the "SSDK-GH7" not give
> that away?
> 
In this case, yes, SSDK-GH7 is enough but I though, in case of different
board adding what SoC is used on the board in that is useful. Anyway, OK.

Thanks,
Kukjin
