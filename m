From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 17 Aug 2013 08:36:45 +0400
Subject: [PATCH] ARM: dts: imx27-phytec-phycore-rdk: Add DT nodes for
 camera module
In-Reply-To: <20130812080835.GH25061@S2101-09.ap.freescale.net>
References: <1376117398-19080-1-git-send-email-shc_work@mail.ru>
 <20130812080835.GH25061@S2101-09.ap.freescale.net>
Message-ID: <20130817083645.abf40501da3831e1d976a1c8@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Aug 2013 16:08:37 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> On Sat, Aug 10, 2013 at 10:49:58AM +0400, Alexander Shiyan wrote:
> > This patch adds PCA9536 device on first I2C bus (this device is
> > used on camera addon module to enable CSI bus muxing) and GPIO to
> > enable camera interface for Phytec PCM-970 RDK.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 31 ++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> > index 0fc6551..e93c968 100644
> > --- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> > +++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> > @@ -12,6 +12,25 @@
> >  / {
> >  	model = "Phytec pcm970";
> >  	compatible = "phytec,imx27-pcm970", "phytec,imx27-pcm038", "fsl,imx27";
> > +
> > +	cameramux: fixedregulator at 0 {
> 
> Generally, we only have @num on node name when there is "reg" property
> for the node.
> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "CAM_MUX";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		enable-active-high;
> > +		gpio = <&camgpio 0 0>;
> > +		vin-supply = <&csi_en>;
> 
> I do not quite understand the use case here.  You have a supply for this
> fixed regulator?  And what will you do about this vin-supply?  The fixed
> regulator will get and enable this vin-supply?
> 
> > +	};
> > +
> > +	csi_en: fixedregulator at 1 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "CSI_EN";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		gpio = <&gpio2 24 0>;
> > +		vin-supply = <&vcam_reg>;
> 
> Ditto

I create this sequence to ensure that all necessary power and GPIOs are in
desired state before camera driver will be probed.
Anyway, we missing DT camera driver at this time and this patch can be dropped.
Thanks.

-- 
Alexander Shiyan <shc_work@mail.ru>
