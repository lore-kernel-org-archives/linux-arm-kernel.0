From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 20 Oct 2015 11:20:18 +0200
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <20151019173235.GF29001@leverpostej>
References: <5124277.UR9sg1IOHT@wuerfel> <560EFDB3.9010305@free.fr>
 <11113740.WL812ZaRcZ@wuerfel> <5612A473.8030405@sigmadesigns.com>
 <5613EF4C.30603@sigmadesigns.com>
 <CAL_JsqJ+WTBYF=sJWbkgNzL48H5AiXL4aoVV3DNiL6T_UQKQfg@mail.gmail.com>
 <561D2952.4060908@sigmadesigns.com>
 <CAL_JsqKa4trfpLY_DPsjBrfH-7SSUQMACYVW7DNN1=Pv3B4FrA@mail.gmail.com>
 <5624CF62.6020001@sigmadesigns.com>
 <CAL_Jsq+jthx9ffnUm-G-TV9LdxBRp3SKyhyfcVu=7kN3CuumJw@mail.gmail.com>
 <20151019173235.GF29001@leverpostej>
Message-ID: <56260752.7030200@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/10/2015 19:32, Mark Rutland wrote:

> Marc Gonzalez wrote:
>
>> Found "arm,cortex-a9-pmu" in arch/arm/kernel/perf_event_v7.c
>> Are the PMU registers available from non-secure mode, or is
>> TrustZone going to get in the way?
> 
> Judging by the access permissions tables in c12.9 of the ARM ARM (ARM DDI
> 0406C.c), they're always accessible from non-secure PL1 in the absence
> of the virtualization extensions.

Thanks for digging up the info.

One more thing is unclear about the PMU. While things like the TWD block
seem to have a well-defined IRQ number, when I look at other platforms'
DT pmu node, everyone seems to have a different IRQ setup. Why is that?

Some use GIC_SPI, some use GIC_PPI
Some list 1 interrupt, others 2, others 4
Some have 3 cells (as expected by the GIC), exynos4 only has 2 (interrupts = <2 2>, <3 2>;)
Some use IRQ_TYPE_EDGE_RISING, others use IRQ_TYPE_LEVEL_HIGH

My SoC documentation only states:
1.12.2 ARM core interrupt vector
ARM A9MP core has a 32-bit interrupt vector that drives the ARM interrupt controller (GIC).
Input vector is the following :
- bit[1:0]: 0 / Unused.
- bit[2]: cpu_block IRQ controller0.
- bit[3]: cpu_block IRQ controller1.
- bit[4]: cpu_block IRQ controller2.
- bit[7:5]: 0 / Unused.
- bit[11:8]: Core N cross trigger interface IRQ (Coresight component).
- bit[15:12]: Core N performance management unit IRQ (Coresight component) .
- bit[31:16]: 0 / Unused.

So I'm thinking I should use
- GIC_SPI
- interrupts 12 and 13 (should I list the other lines if no SoC has more than 2 cores?)
- no idea on edge vs level, I'm guessing level

So I should add

	pmu {
		compatible = "arm,cortex-a9-pmu";
		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
	};

Does that look (likely to be) correct?

Regards.
