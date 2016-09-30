From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 30 Sep 2016 14:55:28 -0700
Subject: [PATCH v2 1/1] arm64: Add DTS support for FSL's LS1012A SoC
In-Reply-To: <AM4PR0401MB2275F9FBAE954BD420AA67F98CC10@AM4PR0401MB2275.eurprd04.prod.outlook.com>
References: <1472207241-18461-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <20160829095239.GM30790@tiger>
 <AM4PR0401MB22753C87DE074EE7BF456CE48CC10@AM4PR0401MB2275.eurprd04.prod.outlook.com>
 <VI1PR0401MB2638683943A984F9C638F4A88DC10@VI1PR0401MB2638.eurprd04.prod.outlook.com>
 <AM4PR0401MB2275F9FBAE954BD420AA67F98CC10@AM4PR0401MB2275.eurprd04.prod.outlook.com>
Message-ID: <20160930215527.GB2373@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2016 at 09:13:11PM +0000, Bhaskar U wrote:
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
> >The comment was not "change this to okay".  The question is why is this disabled?
> >Can you explain why it was disabled?   Should it have been disasbled?  Is qspi
> >working and tested on this board?
> 
> The intension of putting the status in disabled state is that the qspi functionality is not tested with the up-streamed kernel.
> Yes qspi is working and tested on this board with 4.1 kernel version.

Please only add those board level device node after it's been tested on
the board.

> >> >> +&esdhc0 {
> >> >> +	status = "disabled";
> >> >
> >> >We prefer to disable devices which have board level options by
> >> >default in <soc>.dtsi, and enable them per availability in <board>.dts.
> >>
> >> Ok , will make the status as okay i.e. status = "okay";
> >
> >Again, the feedback was not "set this to okay".  Why was esdhc0 set to "disabled"
> >here in the first place?  Was there a reason?
> >
> >The comment is that if there are certain boards where esdhc0 is not available,
> >then fsl-ls1012a.dtsi should set this to "disabled" and board .dts files should
> >override it.
> 
> esdhc0 is not there on this board so shall we mark the status in disabled state ?

For device that has pin-out on board, we should mark it disabled in
<soc>.dtsi by default, and enable it in <board>.dts.

> >> >> +&esdhc1 {
> >> >> +	status = "disabled";
> >> >> +};
> >> >> +
> >> >> +&sai2 {
> >> >> +	status = "disabled";
> >> >> +};
> >
> >Same comment for the above nodes.  The fsl-ls1012a.dtsi should set them to
> >disabled and any .dts file should override with "ok" if applicable.
> 
> esdhc1 is not there on the board, so shall we keep the status of esdhc1 in disabled state ?

With esdhc1 being marked "disabled" in <soc>.dtsi by default, we need
to do nothing for board that doesn't have the device.

> sai2 is working and tested on this board, so shall we put the sai2 status as  "okay" ?
> Earlier when we kept sai2 status as disabled, by that time sai2 was not tested but now it is working fine.

With sai2 being marked "disabled" in <soc>.dtsi by default, you add
board level node with "okay" after you test the device working.

Shawn
