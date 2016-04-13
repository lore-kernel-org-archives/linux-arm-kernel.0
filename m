From: yao.yuan@nxp.com (Yao Yuan)
Date: Wed, 13 Apr 2016 02:41:27 +0000
Subject: [PATCH 2/2] dts/ls1043a: add the DTS node for QSPI support
In-Reply-To: <20160412024947.GD15949@tiger>
References: <1459406701-40993-1-git-send-email-yao.yuan@freescale.com>
 <1459406701-40993-3-git-send-email-yao.yuan@freescale.com>
 <20160412024947.GD15949@tiger>
Message-ID: <AM2PR04MB07221B6FDAD72A6DAB8E1E0889960@AM2PR04MB0722.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2016 at 10:50:01AM +0800, Shawn Guo wrote:
> On Thu, Mar 31, 2016 at 02:45:01PM +0800, Yuan Yao wrote:
> > From: Yuan Yao <yao.yuan@nxp.com>
> >
> > Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> 
> Please style of 'arm64: dts: ls1043a: ' for subject prefix.
> 
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 16 ++++++++++++++++
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi    | 14 ++++++++++++++
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > index 97e9906..c8303a3 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > @@ -100,6 +100,22 @@
> >  	};
> >  };
> >
> > +&qspi {
> 
> Please sort such labeled node alphabetically in label name.  That said, it should
> go after &lpuart0.

Ok, Thanks.

> > +	num-cs = <2>;
> 
> I do not see this property in bindings doc.

We can find this property in ./Documentation/devicetree/bindings/spi/spi-bus.txt
 
> 
> > +	bus-num = <0>;
> > +	status = "okay";
> 
> Please let 'status' line be the last of property list.


Ok, Thanks.

> > +	fsl,ddr-sampling-point = <4>;
> 
> I do not see this one in bindings definition either.

It's used for DDR mode; The DDR mode will send to upstream late.
So I will remove this, once the DDR mode patch is merged, I will send patch to add the property.

> 
> > +
> > +	qflash0: s25fl128s at 0 {
> > +		compatible = "spansion,m25p80";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		spi-max-frequency = <20000000>;
> > +		ddr-quad-read;
> 
> Ditto

Ditto, Thanks.

> 
> > +		reg = <0>;
> > +	};
> > +};
> > +
> >  &i2c0 {
> >  	status = "okay";
> >  	pca9547 at 77 {
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > index be72bf5..49b1aeb 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > @@ -208,6 +208,20 @@
> >  			status = "disabled";
> >  		};
> >
> > +		qspi: quadspi at 1550000 {
> 
> Please sort the node in <soc>.dtsi in order of unit-address.  That said, the node
> should be added between ifc at 1530000 and esdhc at 1560000.

Thanks. I will update it and resend it soon.

> Shawn
> 
> > +			compatible = "fsl,ls1043a-qspi", "fsl,ls1021a-qspi";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0x0 0x1550000 0x0 0x10000>,
> > +				<0x0 0x40000000 0x0 0x4000000>;
> > +			reg-names = "QuadSPI", "QuadSPI-memory";
> > +			interrupts = <0 99 0x4>;
> > +			clock-names = "qspi_en", "qspi";
> > +			clocks = <&clockgen 4 0>, <&clockgen 4 0>;
> > +			big-endian;
> > +			status = "disabled";
> > +		};
> > +
> >  		i2c0: i2c at 2180000 {
> >  			compatible = "fsl,vf610-i2c";
> >  			#address-cells = <1>;
> > --
> > 2.1.0.27.g96db324
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
