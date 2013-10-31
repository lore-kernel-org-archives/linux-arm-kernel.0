From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 31 Oct 2013 16:15:31 +0100
Subject: [PATCH 2/3] clk: shmobile: Add MSTP clock support
In-Reply-To: <5E542DCC-EA79-4A9E-BC60-B8E1B964F16D@codeaurora.org>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1481817.doGcO1nQB0@avalon>
 <5E542DCC-EA79-4A9E-BC60-B8E1B964F16D@codeaurora.org>
Message-ID: <1412461.M3SMDGpi7Z@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar,

On Tuesday 29 October 2013 19:19:35 Kumar Gala wrote:
> On Oct 29, 2013, at 7:06 PM, Laurent Pinchart wrote:
> > On Tuesday 29 October 2013 18:36:06 Kumar Gala wrote:
> >> On Oct 29, 2013, at 9:55 AM, Laurent Pinchart wrote:
> >>> MSTP clocks are gate clocks controlled through a register that handles
> >>> up to 32 clocks. The register is often sparsely populated.
> >>> 
> >>> Those clocks are found on Renesas ARM SoCs.
> >>> 
> >>> Signed-off-by: Laurent Pinchart
> >>> <laurent.pinchart+renesas@ideasonboard.com>
> >>> ---
> >>> .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  47 +++++
> >>> drivers/clk/shmobile/Makefile                      |   1 +
> >>> drivers/clk/shmobile/clk-mstp.c                    | 229 +++++++++++++++
> >>> include/dt-bindings/clock/r8a7790-clock.h          |  56 +++++
> >>> 4 files changed, 333 insertions(+)
> >>> create mode 100644
> >>> Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> >>> create mode 100644 drivers/clk/shmobile/clk-mstp.c
> >>> create mode 100644 include/dt-bindings/clock/r8a7790-clock.h
> >>> 
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> >>> b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> >>> new
> >>> file mode 100644
> >>> index 0000000..b3a1ce0
> >>> --- /dev/null
> >>> +++
> >>> b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> >>> @@ -0,0 +1,47 @@
> >>> +* Renesas R8A7790 MSTP Clocks
> >> 
> >> can we spell out MSTP once in the heading?
> > 
> > Sure thing. It stands for Module Stop.
> > 
> >>> +
> >>> +The CPG can gate SoC device clocks. The gates are organized in groups
> >>> of> up to
> >>> +32 gates.
> >>> +
> >>> +This device tree binding describes a single 32 gate clocks group per
> >>> node.
> >>> +Clocks are referenced by user nodes by the MSTP node phandle and the
> >>> clock
> >>> +index in the group, from 0 to 31.
> >>> +
> >>> +Required Properties:
> >>> +
> >>> +  - compatible: Must be one of the following
> >>> +    - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate
> >>> clocks
> >>> +    - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
> >>> +  - reg: Base address and length of the memory resource used by the
> >>> MSTP
> >>> +    clocks
> >>> +  - clocks: Reference to the parent clocks
> >>> +  - #clock-cells: Must be 1
> >>> +  - clock-output-names: The name of the clocks as free-form strings
> >>> +  - renesas,indices: Index of the gate clocks (0 to 31)
> >> 
> >> Index of the gate clock into what?
> > 
> > Into the 32 gates clock group. Groups have 32 entries with a 32-bit
> > register that controls 32 gate clocks. The groups (and thus registers)
> > are sparsly populated, this property lists the indices for the register
> > bits corresponding to the clocks.
> > 
> > Would
> > 
> >  - renesas,indices: Indices of the gate clocks into the group (0 to 31)
> > 
> > be explicit enough ?
> 
> I'm still confused.  As I look at the code, I'm not quite clear how
> renesas,indices relates to a register or register bits.

OK, this probably means that the documentation isn't clear enough. Let me try 
to explain the situation, I'll then rephrase the bindings documentation.

Renesas SoCs have a large number of gate clocks, referred to as the MSTP 
clocks. Those gate clocks are controlled by a single bit each. From a control 
point of view, those bits are located in 32-bit registers referred to as the 
MSTP registers. Each MSTP register can thus control up to 32 gate clocks. As 
they are sparsely populated they usually control less than 32 gate clocks and 
have reserved bits for the clocks that are not present in the hardware. The 
reserved bits are randomly placed in the registers.

On the DT side, each MSTP register gets a DT node. The clocks handled by that 
register are listed in DT. The driver needs to map each clock to its bit index 
in the MSTP register. There are two main ways to do so:

- Specifying all 32 bits in the DT node, with 32 parent clocks and 32 clock 
output names. Reserved bits would get a dummy parent and an empty clock output 
name. The bit index would in that case be the clock index in the clock output 
names list with a one-to-one mapping between the clock cell and the clock 
index in the clock output names list.

- Specifying the available clocks only. No dummy parent clock and empty clock 
output name would be used. In that case there would be no one-to-one mapping 
between the clock cell and the corresponding clock index in the clock output 
names list. The mapping is then specified through the renesas,clock-indices 
property. Each entry in the property stores the bit number of the 
corresponding clock in the MSTP register.

Let's take MSTP3 of the R8A7790 as an example. The register controls the 
following clocks:

0		IIC2
1-3		Reserved
4		TPU0
5		MMC1
6-9		Reserved
10		IrDA
11		SDHI3
12		SDHI2
13		SDHI1
14		SDHI0
15		MMC0
16-17	Reserved
18		IIC0
19		PCIEC
20-22	Reserved
23		IIC1
24-27	Reserved
28		SSUSB
29		CMT1
30		USBDMAC0
31		USBDMAC1

The corresponding DT node would thus have the following properties

		clock-output-names =
			"iic2", "tpu0", "mmcif1", "irda", "sdhi3", "sdhi2", "sdhi1",
			"sdhi0", "mmcif0", "iic0", "pciec", "iic1", "ssusb", "cmt1",
			"usbdmac0", "usbcma1";
		renesas,clock-indices = <
				0 4 5 10 11 12 13 14 15 18 19 23 28 29 30 31
		>

The clock cell in clock users corresponds to the hardware bit index, not the 
index of the clock in the clock output names list. To make referencing clocks 
less error-prone, macros are defined for all bit indices in <dt-
bindings/clock/r8a7790-clock.h>. Using this macros in the provider, we get

		renesas,clock-indices = <
				R8A7790_CLK_IIC0 R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1
				R8A7790_CLK_IRDA R8A7790_CLK_SDHI3 R8A7790_CLK_SDHI2
				R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0 R8A7790_CLK_MMCIF0
				R8A7790_CLK_IIC0 R8A7790_CLK_PCIEC R8A7790_CLK_IIC1
				R8A7790_CLK_SSUSB R8A7790_CLK_CMT1 R8A7790_CLK_USBDMAC0
				R8A7790_CLK_USBDMAC1
		>;

Is the explanation clear enough ?

> >>> +
> >>> +The clocks, clock-output-names and renesas,indices properties contain
> >>> one
> >>> +entry per gate. The MSTP groups are sparsely populated. Unimplemented
> >>> gates
> >> 
> >> per gate clock. (?)
> > 
> > I'll change that.
> > 
> >>> +must not be declared.
> >>> +
> >>> +
> >>> +Example
> >>> +-------
> >>> +
> >>> +	#include <dt-bindings/clock/r8a7790-clock.h>
> >>> +
> >>> +	mstp3_clks: mstp3_clks {
> > 
> > mstp3_clks at e615013c I suppose.
> 
> yes, missed that
> `
> 
> >>> +		compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-
> > 
> > clocks";
> > 
> >>> +		reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
> >>> +		clocks = <&cp_clk>, <&mmc1_clk>, <&sd3_clk>, <&sd2_clk>,
> >>> +			 <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks
> > 
> > R8A7790_CLK_SD0>,
> > 
> >>> +			 <&mmc0_clk>;
> >>> +		#clock-cells = <1>;
> >>> +		clock-output-names =
> >>> +			"tpu0", "mmcif1", "sdhi3", "sdhi2",
> >>> +			 "sdhi1", "sdhi0", "mmcif0";
> >>> +		renesas,clock-indices = <
> >>> +			R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
> >>> +			R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
> >>> +			R8A7790_CLK_MMCIF0
> >>> +		>;
> >>> +	};
-- 
Regards,

Laurent Pinchart
