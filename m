From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 27 Jul 2011 00:39:48 +0800
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <20110726063144.GA20587@pengutronix.de>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110726063144.GA20587@pengutronix.de>
Message-ID: <20110726163947.GC19600@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 08:31:44AM +0200, Sascha Hauer wrote:
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
> > +
> > +Examples:
> > +
> > +iomuxc at 53fa8000 {
> > +	#address-cells = <2>;
> > +	#size-cells = <0>;
> > +	compatible = "fsl,imx53-iomuxc";
> > +	reg = <0x53fa8000 0x4000>;
> > +
> > +	/*
> > +	 * I2C2
> > +	 */
> > +	key-col3 { /* I2C2_SCL */
> > +		reg = <0x3c 0x364>;
> > +		fsl,iomuxc-mux-mode = <4>;
> > +		fsl,iomuxc-sion;
> > +		fsl,iomuxc-select-input = <0x81c 0x0>;
> > +	};
> > +
> > +	key-row3 { /* I2C2_SDA */
> > +		reg = <0x40 0x368>;
> > +		fsl,iomuxc-mux-mode = <4>;
> > +		fsl,iomuxc-sion;
> > +		fsl,iomuxc-select-input = <0x820 0x0>;
> > +	};
> > +};
> 
> If we want to move the iomux setting to the device tree, wouldn't it be
> necessary to find some format which can be shared across different
> platforms? At least all i.MXs should be covered.
> 
Right now, I really just focus on iomux-v3.  After people buy in this
approach, we can start see how iomux-v1 will fit in.  It's not so
urgent before we actually start converting those old i.mx platforms
(iomux-v1 users) to device tree.

-- 
Regards,
Shawn
