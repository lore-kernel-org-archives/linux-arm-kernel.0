From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 29 Oct 2013 19:19:35 -0500
Subject: [PATCH 2/3] clk: shmobile: Add MSTP clock support
In-Reply-To: <1481817.doGcO1nQB0@avalon>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383058511-26046-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <F8268ACF-E4E8-4411-84F1-D967450BE440@codeaurora.org>
 <1481817.doGcO1nQB0@avalon>
Message-ID: <5E542DCC-EA79-4A9E-BC60-B8E1B964F16D@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 29, 2013, at 7:06 PM, Laurent Pinchart wrote:

> Hi Kumar,
> 
> Thank you for the review.
> 
> On Tuesday 29 October 2013 18:36:06 Kumar Gala wrote:
>> On Oct 29, 2013, at 9:55 AM, Laurent Pinchart wrote:
>>> MSTP clocks are gate clocks controlled through a register that handles
>>> up to 32 clocks. The register is often sparsely populated.
>>> 
>>> Those clocks are found on Renesas ARM SoCs.
>>> 
>>> Signed-off-by: Laurent Pinchart
>>> <laurent.pinchart+renesas@ideasonboard.com>
>>> ---
>>> .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  47 +++++
>>> drivers/clk/shmobile/Makefile                      |   1 +
>>> drivers/clk/shmobile/clk-mstp.c                    | 229 +++++++++++++++++
>>> include/dt-bindings/clock/r8a7790-clock.h          |  56 +++++
>>> 4 files changed, 333 insertions(+)
>>> create mode 100644
>>> Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
>>> create mode 100644 drivers/clk/shmobile/clk-mstp.c
>>> create mode 100644 include/dt-bindings/clock/r8a7790-clock.h
>>> 
>>> diff --git
>>> a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
>>> b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt new
>>> file mode 100644
>>> index 0000000..b3a1ce0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
>>> @@ -0,0 +1,47 @@
>>> +* Renesas R8A7790 MSTP Clocks
>> 
>> can we spell out MSTP once in the heading?
> 
> Sure thing. It stands for Module Stop.
> 
>>> +
>>> +The CPG can gate SoC device clocks. The gates are organized in groups of
>>> up to
>>> +32 gates.
>>> +
>>> +This device tree binding describes a single 32 gate clocks group per
>>> node.
>>> +Clocks are referenced by user nodes by the MSTP node phandle and the
>>> clock
>>> +index in the group, from 0 to 31.
>>> +
>>> +Required Properties:
>>> +
>>> +  - compatible: Must be one of the following
>>> +    - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate
>>> clocks
>>> +    - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
>>> +  - reg: Base address and length of the memory resource used by the MSTP
>>> +    clocks
>>> +  - clocks: Reference to the parent clocks
>>> +  - #clock-cells: Must be 1
>>> +  - clock-output-names: The name of the clocks as free-form strings
>>> +  - renesas,indices: Index of the gate clocks (0 to 31)
>> 
>> Index of the gate clock into what?
> 
> Into the 32 gates clock group. Groups have 32 entries with a 32-bit register 
> that controls 32 gate clocks. The groups (and thus registers) are sparsly 
> populated, this property lists the indices for the register bits corresponding 
> to the clocks.
> 
> Would
> 
>  - renesas,indices: Indices of the gate clocks into the group (0 to 31)
> 
> be explicit enough ?

I'm still confused.  As I look at the code, I'm not quite clear how renesas,indices relates to a register or register bits.

> 
>>> +
>>> +The clocks, clock-output-names and renesas,indices properties contain one
>>> +entry per gate. The MSTP groups are sparsely populated. Unimplemented
>>> gates
>> per gate clock. (?)
> 
> I'll change that.
> 
>>> +must not be declared.
>>> +
>>> +
>>> +Example
>>> +-------
>>> +
>>> +	#include <dt-bindings/clock/r8a7790-clock.h>
>>> +
>>> +	mstp3_clks: mstp3_clks {
> 
> mstp3_clks at e615013c I suppose.

yes, missed that
`
> 
>>> +		compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-
> clocks";
>>> +		reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
>>> +		clocks = <&cp_clk>, <&mmc1_clk>, <&sd3_clk>, <&sd2_clk>,
>>> +			 <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks 
> R8A7790_CLK_SD0>,
>>> +			 <&mmc0_clk>;
>>> +		#clock-cells = <1>;
>>> +		clock-output-names =
>>> +			"tpu0", "mmcif1", "sdhi3", "sdhi2",
>>> +			 "sdhi1", "sdhi0", "mmcif0";
>>> +		renesas,clock-indices = <
>>> +			R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
>>> +			R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
>>> +			R8A7790_CLK_MMCIF0
>>> +		>;
>>> +	};
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
