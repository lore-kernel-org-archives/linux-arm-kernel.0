From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 26 Jul 2011 10:43:55 +0800
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <20110725204630.GD26735@ponder.secretlab.ca>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
Message-ID: <20110726024354.GI21641@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 02:46:30PM -0600, Grant Likely wrote:
> On Mon, Jul 25, 2011 at 11:07:46PM +0800, Shawn Guo wrote:
> > It adds function mxc_iomuxc_dt_init() to parse iomuxc pad configuration
> > from device tree.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  .../devicetree/bindings/arm/fsl/iomuxc.txt         |   47 +++++++++++++
> >  arch/arm/mach-mx5/Makefile                         |    2 +
> >  arch/arm/mach-mx5/iomuxc-dt.c                      |   72 ++++++++++++++++++++
> >  arch/arm/plat-mxc/include/mach/common.h            |    3 +
> >  4 files changed, 124 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/fsl/iomuxc.txt
> >  create mode 100644 arch/arm/mach-mx5/iomuxc-dt.c
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl/iomuxc.txt b/Documentation/devicetree/bindings/arm/fsl/iomuxc.txt
> > new file mode 100644
> > index 0000000..ae9292b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/fsl/iomuxc.txt
> > @@ -0,0 +1,47 @@
> > +* Freescale i.MX IOMUX Controller (IOMUXC)
> > +
> > +Required properties:
> > +- compatible : "fsl,<soc>-iomuxc";
> > +
> > +Sub-nodes present individual PAD configuration, and node name is the
> > +PAD name given by hardware document.
> > +
> > +Required properties:
> > +- reg : Should contain the offset of registers
> > +  IOMUXC_SW_MUX_CTL_PAD_<pad-name> and IOMUXC_SW_PAD_CTL_PAD_<pad-name>.
> > +- fsl,iomuxc-mux-mode : Should specify the MUX_MODE setting of register
> > +  IOMUXC_SW_MUX_CTL_PAD_<pad-name>.
> > +
> > +Optional properties:
> > +- fsl,iomuxc-sion : Indicates that bit SION of register
> > +  IOMUXC_SW_MUX_CTL_PAD_<pad-name> needs to be set for given MUX_MODE
> > +  setting of the PAD.
> > +- fsl,iomuxc-select-input : Specify the offset of register
> > +  IOMUXC_<...>_SELECT_INPUT and the value of bit-field DAISY for given
> > +  MUX_MODE setting of the PAD.
> 
> This could get really verbose in a really big hurry.  Fortunately the
> dtb format is sophisticated enough to only store each unique property
> name once, so the data shouldn't be huge, but it is still going to
> make for huge source files.  Can you think of a more concise

We have hundreds of real PADs on real SoC.  If we are trying to
describe real hard on dts its own, dts has to be big.

> representation?
> 
> The current linux code has each pin config simply a u64.  Now, an
> engineer certainly wouldn't be asked to write raw u64 values, but we
> could add some form of #define or macro syntax to dtc so that the
> symbolic names currently used in the board.c file would continue to
> work.

I was told that the binding should not be bonded to Linux
implementation.  Now I'm told to go the opposite direction? ;)

> Alternately, we could just make each pin configuration a string
> that can be parsed by the kernel at runtime.  A string would certainly
> be the most extensible, at the cost of some more init code in the
> kernel.
> 
> Something along the lines of:
> 	iomuxc at 53fa8000 {
> 		compatible = "fsl,imx53-iomuxc"
> 		fsl,iomux-pads = "csi0-dat10,uart1-txd",
> 				"csi0-dat11,uart1-rxd",
> 				...;
> 	};
> 
Specifying string in dts, and then parsing the string, mapping it to
one of the huge MX53_PAD_ definition in kernel init code?

One thing I'm trying to do is to replace those huge iomux-mx*.h headers
with dts binding, and then get rid of those headers from Linux tree.
I guess moving those huge hardware details that kernel does not care
to dts is one goal of device tree support, no?

> Or if you prefer doing the parsing in dtc:
> 	iomuxc at 53fa8000 {
> 		compatible = "fsl,imx53-iomuxc"
> 		fsl,iomux-pads = <MX53_PAD_CSI0_DAT10__UART1_TXD_MUX
> 				  MX53_PAD_CSI0_DAT11__UART2_RXD_MUX
> 				  ...
> 				  >;
> 	};
> 
> And we'd need a syntax for the macros.  However, right now
> iomux-mx53.h is *huge*, which I'm not hugely keen on also bringing
> into DTC...  but there might just not be any good way around that
> because pinmux configuration is by definition complexe.  It would
> certainly be better to be pre-processing that large data block in dtc
> rather than trying to encode the whole thing into kernel setup code.
> 
We end up with continuing maintaining those huge iomux-mx*.h headers
in kernel tree.

Getting kernel tree cleaned-up is one major reason why we are doing
device tree.  But I feel you are trying to make dts clean and leave
the 'crap' stay in kernel tree.

> A third option would be to create the pinmux table in C code with gcc and
> objdump, and include it into the dtb with a /bin-inc/ statement.  That
> option would work right now without having to change the format of the
> iomux #defines.
> 
This seems working for me.  But it still has the problem of being
bonded to Linux implementation, and it's not easy to change pad setting
for debugging.

Overall, I'm not convinced that any of these 3 options is better than
what I have right now :)

-- 
Regards,
Shawn
