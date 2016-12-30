From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 30 Dec 2016 17:05:59 +0200
Subject: [PATCH 7/9] pinctrl: samsung: Add property to mark pad state as
 suitable for power down
In-Reply-To: <bad5ef6a-6132-2029-8581-2e8b27f7a2bd@samsung.com>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122538epcas5p29515ceff21963ab035b3b32878830ce2@epcas5p2.samsung.com>
 <1482495889-6201-8-git-send-email-m.szyprowski@samsung.com>
 <20161225191914.5bzl6fso36ozuum6@kozik-lap>
 <bd48fe32-5296-fc23-dbb8-d212292d76cd@samsung.com>
 <20161227153331.jbh7ei6oh3obmnri@kozik-lap>
 <bad5ef6a-6132-2029-8581-2e8b27f7a2bd@samsung.com>
Message-ID: <20161230150559.nt5bv4zx326je7j2@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 12:55:27PM +0100, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2016-12-27 16:33, Krzysztof Kozlowski wrote:
> > On Tue, Dec 27, 2016 at 11:30:57AM +0100, Marek Szyprowski wrote:
> > > On 2016-12-25 20:19, Krzysztof Kozlowski wrote:
> > > > On Fri, Dec 23, 2016 at 01:24:47PM +0100, Marek Szyprowski wrote:
> > > > > Add support for special property "samsung,off-state", which indicates a special
> > > > > state suitable for device's "sleep" state. Its pin values/properties should
> > > > > match the configuration in power down mode. It indicates that pin controller
> > > > > can notify runtime power management subsystem, that it is ready for runtime
> > > > > suspend if its all pins are configured for such state. This in turn might
> > > > > allow to turn respective power domain off to reduce power consumption.
> > > > > 
> > > > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > > ---
> > > > >    Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 8 ++++++++
> > > > >    drivers/pinctrl/samsung/pinctrl-samsung.c                     | 4 ++++
> > > > >    drivers/pinctrl/samsung/pinctrl-samsung.h                     | 1 +
> > > > >    3 files changed, 13 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> > > > > index b7bd2e12a269..354eea0e7798 100644
> > > > > --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> > > > > +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> > > > > @@ -105,6 +105,7 @@ Required Properties:
> > > > >      - samsung,pin-drv: Drive strength configuration.
> > > > >      - samsung,pin-pud-pdn: Pull up/down configuration in power down mode.
> > > > >      - samsung,pin-drv-pdn: Drive strength configuration in power down mode.
> > > > > +  - samsung,off-state: Mark this configuration as suitable for bank power off.
> > > > >      The values specified by these config properties should be derived from the
> > > > >      hardware manual and these values are programmed as-is into the pin
> > > > > @@ -113,6 +114,13 @@ Required Properties:
> > > > >      Note: A child should include atleast a pin function selection property or
> > > > >      pin configuration property (one or more) or both.
> > > > > +  Note: Special property "samsung,off-state" indicates that this state can
> > > > > +  be used for device's "sleep" pins state. Its pin values/properties should
> > > > > +  match the configuration in power down mode.
> > > > Why power down values cannot be used for sleep state? Why you need
> > > > separate pin control state? If pins values should match power down
> > > > configuration, then they could just be added to default state, couldn't
> > > > they?
> > > Separate sleep state is needed because of the pin control bindings and
> > > design.
> > > 
> > > A separate sleep state is required to let pin control client driver (in this
> > > case
> > > Exynos I2S driver) let to choose when it is okay to switch pads into sleep
> > > state and I see no other way to achieve this.
> > Maybe the pinctrl API should be extended for this? Doing this in DTS
> > just for purpose of passing information between drivers (consumer and
> > provider) looks odd.
> 
> Well, I don't know if it is odd or not, but that's how it is used now and I
> see
> no reason to reinvent wheel. Please check it yourself:
> $ git grep \"sleep\" arch/arm/boot/dts | wc -l
> 101

These drivers, at least not all of them, are not using the existence of
sleep mode configuration as a indication of possible runtime sleep. You
are mixing here different ideas.

> 
> > Anyway, you are proposing a new binding so please Cc devicetree mailing
> > list and device tree maintainers.
> 
> I'm just using the generic pinctrl bindings, but it might make some sense to
> add a note to Exynos i2s driver that a sleep pin control state is needed if
> one wants to get power domain to be turned off.

The samsung,off-state is a extension of the existing binding, so please
Cc the devicetree and maintainers. Why you see a problem in it?

Best regards,
Krzysztof
