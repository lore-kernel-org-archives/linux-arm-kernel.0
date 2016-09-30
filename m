From: leoyang.li@nxp.com (Leo Li)
Date: Fri, 30 Sep 2016 21:45:33 +0000
Subject: [linux-devel] [PATCH v2 1/1] arm64: Add DTS support for FSL's
 LS1012A SoC
In-Reply-To: <AM4PR0401MB2275F9FBAE954BD420AA67F98CC10@AM4PR0401MB2275.eurprd04.prod.outlook.com>
References: <1472207241-18461-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <20160829095239.GM30790@tiger>
 <AM4PR0401MB22753C87DE074EE7BF456CE48CC10@AM4PR0401MB2275.eurprd04.prod.outlook.com>
 <VI1PR0401MB2638683943A984F9C638F4A88DC10@VI1PR0401MB2638.eurprd04.prod.outlook.com>
 <AM4PR0401MB2275F9FBAE954BD420AA67F98CC10@AM4PR0401MB2275.eurprd04.prod.outlook.com>
Message-ID: <AM2PR04MB07705BA78627EAC1A1B2EE998FC10@AM2PR04MB0770.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-devel-bounces at gforge.freescale.net [mailto:linux-devel-
> bounces at gforge.freescale.net] On Behalf Of Bhaskar U
> Sent: Friday, September 30, 2016 4:13 PM
> To: Stuart Yoder <stuart.yoder@nxp.com>; Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree at vger.kernel.org; Pratiyush Srivastava
> <pratiyush.srivastava@nxp.com>; oss at buserror.net; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>; linux-devel at gforge.freescale.net; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [linux-devel] [PATCH v2 1/1] arm64: Add DTS support for FSL's
> LS1012A SoC
> 
> 
> 
> >-----Original Message-----
> >From: Stuart Yoder
> >Sent: Friday, September 30, 2016 7:26 PM
> >To: Bhaskar U <bhaskar.upadhaya@nxp.com>; Shawn Guo
> ><shawnguo@kernel.org>
> >Cc: devicetree at vger.kernel.org; oss at buserror.net; Prabhakar Kushwaha
> ><prabhakar.kushwaha@nxp.com>; linux-devel at gforge.freescale.net;
> >Pratiyush Srivastava <pratiyush.srivastava@nxp.com>; linux-arm-
> >kernel at lists.infradead.org
> >Subject: RE: [PATCH v2 1/1] arm64: Add DTS support for FSL's LS1012A
> >SoC
> >
> >> >> +&qspi {
> >> >> +	num-cs = <2>;
> >> >> +	bus-num = <0>;
> >> >> +	status = "disabled";
> >> >
> >> >Why is it being disabled?
> >>
> >> Ok, will change like below.
> >> status = "okay";
> >
> >The comment was not "change this to okay".  The question is why is this
> disabled?
> >Can you explain why it was disabled?   Should it have been disasbled?  Is qspi
> >working and tested on this board?
> 
> The intension of putting the status in disabled state is that the qspi functionality
> is not tested with the up-streamed kernel.
> Yes qspi is working and tested on this board with 4.1 kernel version.
> >
> >>
> >> >
> >> >> +	fsl,ddr-sampling-point = <4>;
> >> >
> >> >I do not find the bindings for this property, neither how driver supports it.
> >>
> >> Yes the QSPI DDR mode is not yet up-streamed, so  I will remove this
> >> property
> >as of now.
> >>
> >> >
> >> >> +
> >> >> +	qflash0: s25fs512s at 0 {
> >> >> +		compatible = "spansion,m25p80";
> >> >> +		#address-cells = <1>;
> >> >> +		#size-cells = <1>;
> >> >> +		spi-max-frequency = <20000000>;
> >> >> +		m25p,fast-read;
> >> >> +		reg = <0>;
> >> >> +	};
> >> >> +};
> >> >> +
> >> >> +&i2c0 {
> >> >> +	status = "okay";
> >> >> +
> >> >> +	codec: sgtl5000 at a {
> >> >> +		#sound-dai-cells = <0>;
> >> >> +		compatible = "fsl,sgtl5000";
> >> >> +		reg = <0xa>;
> >> >> +		VDDA-supply = <&reg_1p8v>;
> >> >> +		VDDIO-supply = <&reg_1p8v>;
> >> >> +		clocks = <&sys_mclk>;
> >> >> +	};
> >> >> +};
> >> >> +
> >> >> +&duart0 {
> >> >> +	status = "okay";
> >> >> +};
> >> >> +
> >> >> +&esdhc0 {
> >> >> +	status = "disabled";
> >> >
> >> >We prefer to disable devices which have board level options by
> >> >default in <soc>.dtsi, and enable them per availability in <board>.dts.
> >>
> >> Ok , will make the status as okay i.e. status = "okay";
> >
> >Again, the feedback was not "set this to okay".  Why was esdhc0 set to
> "disabled"
> >here in the first place?  Was there a reason?
> >
> >The comment is that if there are certain boards where esdhc0 is not
> >available, then fsl-ls1012a.dtsi should set this to "disabled" and
> >board .dts files should override it.
> 
> esdhc0 is not there on this board so shall we mark the status in disabled state ?
> 
> >
> >> >
> >> >> +};
> >> >> +
> >> >> +&esdhc1 {
> >> >> +	status = "disabled";
> >> >> +};
> >> >> +
> >> >> +&sai2 {
> >> >> +	status = "disabled";
> >> >> +};
> >
> >Same comment for the above nodes.  The fsl-ls1012a.dtsi should set them
> >to disabled and any .dts file should override with "ok" if applicable.
> 
> esdhc1 is not there on the board, so shall we keep the status of esdhc1 in
> disabled state ?
> sai2 is working and tested on this board, so shall we put the sai2 status as
> "okay" ?
> Earlier when we kept sai2 status as disabled, by that time sai2 was not tested but
> now it is working fine.

The convention is to set the status of these optional nodes to "disabled" in the SoC dtsi.  And enable the nodes needed in board dts by overwriting the status to "okay".  It could be confusing if you use both "disabled" and "okay" in the board dts file.

Regards,
Leo
