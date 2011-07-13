From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 14 Jul 2011 08:04:29 +0900
Subject: [PATCH 2/4] dt: OMAP3: Beagle board: set clock freq for i2c
	devices
In-Reply-To: <1310592975-25773-3-git-send-email-manjugk@ti.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-3-git-send-email-manjugk@ti.com>
Message-ID: <CACxGe6uaR41CLPRWURDiXxnphScHPikLU3AmwxNZsijt9GP4qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
>
> Update omap3 beagle dts file with required clock frequencies for the i2c
> client devices existing on beagle board.
>
> Beagle custom board dts file is cleaned up so that it can coexist with omap3
> soc dts file.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
> ?arch/arm/boot/dts/omap3-beagle-nunchuck.dts | ? 11 +---------
> ?arch/arm/boot/dts/omap3-beagle.dts ? ? ? ? ?| ? 29 +++++++++++++++++++++++++-
> ?2 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> index 2607be5..324ff86 100644
> --- a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> @@ -1,16 +1,7 @@
> ?/include/ "omap3-beagle.dts"
>
> ?/ {
> - ? ? ? i2c at 48072000 {
> - ? ? ? ? ? ? ? compatible = "ti,omap3-i2c";
> - ? ? ? ? ? ? ? reg = <0x48072000 0x80>;
> - ? ? ? ? ? ? ? #address-cells = <1>;
> - ? ? ? ? ? ? ? #size-cells = <0>;
> -
> - ? ? ? ? ? ? ? eeprom at 50 {
> - ? ? ? ? ? ? ? ? ? ? ? compatible = "at,at24c01";
> - ? ? ? ? ? ? ? ? ? ? ? reg = < 0x50 >;
> - ? ? ? ? ? ? ? };
> + ? ? ? i2c at 2 {
> ? ? ? ? ? ? ? ?joystick at 52 {
> ? ? ? ? ? ? ? ? ? ? ? ?compatible = "sparkfun,wiichuck";
> ? ? ? ? ? ? ? ? ? ? ? ?reg = < 0x52 >;
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index 4439466..b45fbc9 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -1,7 +1,32 @@
> -/dts-v1/;
> -/include/ "skeleton.dtsi"
> +/include/ "omap3-soc.dtsi"
>
> ?/ {
> ? ? ? ?model = "TI OMAP3 BeagleBoard";
> ? ? ? ?compatible = "ti,omap3-beagle";

compatible = "ti,omap3-beagle", "ti,omap3";

> +
> + ? ? ? i2c at 1 {
> + ? ? ? ? ? ? ? #address-cells = <1>;
> + ? ? ? ? ? ? ? #size-cells = <0>;
> + ? ? ? ? ? ? ? clock-frequency = <2600000>;
> + ? ? ? ? ? ? ? status = "disabled";
> + ? ? ? };

Since this file include the omap3-soc dtsi, you don't need to
duplicate the #address-cells and #size-cells properties.  You only
need to specify the ones that have changed.  Also, since the include
file has the i2c nodes as children of the l4 bus, you should you need
to either duplicate the same bus hierarchy here, or use an independent
label reference by adding a label to the node in omap3-soc.dtsi, and
using the following syntax /outside/ of the /{ ... } root node:

&i2c-1 {
       clock-frequency = <2600000>;
};

g.
