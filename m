From: peda@axentia.se (Peter Rosin)
Date: Thu, 3 Aug 2017 12:00:27 +0200
Subject: Compatibles for i2c muxes nxp,pca954x and ti,tca954x
Message-ID: <62519d0b-0b7b-9124-8481-9ef8de24eaf6@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Texas has apparently made copies for some of the NXP devices
handled by the drivers/i2c/muxes/i2c-mux-pca954x.c driver.

How is that best handled?

I see e.g. that arch/arm/boot/dts/vf610-zii-dev-rev-{b,c}.dts has
this snippet:

&i2c2 {
	tca9548 at 70 {
		compatible = "nxp,pca9548";

Which indicates that it really is a Texas chip sitting there, but that
someone did not bother to state that explicitly.

As I see it, there are two levels to this.

1. Update the above to be

		compatible = "ti,tca9548a", "nxp,pca9548";

   and rely on the secondary compatible to be matched with the driver.

2. Also update the driver to recognize the "ti,tca9548a" compatible.

There are also "ti,tca9543a", "ti,tca9544a", "ti,tca9545a" and
"ti,tca9546a" to consider (but no "ti,tca9542a" or "ti,tca9547a").

AFAIU, the Texas chips are completely compatible from the driver
point of view.

Step 1 above is probably a bugfix, should someone find some
unexpected incompatibility in the future. Without differentiating
the compatibles now, there's just no way to handle that in a future
driver.

But is step 2 needed/desired until such a time that differences between
the chips are found? How is this situation handled elsewhere?

Cheers,
peda
