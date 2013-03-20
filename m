From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 20 Mar 2013 23:19:27 +0100
Subject: [PATCH V4 9/9] pwm_bl: Add mandatory backlight enable regulator
In-Reply-To: <5149F92A.3070004@wwwdotorg.org>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
 <1363719573-20926-10-git-send-email-achew@nvidia.com>
 <5149F92A.3070004@wwwdotorg.org>
Message-ID: <20130320221927.GA6416@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 12:00:10PM -0600, Stephen Warren wrote:
> On 03/19/2013 12:59 PM, Andrew Chew wrote:
> > Many backlights need to be explicitly enabled.  Typically, this is done
> > with a GPIO.  For flexibility, we generalize the enable mechanism to a
> > regulator.
> > 
> > If an enable regulator is not needed, then a dummy regulator can be given
> > to the backlight driver.  If a GPIO is used to enable the backlight,
> > then a fixed regulator can be instantiated to control the GPIO.
> > 
> > The backlight enable regulator can be specified in the device tree node
> > for the backlight, or can be done with legacy board setup code in the
> > usual way.
> 
> > diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> > index 1e4fc72..7e2e089 100644
> > --- a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> > +++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> > @@ -10,6 +10,11 @@ Required properties:
> >        last value in the array represents a 100% duty cycle (brightest).
> >    - default-brightness-level: the default brightness level (index into the
> >        array defined by the "brightness-levels" property)
> > +  - enable-supply: A phandle to the regulator device tree node. This
> > +      regulator will be turned on and off as the pwm is enabled and disabled.
> > +      Many backlights are enabled via a GPIO. In this case, we instantiate
> > +      a fixed regulator and give that to enable-supply. If a regulator
> > +      is not needed, then provide a dummy fixed regulator.
> 
> "enable" doesn't seem like the right name here; if this really is an
> "enable" input, then it's not a regulator. If you're calling it "enable"
> because the regulator is usually controlled by a GPIO that enables it,
> then what you really have is a regulator that provides power to the
> backlight, and the method that you enable that regulator is irrelevant.
> 
> Put another way, wouldn't "power" be a better name, thus making the
> property "power-supply"? Although that property name migth be considered
> to have some negative correlation with other concepts, so if people
> object to that, perhaps e.g. "vdd-supply"?

"power" sounds like a reasonable name to me.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130320/e3abc94f/attachment-0001.sig>
