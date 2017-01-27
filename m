From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 09:58:25 +0100
Subject: [PATCH 07/11] clk: sunxi-ng: Add A80 Display Engine CCU
In-Reply-To: <CAGb2v65QLAD4C27NoRHALO=2WzW=DC6OxwCCMhes-N+kWO3_kg@mail.gmail.com>
References: <20170124023230.3990-1-wens@csie.org>
 <20170124023230.3990-8-wens@csie.org>
 <20170126103928.3kmvymoafsz5jfjm@lukather>
 <CAGb2v65QLAD4C27NoRHALO=2WzW=DC6OxwCCMhes-N+kWO3_kg@mail.gmail.com>
Message-ID: <20170127085825.b4mzk47gpczj3dcu@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 07:20:22PM +0800, Chen-Yu Tsai wrote:
> On Thu, Jan 26, 2017 at 6:39 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Tue, Jan 24, 2017 at 10:32:26AM +0800, Chen-Yu Tsai wrote:
> >> Add support for the display engine clock controls found on the A80.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  .../devicetree/bindings/clock/sun9i-de.txt         |  28 ++
> >>  drivers/clk/sunxi-ng/Makefile                      |   1 +
> >>  drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c            | 283 +++++++++++++++++++++
> >>  drivers/clk/sunxi-ng/ccu-sun9i-a80-de.h            |  33 +++
> >>  include/dt-bindings/clock/sun9i-a80-de.h           |  80 ++++++
> >>  include/dt-bindings/reset/sun9i-a80-de.h           |  58 +++++
> >>  6 files changed, 483 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/sun9i-de.txt
> >>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
> >>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.h
> >>  create mode 100644 include/dt-bindings/clock/sun9i-a80-de.h
> >>  create mode 100644 include/dt-bindings/reset/sun9i-a80-de.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/sun9i-de.txt b/Documentation/devicetree/bindings/clock/sun9i-de.txt
> >> new file mode 100644
> >> index 000000000000..3a5e6df70677
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/sun9i-de.txt
> >> @@ -0,0 +1,28 @@
> >> +Allwinner A80 Display Engine Clock Control Binding
> >> +------------------------------------
> >> +
> >> +Required properties :
> >> +- compatible: must contain one of the following compatibles:
> >> +             - "allwinner,sun9i-a80-de-clocks"
> >> +
> >> +- reg: Must contain the registers base address and length
> >> +- clocks: phandle to the clocks feeding the display engine subsystem.
> >> +       Three are needed:
> >> +  - "mod": the display engine module clock
> >> +  - "dram": the DRAM bus clock for the system
> >> +  - "bus": the bus clock for the whole display engine subsystem
> >> +- clock-names: Must contain the clock names described just above
> >> +- resets: phandle to the reset control for the display engine subsystem.
> >> +- #clock-cells : must contain 1
> >> +- #reset-cells : must contain 1
> >> +
> >> +Example:
> >> +de_clocks: clock at 03000000 {
> >> +     compatible = "allwinner,sun9i-a80-de-clks";
> >> +     reg = <0x03000000 0x30>;
> >> +     clocks = <&ccu CLK_DE>, <&ccu CLK_SDRAM>, <&ccu CLK_BUS_DE>;
> >> +     clock-names = "mod", "dram", "bus";
> >> +     resets = <&ccu RST_BUS_DE>;
> >> +     #clock-cells = <1>;
> >> +     #reset-cells = <1>;
> >> +};
> >> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> >> index 8f37ef7fb67d..6feaac0c5600 100644
> >> --- a/drivers/clk/sunxi-ng/Makefile
> >> +++ b/drivers/clk/sunxi-ng/Makefile
> >> @@ -26,4 +26,5 @@ obj-$(CONFIG_SUN8I_A33_CCU) += ccu-sun8i-a33.o
> >>  obj-$(CONFIG_SUN8I_H3_CCU)   += ccu-sun8i-h3.o
> >>  obj-$(CONFIG_SUN8I_V3S_CCU)  += ccu-sun8i-v3s.o
> >>  obj-$(CONFIG_SUN9I_A80_CCU)  += ccu-sun9i-a80.o
> >> +obj-$(CONFIG_SUN9I_A80_CCU)  += ccu-sun9i-a80-de.o
> >>  obj-$(CONFIG_SUN9I_A80_CCU)  += ccu-sun9i-a80-usb.o
> >> diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
> >> new file mode 100644
> >> index 000000000000..3fc27db0a49a
> >> --- /dev/null
> >> +++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
> >> @@ -0,0 +1,283 @@
> >> +/*
> >> + * Copyright (c) 2016 Chen-Yu Tsai. All rights reserved.
> >> + *
> >> + * This software is licensed under the terms of the GNU General Public
> >> + * License version 2, as published by the Free Software Foundation, and
> >> + * may be copied, distributed, and modified under those terms.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + */
> >> +
> >> +#include <linux/clk.h>
> >> +#include <linux/clk-provider.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/reset.h>
> >> +
> >> +#include "ccu_common.h"
> >> +#include "ccu_div.h"
> >> +#include "ccu_gate.h"
> >> +#include "ccu_reset.h"
> >> +
> >> +#include "ccu-sun9i-a80-de.h"
> >> +
> >> +static SUNXI_CCU_GATE(fe0_clk,               "fe0",          "fe0-div",
> >> +                   0x00, BIT(0), 0);
> >> +static SUNXI_CCU_GATE(fe1_clk,               "fe1",          "fe1-div",
> >> +                   0x00, BIT(1), 0);
> >> +static SUNXI_CCU_GATE(fe2_clk,               "fe2",          "fe2-div",
> >> +                   0x00, BIT(2), 0);
> >> +static SUNXI_CCU_GATE(iep_deu0_clk,  "iep-deu0",     "de",
> >> +                   0x00, BIT(4), 0);
> >> +static SUNXI_CCU_GATE(iep_deu1_clk,  "iep-deu1",     "de",
> >> +                   0x00, BIT(5), 0);
> >> +static SUNXI_CCU_GATE(be0_clk,               "be0",          "be0-div",
> >> +                   0x00, BIT(8), 0);
> >> +static SUNXI_CCU_GATE(be1_clk,               "be1",          "be1-div",
> >> +                   0x00, BIT(9), 0);
> >> +static SUNXI_CCU_GATE(be2_clk,               "be2",          "be2-div",
> >> +                   0x00, BIT(10), 0);
> >> +static SUNXI_CCU_GATE(iep_drc0_clk,  "iep-drc0",     "de",
> >> +                   0x00, BIT(12), 0);
> >> +static SUNXI_CCU_GATE(iep_drc1_clk,  "iep-drc1",     "de",
> >> +                   0x00, BIT(13), 0);
> >> +static SUNXI_CCU_GATE(merge_clk,     "merge",        "de",
> >> +                   0x00, BIT(20), 0);
> >> +
> >> +static SUNXI_CCU_GATE(dram_fe0_clk,  "dram-fe0",     "sdram",
> >> +                   0x04, BIT(0), 0);
> >> +static SUNXI_CCU_GATE(dram_fe1_clk,  "dram-fe1",     "sdram",
> >> +                   0x04, BIT(1), 0);
> >> +static SUNXI_CCU_GATE(dram_fe2_clk,  "dram-fe2",     "sdram",
> >> +                   0x04, BIT(2), 0);
> >> +static SUNXI_CCU_GATE(dram_deu0_clk, "dram-deu0",    "sdram",
> >> +                   0x04, BIT(4), 0);
> >> +static SUNXI_CCU_GATE(dram_deu1_clk, "dram-deu1",    "sdram",
> >> +                   0x04, BIT(5), 0);
> >> +static SUNXI_CCU_GATE(dram_be0_clk,  "dram-be0",     "sdram",
> >> +                   0x04, BIT(8), 0);
> >> +static SUNXI_CCU_GATE(dram_be1_clk,  "dram-be1",     "sdram",
> >> +                   0x04, BIT(9), 0);
> >> +static SUNXI_CCU_GATE(dram_be2_clk,  "dram-be2",     "sdram",
> >> +                   0x04, BIT(10), 0);
> >> +static SUNXI_CCU_GATE(dram_drc0_clk, "dram-drc0",    "sdram",
> >> +                   0x04, BIT(12), 0);
> >> +static SUNXI_CCU_GATE(dram_drc1_clk, "dram-drc1",    "sdram",
> >> +                   0x04, BIT(13), 0);
> >> +
> >> +static SUNXI_CCU_GATE(bus_fe0_clk,   "bus-fe0",      "bus-de",
> >> +                   0x08, BIT(0), 0);
> >> +static SUNXI_CCU_GATE(bus_fe1_clk,   "bus-fe1",      "bus-de",
> >> +                   0x08, BIT(1), 0);
> >> +static SUNXI_CCU_GATE(bus_fe2_clk,   "bus-fe2",      "bus-de",
> >> +                   0x08, BIT(2), 0);
> >> +static SUNXI_CCU_GATE(bus_deu0_clk,  "bus-deu0",     "bus-de",
> >> +                   0x08, BIT(4), 0);
> >> +static SUNXI_CCU_GATE(bus_deu1_clk,  "bus-deu1",     "bus-de",
> >> +                   0x08, BIT(5), 0);
> >> +static SUNXI_CCU_GATE(bus_be0_clk,   "bus-be0",      "bus-de",
> >> +                   0x08, BIT(8), 0);
> >> +static SUNXI_CCU_GATE(bus_be1_clk,   "bus-be1",      "bus-de",
> >> +                   0x08, BIT(9), 0);
> >> +static SUNXI_CCU_GATE(bus_be2_clk,   "bus-be2",      "bus-de",
> >> +                   0x08, BIT(10), 0);
> >> +static SUNXI_CCU_GATE(bus_drc0_clk,  "bus-drc0",     "bus-de",
> >> +                   0x08, BIT(12), 0);
> >> +static SUNXI_CCU_GATE(bus_drc1_clk,  "bus-drc1",     "bus-de",
> >> +                   0x08, BIT(13), 0);
> >> +
> >> +static SUNXI_CCU_M(fe0_div_clk, "fe0-div", "de", 0x20, 0, 4, 0);
> >> +static SUNXI_CCU_M(fe1_div_clk, "fe1-div", "de", 0x20, 4, 4, 0);
> >> +static SUNXI_CCU_M(fe2_div_clk, "fe2-div", "de", 0x20, 8, 4, 0);
> >> +static SUNXI_CCU_M(be0_div_clk, "be0-div", "de", 0x20, 16, 4, 0);
> >> +static SUNXI_CCU_M(be1_div_clk, "be1-div", "de", 0x20, 20, 4, 0);
> >> +static SUNXI_CCU_M(be2_div_clk, "be2-div", "de", 0x20, 24, 4, 0);
> >
> > I couldn't find any documentation for this CCU.
> 
> I dug this up in the released Allwinner kernel.
> 
> > What are those clocks for, and how the display engine should be using
> > (ie, which one is it expecting to drive / ungate / etc.)
> 
> Allwinner basically put all DE-related clock controls into a
> separate module. In here, as the names above suggest, we have
> bus gates, dram gates, and module clocks for each part of the
> display pipeline. As with older SoCs that have DE 1.0, each
> module should ungate and use the clocks related to them.
> 
> I'll put something like the above in the commit message.

So the module clocks are a combination of a divider and a clock?

And I'm guessing the reason you separated them is because they belong
in a different register.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/3bc7e36d/attachment.sig>
