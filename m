From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Oct 2014 21:19:05 +0200
Subject: [RFC Patch 1/4] mfd: AXP20x: Add power supply bindings
 documentation
In-Reply-To: <20141021180916.432f02e1@neptune.home>
References: <20141020221959.2f312906@neptune.home>
 <20141020223314.0484f795@neptune.home> <20141021101503.GE26842@x1>
 <20141021180916.432f02e1@neptune.home>
Message-ID: <20141021191905.GR21108@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bruno,

Thanks a lot for working on this!

On Tue, Oct 21, 2014 at 06:09:16PM +0200, Bruno Pr?mont wrote:
> On Tue, 21 October 2014 Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 20 Oct 2014, Bruno Pr?mont wrote:
> > > ---
> > > Note: the OCV values seem to have some defaults build into the
> > > PMIC though may need adjustment if the used battery has a different
> > > open circuit voltage curve.
> > > As far as understood (these values are set in vendor driver but not
> > > mentioned in chip documentation) they represent charge percentage
> > > for some predefined voltages.
> > > 
> > > If prefixing these values with "x-power," is preferred the following
> > > patch should becomes a dependency:
> > >   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/267606.html
> > > and users in patch 2/4, 4/4 need adjusting.
> > > 
> > > 
> > >  Documentation/devicetree/bindings/mfd/axp20x.txt |   20 +
> > >  1 files changed, 20 insertions(+), 0 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> > > index cc9e01b..8ea681c 100644
> > > --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> > > +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> > > @@ -28,6 +28,20 @@ Required properties:
> > >  		      (range: 750-1875). Default: 1.5MHz
> > >  
> > >  Optional properties for DCDCs:
> > > +- backup: Settings for backup/RTC battery charger
> > > +	  (Voltage in ?V, current in ?A)
> > > +	  If not present, charger will be left untouched
> > > +- battery.ocv: OCV capacity curve points (16 data values)
> > > +- battery.resistance: internal battery resistance in m?
> > > +                      (defaults to 100m?)
> > > +- battery.capacity: Battery capacity in mAh
> > > +		    If this attribute is missing, charger will be disabled
> > > +		    unless there is a battery connected.
> > > +- battery.temp_sensor: Description of temperautre sensor, 3 values
> > > +		       - driver current (20?A, 40?A, 60?A or 80?A)
> > > +		       - low temperature warning level (in ?V)
> > > +		       - high temperature warning level (in ?V)
> > > +		       If missing, temperature sensor gets disabled
> > >  - x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO mode
> > >  			  Default: AUTO mode
> > >  
> > > @@ -49,6 +63,12 @@ axp209: pmic at 34 {
> > >  	ldo3in-supply = <&axp_ipsout_reg>;
> > >  	ldo5in-supply = <&axp_ipsout_reg>;
> > >  
> > > +	backup = <3000000 200>;
> > > +	battery.ocv = <0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
> > > +	battery.resistance = <0>;
> > > +	battery.capacity = <2000>;
> > > +	battery.temp_sensor = <20 1000000 4000000>;
> > 
> > Since when do we use '.'s in property names?
> 
> I've not found guidelines on this, but whatever is the right way to
> name them, I'm open for suggestions.

You can take a look at the ePAPR specs. Even if it's quite outdated,
it still puts you in the right mindset.

That being said, since they are driver-specific properties, they
should be prefixed by the vendor name (here x-powers).

And I think they all belong in a sub-node, just like what's been done
for the regulators.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141021/e95016f1/attachment.sig>
