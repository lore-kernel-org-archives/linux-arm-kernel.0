From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Fri, 23 Jun 2017 12:25:33 +0200
Subject: [PATCH v1 1/6] DT bindings: add bindings for ov965x camera module
In-Reply-To: <1498143942-12682-2-git-send-email-hugues.fruchet@st.com>
References: <1498143942-12682-1-git-send-email-hugues.fruchet@st.com>
 <1498143942-12682-2-git-send-email-hugues.fruchet@st.com>
Message-ID: <D5629236-95D8-45B6-9719-E8B9796FEC90@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hugues,

> Am 22.06.2017 um 17:05 schrieb Hugues Fruchet <hugues.fruchet@st.com>:
> 
> From: "H. Nikolaus Schaller" <hns@goldelico.com>
> 
> This adds documentation of device tree bindings
> for the OV965X family camera sensor module.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
> ---
> .../devicetree/bindings/media/i2c/ov965x.txt       | 37 ++++++++++++++++++++++
> 1 file changed, 37 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/media/i2c/ov965x.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov965x.txt b/Documentation/devicetree/bindings/media/i2c/ov965x.txt
> new file mode 100644
> index 0000000..0e0de1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ov965x.txt
> @@ -0,0 +1,37 @@
> +* Omnivision OV9650/9652/9655 CMOS sensor
> +
> +The Omnivision OV965x sensor support multiple resolutions output, such as
> +CIF, SVGA, UXGA. It also can support YUV422/420, RGB565/555 or raw RGB
> +output format.
> +
> +Required Properties:
> +- compatible: should be one of
> +	"ovti,ov9650"
> +	"ovti,ov9652"
> +	"ovti,ov9655"
> +- clocks: reference to the mclk input clock.

I wonder why you have removed the clock-frequency property?

In some situations the camera driver must be able to tell the clock source
which frequency it wants to see.

For example we connect the camera to an OMAP3-ISP (image signal processor) and
there it is assumed that camera modules know the frequency and set the clock, e.g.:

http://elixir.free-electrons.com/linux/v4.4/source/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt#L52
http://elixir.free-electrons.com/linux/v3.14/source/Documentation/devicetree/bindings/media/i2c/mt9p031.txt

If your clock is constant and defined elsewhere we should make this
property optional instead of required. But it should not be missing.

Here is a hack to get it into your code:

http://git.goldelico.com/?p=gta04-kernel.git;a=blobdiff;f=drivers/media/i2c/ov9650.c;h=b7ab46c775b9e40087e427ae0777e9f7c283694a;hp=1846bcbb19ae71ce686dade320aa06ce2e429ca4;hb=ca85196f6fd9a77e5a0f796aeaf7aa2cde60ce91;hpb=8a71f21b75543a6d99102be1ae4677b28c478ac9

> +
> +Optional Properties:
> +- resetb-gpios: reference to the GPIO connected to the resetb pin, if any.
> +- pwdn-gpios: reference to the GPIO connected to the pwdn pin, if any.

Here I wonder why you did split that up into two gpios. Each "*-gpios" can have
multiple entries and if one is not used, a 0 can be specified to make it being ignored.

But it is up to DT maintainers what they prefer: separate single gpios or a single gpio array.


What I am missing to support the GTA04 camera is the control of the optional "vana-supply".
So the driver does not power up the camera module when needed and therefore probing fails.

  - vana-supply: a regulator to power up the camera module.

Driver code is not complex to add:

http://git.goldelico.com/?p=gta04-kernel.git;a=blobdiff;f=drivers/media/i2c/ov9650.c;h=1846bcbb19ae71ce686dade320aa06ce2e429ca4;hp=c0819afdcefcb19da351741d51dad00aaf909254;hb=8a71f21b75543a6d99102be1ae4677b28c478ac9;hpb=6db55fc472eea2ec6db03833df027aecf6649f88

> +
> +The device node must contain one 'port' child node for its digital output
> +video port, in accordance with the video interface bindings defined in
> +Documentation/devicetree/bindings/media/video-interfaces.txt.
> +
> +Example:
> +
> +&i2c2 {
> +	ov9655: camera at 30 {
> +		compatible = "ovti,ov9655";
> +		reg = <0x30>;
> +		pwdn-gpios = <&gpioh 13 GPIO_ACTIVE_HIGH>;
> +		clocks = <&clk_ext_camera>;
> +
> +		port {
> +			ov9655: endpoint {
> +				remote-endpoint = <&dcmi_0>;
> +			};
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 

BR and thanks,
Nikolaus
