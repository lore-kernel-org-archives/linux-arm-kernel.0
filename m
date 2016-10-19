From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 19 Oct 2016 13:13:01 +0200
Subject: [RFC PATCH] mtd: nand: Add OX820 NAND Support
In-Reply-To: <37a5b543-e564-a496-d5cf-c215e798839f@baylibre.com>
References: <20161018090927.1990-1-narmstrong@baylibre.com>
 <20161018221744.5e574e82@bbrezillon>
 <37a5b543-e564-a496-d5cf-c215e798839f@baylibre.com>
Message-ID: <20161019131301.19c7a64d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Oct 2016 11:29:59 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> Hi Boris,
> 
> On 10/18/2016 10:17 PM, Boris Brezillon wrote:
> > Hi Neil,
> > 
> > On Tue, 18 Oct 2016 11:09:27 +0200
> > Neil Armstrong <narmstrong@baylibre.com> wrote:
> >   
> >> Add NAND driver to support the Oxford Semiconductor OX820 NAND Controller.
> >> This is a simple memory mapped NAND controller with single chip select and
> >> software ECC.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  .../devicetree/bindings/mtd/oxnas-nand.txt         |  24 ++++
> >>  drivers/mtd/nand/Kconfig                           |   5 +
> >>  drivers/mtd/nand/Makefile                          |   1 +
> >>  drivers/mtd/nand/oxnas_nand.c                      | 144 +++++++++++++++++++++
> >>  4 files changed, 174 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mtd/oxnas-nand.txt
> >>  create mode 100644 drivers/mtd/nand/oxnas_nand.c
> >>
> >> diff --git a/Documentation/devicetree/bindings/mtd/oxnas-nand.txt b/Documentation/devicetree/bindings/mtd/oxnas-nand.txt
> >> new file mode 100644
> >> index 0000000..83b684d
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mtd/oxnas-nand.txt
> >> @@ -0,0 +1,24 @@
> >> +* Oxford Semiconductor OXNAS NAND Controller
> >> +
> >> +Please refer to nand.txt for generic information regarding MTD NAND bindings.
> >> +
> >> +Required properties:
> >> + - compatible: "oxsemi,ox820-nand"
> >> + - reg: Base address and length for NAND mapped memory.
> >> +
> >> +Optional Properties:
> >> + - clocks: phandle to the NAND gate clock if needed.
> >> + - resets: phandle to the NAND reset control if needed.
> >> +
> >> +Example:
> >> +
> >> +nand: nand at 41000000 {
> >> +	compatible = "oxsemi,ox820-nand";
> >> +	reg = <0x41000000 0x100000>;
> >> +	nand-ecc-mode = "soft";
> >> +	clocks = <&stdclk CLK_820_NAND>;
> >> +	resets = <&reset RESET_NAND>;
> >> +	#address-cells = <1>;
> >> +	#size-cells = <1>;
> >> +	status = "disabled";
> >> +};  
> > 
> > Can you switch to new DT representation for NAND controllers, with one
> > node for the NAND controller and NAND devices connected to this NAND
> > controller defined as sub-nodes of this NAND controller [1]?  
> 
> Yes, I was wondering if this existed... my bad, next time I will search further.

No problem. That's what reviews are here for ;-).

[...]
> >> diff --git a/drivers/mtd/nand/oxnas_nand.c b/drivers/mtd/nand/oxnas_nand.c

[...]

> >> +
> >> +/* nand commands */
> >> +#define NAND_CMD_ALE		BIT(18)
> >> +#define NAND_CMD_CLE		BIT(19)
> >> +#define NAND_CMD_CS		0  
> > 
> > I guess this is zero here because you only support connecting a NAND to
> > CS0.
> > It's probably something like
> > 
> > OX820_NAND_CS(x)		((x) << CS_FIELD_SHIFT)  
> 
> The hardware seems to be able to drive multiple chip selects, but no implementation does this.
> We will stick to CS0 only here for test reasons.

Then no need to define this _CS flag.

[...]

> >> +	data->chip.cmd_ctrl = oxnas_nand_cmd_ctrl;
> >> +	data->chip.chip_delay = 30;
> >> +	data->chip.ecc.mode = NAND_ECC_SOFT;
> >> +	data->chip.ecc.algo = NAND_ECC_HAMMING;  
> > 
> > Probably a good idea to support soft ECC as well...  

I meant BCH, not soft :-).

> 
> This was taken from plat_nand.c, I was not sure if it was necessary, will remove this and rely on DT attributes.

Yes, that's probably the best solution.

Regards,

Boris
