From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Jul 2015 15:34:26 +0100
Subject: [PATCH 1/2] arm64: dts: Add dts files for Marvell Berlin4CT SoC
In-Reply-To: <1437488279-2088-2-git-send-email-jszhang@marvell.com>
References: <1437488279-2088-1-git-send-email-jszhang@marvell.com>
 <1437488279-2088-2-git-send-email-jszhang@marvell.com>
Message-ID: <20150721143426.GC10595@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> +/dts-v1/;
> +
> +/memreserve/ 0x00000000 0x01000000;

What's this reservation for?

Given you're using PSCI I can't see why we'd expect the kernel to map
but not use some memory.

> +
> +#include "berlin4ct.dtsi"
> +
> +/ {
> +	model = "MARVELL BG4CT DMP BOARD";
> +	compatible = "marvell,berlin4ct-dmp", "marvell,berlin4ct", "marvell,berlin";
> +
> +	chosen {
> +		bootargs = "earlyprintk";
> +		stdout-path = "serial0:115200n8";
> +	};

You shouldn't need those bootargs; "earlyprintk" does nothing on arm64.

[...]

> +		gic: interrupt-controller at 901000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x901000 0x1000>,
> +			      <0x902000 0x1000>,
> +			      <0x904000 0x2000>,
> +			      <0x906000 0x2000>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +

I believe the size of the cpu interface (the second reg entry) should be
0x2000, as GICC_DIR is at offset 0x1000.

Otherwise this looks fine.

Thanks,
Mark.
