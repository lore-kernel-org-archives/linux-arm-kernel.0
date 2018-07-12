From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 12 Jul 2018 11:04:25 +0000
Subject: [PATCH V4 4/5] dt-bindings: arm: fsl: add scu binding doc
In-Reply-To: <20180711150854.GA27284@rob-hp-laptop>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-5-git-send-email-aisheng.dong@nxp.com>
 <20180711150854.GA27284@rob-hp-laptop>
Message-ID: <AM0PR04MB4211AA666FA4521E309E475080590@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Wednesday, July 11, 2018 11:09 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com;
> kernel at pengutronix.de; shawnguo at kernel.org; Fabio Estevam
> <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; Mark
> Rutland <mark.rutland@arm.com>; devicetree at vger.kernel.org
> Subject: Re: [PATCH V4 4/5] dt-bindings: arm: fsl: add scu binding doc
> 
> On Sun, Jul 08, 2018 at 10:56:56PM +0800, Dong Aisheng wrote:
> > The System Controller Firmware (SCFW) is a low-level system function
> > which runs on a dedicated Cortex-M core to provide power, clock, and
> > resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> > (QM, QP), and i.MX8QX (QXP, DX).
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > v3->v4:
> >  * fully change to mailbox binding
> >  * add child node description
> > v2->v3:
> >  * update a bit to mailbox binding
> > v1->v2:
> >  * remove status
> >  * changed to mu1
> > ---
> >  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 65
> > ++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > new file mode 100644
> > index 0000000..11e732a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > @@ -0,0 +1,65 @@
> > +NXP i.MX System Controller Firmware (SCFW)
> > +--------------------------------------------------------------------
> > +
> > +The System Controller Firmware (SCFW) is a low-level system function
> > +which runs on a dedicated Cortex-M core to provide power, clock, and
> > +resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> > +(QM, QP), and i.MX8QX (QXP, DX).
> > +
> > +The AP communicates with the SC using a multi-ported MU module found
> > +in the LSIO subsystem. The current definition of this MU module
> > +provides
> > +5 remote AP connections to the SC to support up to 5 execution
> > +environments (TZ, HV, standard Linux, etc.). The SC side of this MU
> > +module interfaces with the LSIO DSC IP bus. The SC firmware will
> > +communicate with this MU using the MSI bus.
> > +
> > +System Controller Device Node:
> > +=============================
> 
> Need to specify this is a child of /firmware node.
> 

Got it.

> > +
> > +Required properties:
> > +-------------------
> > +- compatible: should be "fsl,imx-scu"
> > +- mboxes: List of phandle of MU mailbox. Should be one of LSIO
> > +	  MU0~M4 for imx8qxp and imx8qm. Users need to make
> > +	  sure not use the one which is conflict with other
> > +	  execution environments. e.g. ATF.
> > +
> > +Examples:
> > +--------
> > +lsio_mu1: mailbox at 5d1c0000 {
> > +	compatible = "fsl,imx8qxp-mu";
> > +	reg = <0x0 0x5d1c0000 0x0 0x10000>;
> > +	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> > +	#mbox-cells = <0>;
> > +};
> > +
> > +scu {
> > +	compatible = "fsl,imx-scu";
> > +	mboxes = <&lsio_mu1>;
> > +};
> > +
> > +
> > +i.MX SCU Client Device Node:
> > +=========================
> > +
> > +Client nodes are maintained as children of the relevant IMX-SCU device
> node.
> > +
> > +Example (imx8qxp):
> > +-------------
> > +scu {
> > +	compatible = "fsl,imx-scu";
> > +	...
> > +
> > +	clk: clk {
> > +		...
> > +	};
> > +
> > +	iomuxc: iomuxc {
> > +		...
> > +	};
> > +
> > +	imx8qx-pm {
> > +		...
> > +	}
> > +	...
> 
> If you plan to have child nodes, you need to document them now. However,
> other than pinctrl, you probably don't need child nodes. The parent node can
> be a clock and power-domain provider.
> 

Sorry I did not get the point.
This is referred to what TI does (arm scpi binding seems similar):
Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
Documentation/devicetree/bindings/clock/ti,sci-clk.txt

arch/arm/boot/dts/keystone-k2g.dtsi
pmmc: pmmc at 2921c00 {
        compatible = "ti,k2g-sci";
	....

        k2g_pds: power-controller {
                compatible = "ti,sci-pm-domain";
                #power-domain-cells = <1>;
        };

        k2g_clks: clocks {
                compatible = "ti,k2g-sci-clk";
                #clock-cells = <2>;
        };

        k2g_reset: reset-controller {
                compatible = "ti,sci-reset";
                #reset-cells = <2>;
        };
};

For i.MX SCU, it's quite similar:
firmware {
        scu {
                compatible = "fsl,imx-scu";
                mboxes = <&lsio_mu1>;

                clk: clk {
                        compatible = "fsl,imx8qxp-clk";
                        #clock-cells = <1>;
                        mboxes = <&lsio_mu2>; //optinoal
                };

                iomuxc: iomuxc {
                        compatible = "fsl,imx8qxp-iomuxc";
                        fsl,mu = <&lsio_mu3>; //optinoal
                };

                imx8qx-pm {
                        compatible = "fsl,scu-pd";
                        #address-cells = <1>;
                        #size-cells = <0>;
                        fsl,mu = <&lsio_mu4>; //optinoal

                        pd_lsio: PD_LSIO {
                                #power-domain-cells = <0>;
                                #address-cells = <1>;
                                #size-cells = <0>;

                                pd_lsio_pwm0: lsio_pwm0 at SC_R_PWM_0 {
                                        reg = <SC_R_PWM_0>;
                                        #power-domain-cells = <0>;
                                        power-domains = <&pd_lsio>;
                                };
                                ...
                        };

                        pd_dma: dma_power_domain {
                                #power-domain-cells = <0>;
                                #address-cells = <1>;
                                #size-cells = <0>;
                        };
                        ...
                };

                other_funcs {
                        compatible = "xxx";
                        ...
                };
        };
};

1. The child allows to specify a different mbox to use (planned optional)
2. we have separate clk, pinctrl, power domain drivers and etc.
3. we need define child pd nodes under the power domain node

Am I understanding correct that you are saying we can merge the clk and pd
driver into scu driver then scu behaviors both clk and pd provider?
It means we need implement both clk driver and pd driver in scu driver
which may bloat the scu driver a lot and make us no able to specify different
mbox for subnodes.
And clk driver has a lot clock type definitions which is under clock drivers.
Not sure suitable to be moved into scu.
See:
https://patchwork.ozlabs.org/cover/905920/

It will be like:
firmware {                              
        scu {                           
                compatible = "fsl,imx-scu";
                mboxes = <&lsio_mu1>;
                #clock-cells = <1>;
                #address-cells = <1>;
                #size-cells = <0>;

                iomuxc: iomuxc {
                        compatible = "fsl,imx8qxp-iomuxc";
                        fsl,mu = <&lsio_mu3>;
                };

                other_funcs: {
                        compatible = "thermal...";
                        ...
                };

                pd_lsio: PD_LSIO {
                        #power-domain-cells = <0>;
                        #address-cells = <1>;
                        #size-cells = <0>;

                        pd_lsio_pwm0: lsio_pwm0 at SC_R_PWM_0 {
                                reg = <SC_R_PWM_0>;
                                #power-domain-cells = <0>;
                                power-domains = <&pd_lsio>;
                        };
                        ...
                };

                pd_vpu: vpu-power-domain at SC_R_VPU_PID0 {
                        reg = <SC_R_VPU_PID0>;
                        #power-domain-cells = <0>;
                        #address-cells = <1>;
                        #size-cells = <0>;
                };

                pd_xxx {
                        ...
                }
                ....
        };
};

How would you suggest for such case?

Regards
Dong Aisheng

> Rob
