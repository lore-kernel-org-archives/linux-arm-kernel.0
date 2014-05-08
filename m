From: ipaton0@gmail.com (Iain Paton)
Date: Thu, 08 May 2014 10:09:29 +0100
Subject: [RFC PATCH] ARM: dts: imx6: add new board RIoTboard
In-Reply-To: <20140508054106.GH2794@dragon>
References: <53695C34.5000604@gmail.com> <20140508054106.GH2794@dragon>
Message-ID: <536B49C9.8020700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/14 06:41, Shawn Guo wrote:
> On Tue, May 06, 2014 at 11:03:32PM +0100, Iain Paton wrote:
>> The fec interrupt errata seems to suggest that a different gpio could be used
>> but I can't find any documentation or example dts that does so. Suggestions
>> welcome.
> 
> Take a look at commit 6261c4c (ARM: dts: imx6qdl-sabrelite: use GPIO_6
> for FEC interrupt.).  It seems you already has it for your board.

Yep, I'd had a look at those and added it.  I'm assuming that using 
GPIO_6 for this means I can't also use that pad for i2c3 at the same 
time?
The pad is wired to the lvds connector for use with a touchscreen 
when configured as i2c3


> We do not use imx6s as a SoC name in the kernel tree.  It's just an
> imx6dl with the second CPU core fused out.  So please name the file
> imx6dl-riotboard.dts.

Ok.

> Also, I'm not sure why you need an additional level with that .dtsi
> file, if it will only be soldered with imx6dl.  We have that .dtsi for
> boards like sabresd, because the board support both imx6q and imx6dl.

I probably don't need it then. I believe the board can support both,
but I don't know if the manufacturer will ever build any like that.

There's another highly similar board from the same manufacturer that
uses a dual.  So my thinking was that there's a possibility to have
a dtsi with all of the common parts and only differences in the dts.

I'll remove the additional level.


>> +	regulators {
>> +		compatible = "simple-bus";
>> +
>> +		reg_2p5v: 2p5v {
> 
> Please follow commit 56160e3 (ARM: dts: imx6: use generic node name for
> fixed regulator) to code fixed regulators.

Will do.

>> +
>> +&iomuxc {
> 
> Putting this iomuxc node which has a big mount of data at the bottom of
> the file can slightly make the dts file more readable. 


Ok, wasn't sure of the convention so just ordered them alphabetically.


>> +	imx6-embest {
> 
> Why 'embest'?  It's more sensible to use 'riotboard'?

Throwback to a previous iteration.  There are two boards with a shared 
history, RIoTboard and MarSboard, both manufactured by Embest which is
subsiduary of element14.
I originally had the common parts of this in a shared dtsi used by both
boards.

I'll change it here.

> 
>> +	      pinctrl_hog: hoggrp {
>> +			fsl,pins = <
>> +				MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x80000000	/* user led0 */
>> +				MX6QDL_PAD_EIM_D28__GPIO3_IO28		0x80000000	/* user led1 */
> 
> These should be in a pinctrl entry for led rather than hog group.

Ok.

>> +&usbh1 {
>> +	status = "okay";
> 
> Add 'status' at the end of the property list.

Ok.

I'll fix up these and Fabios comments and resend.

Thanks for the review!

Iain
