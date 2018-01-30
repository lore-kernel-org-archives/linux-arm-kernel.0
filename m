From: ladis@linux-mips.org (Ladislav Michl)
Date: Tue, 30 Jan 2018 09:34:46 +0100
Subject: [PATCH] sound/tlv320dac33: Add device tree support
In-Reply-To: <20180129233301.GA18104@amd>
References: <20180129230539.GA18280@amd> <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd>
Message-ID: <20180130083446.GA13498@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 12:33:01AM +0100, Pavel Machek wrote:
> On Tue 2018-01-30 00:20:31, Ladislav Michl wrote:
> > On Tue, Jan 30, 2018 at 12:05:39AM +0100, Pavel Machek wrote:
> > > 
> > > This adds device tree support to tlv320dac33.c.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> > > new file mode 100644
> > > index 0000000..6cbd311
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> > > @@ -0,0 +1,32 @@
> > > +Texas Instruments - tlv320dac33 Codec module
> > > +
> > > +The tlv320dac33 serial control bus communicates through I2C protocols.
> > > +
> > > +Required properties:
> > > +
> > > +- compatible - "ti,tlv320dac33"
> > > +- reg - I2C slave address
> > > +
> > > +Optional properties:
> > > +
> > > +- power-gpios - gpio pin to power the device, active high
> > 
> > While driver used gpio in platform data, isn't it more likely
> > regulator which powers device?
> 
>                 power-gpios = <&gpio2 28 0>; /* gpio_60 */
> 
> Looks like GPIO to me -- example is from Nokia N9. So this appears to
> be correct.

Device datasheet doesn't list any pin which looks like "power-gpio"
http://www.ti.com/lit/ds/symlink/tlv320dac32.pdf
Unfortunately I do not know much about N9, but was able to find Nokia 5610
scheme to get clue how could be tlv320dac33 hardwired (see page 2):
http://mastermobile.spb.ru/service/nokia_5610_rm-242_service_schematics.pdf
Here AVDD is powered by LP3985 voltage regulator which is enabled using
VEN pin which might be connected to gpio. Or there could be completely
different voltage regulator with different controls. And since Linux
already has voltage regulator class, lets not limit ourselves to gpio
pins.

See also here about deprecated power-gpios:
Documentation/devicetree/bindings/mmc/cavium-mmc.txt
so it seems others already fallen into that trap.

	ladis
