From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 16 Jan 2017 13:55:23 +0100
Subject: [PATCH v3 06/24] ARM: dts: imx6-sabrelite: add OV5642 and
 OV5640 camera sensors
In-Reply-To: <1bb64209-7c58-fe10-3db9-c5b8103eda90@gmail.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-7-git-send-email-steve_longerbeam@mentor.com>
 <1484309021.31475.29.camel@pengutronix.de>
 <1bb64209-7c58-fe10-3db9-c5b8103eda90@gmail.com>
Message-ID: <1484571323.8415.98.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-01-13 at 15:04 -0800, Steve Longerbeam wrote:
>
> On 01/13/2017 04:03 AM, Philipp Zabel wrote:
> > Am Freitag, den 06.01.2017, 18:11 -0800 schrieb Steve Longerbeam:
> >> Enables the OV5642 parallel-bus sensor, and the OV5640 MIPI CSI-2 sensor.
> >> Both hang off the same i2c2 bus, so they require different (and non-
> >> default) i2c slave addresses.
> >>
> >> The OV5642 connects to the parallel-bus mux input port on ipu1_csi0_mux.
> >>
> >> The OV5640 connects to the input port on the MIPI CSI-2 receiver on
> >> mipi_csi. It is set to transmit over MIPI virtual channel 1.
> >>
> >> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> >> ---
> >>   arch/arm/boot/dts/imx6dl-sabrelite.dts   |   5 ++
> >>   arch/arm/boot/dts/imx6q-sabrelite.dts    |   6 ++
> >>   arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 118 +++++++++++++++++++++++++++++++
> >>   3 files changed, 129 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/imx6dl-sabrelite.dts b/arch/arm/boot/dts/imx6dl-sabrelite.dts
> >> index 0f06ca5..fec2524 100644
> >> --- a/arch/arm/boot/dts/imx6dl-sabrelite.dts
> >> +++ b/arch/arm/boot/dts/imx6dl-sabrelite.dts
[...]
> >> @@ -299,6 +326,52 @@
> >>   	pinctrl-names = "default";
> >>   	pinctrl-0 = <&pinctrl_i2c2>;
> >>   	status = "okay";
> >> +
> >> +	ov5640: camera at 40 {
> >> +		compatible = "ovti,ov5640";
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&pinctrl_ov5640>;
> >> +		clocks = <&mipi_xclk>;
> >> +		clock-names = "xclk";
> >> +		reg = <0x40>;
> >> +		xclk = <22000000>;
> > This is superfluous, you can use clk_get_rate on mipi_xclk.
> 
> This property is actually there to tell the driver what to set the
> rate to, with clk_set_rate(). So you are saying it would be better
> to set the rate in the device tree and the driver should only
> retrieve the rate?

Yes. Given that this is a reference clock input that is constant on a
given board and never changes during runtime, I think this is the
correct way. The clock will be fixed rate on most boards, I assume.

regards
Philipp
