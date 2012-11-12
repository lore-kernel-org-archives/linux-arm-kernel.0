From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 12 Nov 2012 11:57:21 +0000
Subject: [PATCH v2 2/5] clk: Add support for fundamental zynq clks
In-Reply-To: <20121108232807.GG18904@xsjpsgb1010.xilinx.com>
References: <cover.1352400580.git.josh.cartwright@ni.com>
 <3569f4619a92904a40aecc9300aafe767ac736f7.1352400580.git.josh.cartwright@ni.com>
 <20121108232807.GG18904@xsjpsgb1010.xilinx.com>
Message-ID: <7b24758d-d227-4ff4-bc7a-b21c8a95ee5f@TX2EHSMHS044.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Soren Brinkmann [mailto:soren.brinkmann at xilinx.com]
> Sent: Friday, November 09, 2012 12:28 AM
> To: Josh Cartwright
> Cc: Mike Turquette; Rob Herring; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Michal Simek; John Linn; arm at kernel.org
> Subject: Re: [PATCH v2 2/5] clk: Add support for fundamental zynq clks
> 
> One note below:
> 
> On Wed, Oct 31, 2012 at 12:58:52PM -0600, Josh Cartwright wrote:
> > Provide simplified models for the necessary clocks on the zynq-7000
> > platform.  Currently, the PLLs, the CPU clock network, and the basic
> > peripheral clock networks (for SDIO, SMC, SPI, QSPI, UART) are modelled.
> >
> > OF bindings are also provided and documented.
> >
> > Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> > ---
> >  .../devicetree/bindings/clock/zynq-7000.txt        |  55 +++
> >  drivers/clk/clk-zynq.c                             | 383 +++++++++++++++++++++
> >  include/linux/clk/zynq.h                           |  24 ++
> >  3 files changed, 462 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/zynq-7000.txt
> >  create mode 100644 drivers/clk/clk-zynq.c  create mode 100644
> > include/linux/clk/zynq.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/zynq-7000.txt
> > b/Documentation/devicetree/bindings/clock/zynq-7000.txt
> > new file mode 100644
> > index 0000000..23ae1db
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/zynq-7000.txt
> > @@ -0,0 +1,55 @@
> > +Device Tree Clock bindings for the Zynq 7000 EPP
> > +
> > +The Zynq EPP has several different clk providers, each with there own
> bindings.
> > +The purpose of this document is to document their usage.
> > +
> > +See clock_bindings.txt for more information on the generic clock bindings.
> > +See Chapter 25 of Zynq TRM for more information about Zynq clocks.
> > +
> > +== PLLs ==
> > +
> > +Used to describe the ARM_PLL, DDR_PLL, and IO_PLL.
> > +
> > +Required properties:
> > +- #clock-cells : shall be 0 (only one clock is output from this node)
> > +- compatible : "xlnx,zynq-pll"
> > +- reg : pair of u32 values, which are the address offsets within the SLCR
> > +        of the relevant PLL_CTRL register and PLL_CFG register
> > +respectively
> > +- clocks : phandle for parent clock.  should be the phandle for
> > +ps_clk
> > +
> > +Optional properties:
> > +- clock-output-names : name of the output clock
> > +
> > +Example:
> > +	armpll: armpll {
> > +		#clock-cells = <0>;
> > +		compatible = "xlnx,zynq-pll";
> > +		clocks = <&ps_clk>;
> > +		reg = <0x100 0x110>;
> > +		clock-output-names = "armpll";
> > +	};
> > +
> > +== Peripheral clocks ==
> > +
> > +Describes clock node for the SDIO, SMC, SPI, QSPI, and UART clocks.
> > +
> > +Required properties:
> > +- #clock-cells : shall be 1
> > +- compatible : "xlnx,zynq-periph-clock"
> > +- reg : a single u32 value, describing the offset within the SLCR where
> > +        the CLK_CTRL register is found for this peripheral
> > +- clocks : phandle for parent clocks.  should hold phandles for
> > +           the IO_PLL, ARM_PLL, and DDR_PLL in order
> > +- clock-output-names : names of the output clock(s).  For peripherals that
> have
> > +                       two output clocks (for example, the UART), two clocks
> > +                       should be listed.
> > +
> > +Example:
> > +	uart_clk: uart_clk {
> > +		#clock-cells = <1>;
> > +		compatible = "xlnx,zynq-periph-clock";
> > +		clocks = <&iopll &armpll &ddrpll>;
> > +		reg = <0x154>;
> > +		clock-output-names = "uart0_ref_clk",
> > +				     "uart1_ref_clk";
> > +	};
> > diff --git a/drivers/clk/clk-zynq.c b/drivers/clk/clk-zynq.c new file
> > mode 100644 index 0000000..de8b586
> > --- /dev/null
> > +++ b/drivers/clk/clk-zynq.c
> > @@ -0,0 +1,383 @@
> > +/*
> > + * Copyright (c) 2012 National Instruments
> > + *
> > + * Josh Cartwright <josh.cartwright@ni.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but
> > +WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> > +or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> > +License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > +along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/slab.h>
> > +#include <linux/kernel.h>
> > +#include <linux/clk-provider.h>
> > +
> > +static void __iomem *slcr_base;
> > +
> > +struct zynq_pll_clk {
> > +	struct clk_hw	hw;
> > +	void __iomem	*pll_ctrl;
> > +	void __iomem	*pll_cfg;
> > +};
> > +
> > +#define to_zynq_pll_clk(hw)	container_of(hw, struct zynq_pll_clk, hw)
> > +
> > +#define CTRL_PLL_FDIV(x)	((x) >> 12)
> > +
> > +static unsigned long zynq_pll_recalc_rate(struct clk_hw *hw,
> > +					  unsigned long parent_rate)
> > +{
> > +	struct zynq_pll_clk *pll = to_zynq_pll_clk(hw);
> > +	return parent_rate * CTRL_PLL_FDIV(ioread32(pll->pll_ctrl));
> > +}
> > +
> > +static const struct clk_ops zynq_pll_clk_ops = {
> > +	.recalc_rate	= zynq_pll_recalc_rate,
> > +};
> > +
> > +static void __init zynq_pll_clk_setup(struct device_node *np) {
> > +	struct clk_init_data init;
> > +	struct zynq_pll_clk *pll;
> > +	const char *parent_name;
> > +	struct clk *clk;
> > +	u32 regs[2];
> > +	int ret;
> > +
> > +	ret = of_property_read_u32_array(np, "reg", regs, ARRAY_SIZE(regs));
> > +	if (WARN_ON(ret))
> > +		return;
> > +
> > +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> > +	if (WARN_ON(!pll))
> > +		return;
> > +
> > +	pll->pll_ctrl = slcr_base + regs[0];
> > +	pll->pll_cfg  = slcr_base + regs[1];
> > +
> > +	of_property_read_string(np, "clock-output-names", &init.name);
> > +
> > +	init.ops = &zynq_pll_clk_ops;
> > +	parent_name = of_clk_get_parent_name(np, 0);
> > +	init.parent_names = &parent_name;
> > +	init.num_parents = 1;
> > +
> > +	pll->hw.init = &init;
> > +
> > +	clk = clk_register(NULL, &pll->hw);
> > +	if (WARN_ON(IS_ERR(clk)))
> > +		return;
> > +
> > +	ret = of_clk_add_provider(np, of_clk_src_simple_get, clk);
> > +	if (WARN_ON(ret))
> > +		return;
> > +}
> > +
> > +struct zynq_periph_clk {
> > +	struct clk_hw		hw;
> > +	struct clk_onecell_data	onecell_data;
> > +	struct clk		*gates[2];
> > +	void __iomem		*clk_ctrl;
> > +	spinlock_t		clkact_lock;
> > +};
> > +
> > +#define to_zynq_periph_clk(hw)	container_of(hw, struct zynq_periph_clk,
> hw)
> > +
> > +static const u8 periph_clk_parent_map[] = {
> > +	0, 0, 1, 2
> > +};
> > +#define PERIPH_CLK_CTRL_SRC(x)	(periph_clk_parent_map[((x) & 3) >> 4])
> I think this should be:
> #define PERIPH_CLK_CTRL_SRC(x)	(periph_clk_parent_map[((x) & 0x30) >>
> 4])
> 


Josh: Any comment?

Thanks,
Michal
