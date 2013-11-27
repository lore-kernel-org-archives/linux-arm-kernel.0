From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Nov 2013 02:30:03 +0100
Subject: [PATCH v3 3/8] clk: shmobile: Add MSTP clock support
In-Reply-To: <2936776.W2YYB2sEWe@avalon>
References: <1384872347-11724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131119181936.GR5914@e106331-lin.cambridge.arm.com>
 <2936776.W2YYB2sEWe@avalon>
Message-ID: <1446370.Z0Dk5p9vtm@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

I'd like to send v4 of this series soon, hopefully for the last time. Would 
you be able to reply to the two issues that are still left and discussed below 
? That would be really appreciated.

On Wednesday 20 November 2013 22:54:58 Laurent Pinchart wrote:
> On Tuesday 19 November 2013 18:19:36 Mark Rutland wrote:
> > On Tue, Nov 19, 2013 at 05:00:40PM +0000, Laurent Pinchart wrote:
> > > On Tuesday 19 November 2013 16:28:21 Mark Rutland wrote:
> > > > On Tue, Nov 19, 2013 at 02:45:42PM +0000, Laurent Pinchart wrote:
> > > > > MSTP clocks are gate clocks controlled through a register that
> > > > > handles up to 32 clocks. The register is often sparsely populated.
> > > > 
> > > > Does that mean some clocks aren't wired up, or that some clocks don't
> > > > exist at all?
> > > 
> > > It means that some of the bits don't control anything.
> > > 
> > > > What is the behaviour of the unpopulated bits?
> > > 
> > > According to the datasheet they're reserved, read-only, and read an
> > > unspecified value that is to be written back without modification when
> > > writing the register.
> > 
> > Ok.
> > 
> > > > > Those clocks are found on Renesas ARM SoCs.
> > > > > 
> > > > > Cc: devicetree at vger.kernel.org
> > > > > Signed-off-by: Laurent Pinchart
> > > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > > ---
> > > > > 
> > > > >  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  48 +++++
> > > > >  drivers/clk/shmobile/Makefile                      |   1 +
> > > > >  drivers/clk/shmobile/clk-mstp.c                    | 229 ++++++++++
> > > > >  3 files changed, 278 insertions(+)
> > > > >  create mode 100644
> > > > >  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > > > >  create mode 100644 drivers/clk/shmobile/clk-mstp.c
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-
> > > > > clocks.txt
> > > > > b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-
> > > > > clocks.txt
> > > > > new file mode 100644
> > > > > index 0000000..126b17e
> > > > > --- /dev/null
> > > > > +++
> > > > > b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-
> > > > > clocks.txt
> > > > > @@ -0,0 +1,48 @@
> > > > > +* Renesas CPG Module Stop (MSTP) Clocks
> > > > > +
> > > > > +The CPG can gate SoC device clocks. The gates are organized in
> > > > > groups of up to
> > > > > +32 gates.
> > > > > +
> > > > > +This device tree binding describes a single 32 gate clocks group
> > > > > per node.
> > > > > +Clocks are referenced by user nodes by the MSTP node phandle and
> > > > > the clock
> > > > > +index in the group, from 0 to 31.
> > > > > +
> > > > > +Required Properties:
> > > > > +
> > > > > +  - compatible: Must be one of the following
> > > > > +    - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP
> > > > > gate clocks
> > > > > +    - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP
> > > > > gate clocks
> > > > > +    - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
> > > > > +  - reg: Base address and length of the memory resource used by the
> > > > > MSTP
> > > > > +    clocks
> > > > 
> > > > There are two entries in the example, the code seems to assume they
> > > > are particular registers, but this implies one.
> > > 
> > > There can be one or two registers, depending on the hardware. The first
> > > register is always required and controls the clocks, the second register
> > > is optional (in the sense that it's not implemented for some of the MSTP
> > > instances) and reports the clock status.
> > 
> > Ok. The documentation should note this.
> 
> What about
> 
>   - reg: Base address and length of the I/O mapped registers used by the
> MSTP clocks. The first register is the clock control register and is
> mandatory. The second register is the clock status register and is optional
> when not implemented in hardware.
> 
> > > > Are these not part of a larger bank of registers?
> > > 
> > > They are. Here's the memory map for the r8a7791 for instance.
> > > 
> > > MSTPSR0		H'E615 0030
> > > MSTPSR1		H'E615 0038
> > > MSTPSR2		H'E615 0040
> > > MSTPSR3		H'E615 0048
> > > MSTPSR4		H'E615 004C
> > > MSTPSR5		H'E615 003C
> > > MSTPSR6		H'E615 01C0
> > > MSTPSR7		H'E615 01C4
> > > MSTPSR8		H'E615 09A0
> > > MSTPSR9		H'E615 09A4
> > > MSTPSR10		H'E615 09A8
> > > MSTPSR11		H'E615 09AC
> > > 
> > > SMSTPCR0		H'E615 0130
> > > SMSTPCR1		H'E615 0134
> > > SMSTPCR2		H'E615 0138
> > > SMSTPCR3		H'E615 013C
> > > SMSTPCR4		H'E615 0140
> > > SMSTPCR5		H'E615 0144
> > > SMSTPCR6		H'E615 0148
> > > SMSTPCR7		H'E615 014C
> > > SMSTPCR8		H'E615 0990
> > > SMSTPCR9		H'E615 0994
> > > SMSTPCR10		H'E615 0998
> > > SMSTPCR11		H'E615 099C
> > > 
> > > I've pondered whether we should use a single device node for all the
> > > MSTP clocks, but I don't think it would be very practical. Not only
> > > would we need to encode all bit positions, we also would have to encode
> > > register offsets in DT. This would become pretty messy in a single node.
> > > 
> > > > > +  - clocks: Reference to the parent clocks
> > > > 
> > > > How many, and what do they correspond to?
> > > 
> > > What about
> > > 
> > > - clocks: Reference to the parent clocks, one per output clock. The
> > > parents must appear in the same order as the output clocks.
> > 
> > That sounds reasonable.
> > 
> > > > > +  - #clock-cells: Must be 1
> > > > > +  - clock-output-names: The name of the clocks as free-form strings
> > > > > +  - renesas,indices: Indices of the gate clocks into the group (0
> > > > > to 31)
> > > > 
> > > > The description of this property doesn't describe half of what it
> > > > means. I believe something like the below does:
> > > > 
> > > > - renesas,indices: A list of clock IDs (single cells), one for each
> > > >   clock present. Each entry may correspond to a clock-output-names
> > > >   entry at the same index, and its location in the list defines the
> > > >   corresponding clock-specifier for the entry.
> > > 
> > > I might be mistaken, but doesn't "its location in the list defines the
> > > corresponding clock-specifier for the entry" imply that clock specifiers
> > > use the location in the list as the clock ID instead of the numerical
> > > value of the indices entry ? Each entry in the renesas,indices list
> > > corresponds to one clocks entry and one clock-output-names entry, and
> > > clock users reference an MSTP clock using the value of its indices
> > > entry, not the position of the entry.
> > 
> > Sorry, the code confused me. Having read over it again, I'm even more
> > confused.
> > 
> > You said the registers were sparesly populated, but the code assumes
> > that the bits start at 0 and the set of populated bits are contiguous,
> > which is not what I would describe that as sparse. Are the bits always
> > contiguous?
> 
> They're not, and the code doesn't assume so. The driver loops over all the
> clocks using the position in the renesas,indices array as the loop counter
> i. It then retrieves the output name, the parent and the index and
> registers the clock. When registration succeeds, the clock is stored in the
> clks array at the index corresponding to the renesas,indices value. The
> clks array is thus sparsely populated, exactly as the MSTP register.
> 
> > I thought the bits in the register were truly sparse (i.e. you could
> > have two bits which were at either end of the register), and the indices
> > property allowed you to define the set of bits which were valid.
> > 
> > As far as I can see from cpg_mstp_clocks_init and
> > cpg_mstp_clock_register, the indices property assings the set of IDs for
> > consumers to use, and I don't see what the point of that is if we
> > already have a well-defined linear index (the bit position in the
> > register) which we could use instead, which also makes the binding and
> > code simpler.
> > 
> > > > I'd imagine we have a few sparse clocks by now, and we might be able
> > > > to make this more uniform. But I may be mistaken.
> > > > 
> > > > [...]
> > > > 
> > > > > +static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
> > > > > +{
> > > > > +	struct mstp_clock *clock = to_mstp_clock(hw);
> > > > > +	struct mstp_clock_group *group = clock->group;
> > > > > +	u32 bitmask = BIT(clock->bit_index);
> > > > > +	unsigned long flags;
> > > > > +	unsigned int i;
> > > > > +	u32 value;
> > > > > +
> > > > > +	spin_lock_irqsave(&group->lock, flags);
> > > > > +
> > > > > +	value = clk_readl(group->smstpcr);
> > > > > +	if (enable)
> > > > > +		value &= ~bitmask;
> > > > > +	else
> > > > > +		value |= bitmask;
> > > > > +	clk_writel(value, group->smstpcr);
> > > > > +
> > > > > +	spin_unlock_irqrestore(&group->lock, flags);
> > > > > +
> > > > > +	if (!enable || !group->mstpsr)
> > > > > +		return 0;
> > > > > +
> > > > > +	for (i = 1000; i > 0; --i) {
> > > > > +		if (!(clk_readl(group->mstpsr) & bitmask))
> > > > > +			break;
> > > > > +		cpu_relax();
> > > > > +	}
> > > > 
> > > > Any particular reason for 1000 times? Is there a known minimum time to
> > > > switch a clock between disabled and enabled? A comment would be nice.
> > > 
> > > There's no particular reason, the datasheet doesn't provide any useful
> > > information. I've just copied that value from existing C code.
> > 
> > Any chance it might work without?
> 
> Yes, with roughly a 75% chance :-) Without this look I get a crash around
> once every four times with the video processing devices. Other devices are
> affected as well, but delays in their respective drivers hide the problem.

-- 
Regards,

Laurent Pinchart
