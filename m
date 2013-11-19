From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Nov 2013 16:28:21 +0000
Subject: [PATCH v3 3/8] clk: shmobile: Add MSTP clock support
In-Reply-To: <1384872347-11724-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384872347-11724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1384872347-11724-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131119162821.GQ5914@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 02:45:42PM +0000, Laurent Pinchart wrote:
> MSTP clocks are gate clocks controlled through a register that handles
> up to 32 clocks. The register is often sparsely populated.

Does that mean some clocks aren't wired up, or that some clocks don't
exist at all?

What is the behaviour of the unpopulated bits?

> 
> Those clocks are found on Renesas ARM SoCs.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  48 +++++
>  drivers/clk/shmobile/Makefile                      |   1 +
>  drivers/clk/shmobile/clk-mstp.c                    | 229 +++++++++++++++++++++
>  3 files changed, 278 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
>  create mode 100644 drivers/clk/shmobile/clk-mstp.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> new file mode 100644
> index 0000000..126b17e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -0,0 +1,48 @@
> +* Renesas CPG Module Stop (MSTP) Clocks
> +
> +The CPG can gate SoC device clocks. The gates are organized in groups of up to
> +32 gates.
> +
> +This device tree binding describes a single 32 gate clocks group per node.
> +Clocks are referenced by user nodes by the MSTP node phandle and the clock
> +index in the group, from 0 to 31.
> +
> +Required Properties:
> +
> +  - compatible: Must be one of the following
> +    - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
> +    - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
> +    - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
> +  - reg: Base address and length of the memory resource used by the MSTP
> +    clocks

There are two entries in the example, the code seems to assume they are
particular registers, but this implies one.

Are these not part of a larger bank of registers?

> +  - clocks: Reference to the parent clocks

How many, and what do they correspond to?

> +  - #clock-cells: Must be 1
> +  - clock-output-names: The name of the clocks as free-form strings
> +  - renesas,indices: Indices of the gate clocks into the group (0 to 31)

The description of this property doesn't describe half of what it means.
I believe something like the below does:

- renesas,indices: A list of clock IDs (single cells), one for each
  clock present. Each entry may correspond to a clock-output-names entry
  at the same index, and its location in the list defines the
  corresponding clock-specifier for the entry.

I'd imagine we have a few sparse clocks by now, and we might be able to
make this more uniform. But I may be mistaken.

[...]

> +static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
> +{
> +	struct mstp_clock *clock = to_mstp_clock(hw);
> +	struct mstp_clock_group *group = clock->group;
> +	u32 bitmask = BIT(clock->bit_index);
> +	unsigned long flags;
> +	unsigned int i;
> +	u32 value;
> +
> +	spin_lock_irqsave(&group->lock, flags);
> +
> +	value = clk_readl(group->smstpcr);
> +	if (enable)
> +		value &= ~bitmask;
> +	else
> +		value |= bitmask;
> +	clk_writel(value, group->smstpcr);
> +
> +	spin_unlock_irqrestore(&group->lock, flags);
> +
> +	if (!enable || !group->mstpsr)
> +		return 0;
> +
> +	for (i = 1000; i > 0; --i) {
> +		if (!(clk_readl(group->mstpsr) & bitmask))
> +			break;
> +		cpu_relax();
> +	}

Any particular reason for 1000 times? Is there a known minimum time to
switch a clock between disabled and enabled? A comment would be nice.

Cheers,
Mark.
