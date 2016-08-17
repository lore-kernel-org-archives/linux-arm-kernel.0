From: kbeldan@baylibre.com (Karl Beldan)
Date: Wed, 17 Aug 2016 10:33:46 +0000
Subject: [PATCH 1/2] ARM: dts: da850-lcdk: Audio support via simple-card
In-Reply-To: <aeec6ee5-91e9-13fa-f7fa-09581ddb9b6a@ti.com>
References: <20160810200853.24275-1-kbeldan@baylibre.com>
 <aeec6ee5-91e9-13fa-f7fa-09581ddb9b6a@ti.com>
Message-ID: <20160817103346.GB8009@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 03:24:42PM +0530, Sekhar Nori wrote:
> On Thursday 11 August 2016 01:38 AM, Karl Beldan wrote:
> > The LCDK embeds a TLV320AIC3106 connected to the SoC McASP for analog
> > audio. This relies on the 'dummy' regulator as the codec is always on.
> > Quality is good with arecord -pipe- aplay on Line In/Line Out.
> > The MIC path doesn't seem to work yet.
> 
> I tested the patch and I could not get the MIC to work as well. I
> suggest dropping the MIC path parts till that is debugged and root caused.
> 

Ok.

> > Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> > ---
> >  arch/arm/boot/dts/da850-lcdk.dts | 75 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> 
> > +&i2c0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c0_pins>;
> > +	clock-frequency = <100000>;
> > +	status = "okay";
> > +
> > +	tlv320aic3106: tlv320aic3106 at 18 {
> > +		#sound-dai-cells = <0>;
> > +		compatible = "ti,tlv320aic3106";
> > +		reg = <0x18>;
> > +		status = "okay";
> > +
> > +		ai3x-micbias-vg = <MICBIAS_2_5V>;
> 
> It will be nice to add the codec regulators as well (and that in turn
> needs the PMIC to be populated). Although I wont insist on that since
> the regulators are optional properties.
> 

In the patch comment I stated it relied on the dummy regulator as the
codec is always on but maybe I should have been more precise: it is not
out of convenience to keep things on, it is by HW design: I mentioned
it in the comment of "ARM: dts: da850: Add basic DTS for the LCDK":
 "the main PMIC, different and hard-wired on the LCDK (the LDOs and
 DCDCs are always on)" after reviewing the schematics.
I could add that in the patch comment.

Thanks for reviewing.

Rgds, 
Karl
