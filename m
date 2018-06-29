From: mka@chromium.org (Matthias Kaehlcke)
Date: Fri, 29 Jun 2018 11:51:02 -0700
Subject: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
In-Reply-To: <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
References: <20180628210915.160893-1-mka@chromium.org>
 <20180628210915.160893-3-mka@chromium.org>
 <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
Message-ID: <20180629185102.GV129942@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 03:58:41PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 28, 2018 at 2:09 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > Add pm8998 thermal zone based on the examples in the spmi-temp-alarm
> > bindings.
> >
> > Note: devices with the pm8998 need to have a 'thermal-zones' node (which
> > may be empty) with a label 'thermal_zones'.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pm8998.dtsi | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> 
> Do you know if this patch actually does anything since you didn't
> define a cooling-maps?  Hopefully at least the critical shuts things
> down?

I need to do some additional testing, currently waiting to get the
heat gun back ...

I would expect the critical trip point to shut the system down, though
I'm not sure whether the HW temperature watchdog wouldn't cut power
before that. The documentation I have access to contains some register
descriptions, but isn't very verbose about the overall behavior and
from the driver code that's also not really clear to me. The driver
"disables software override of stage 2 and 3 shutdowns" which make me
guess that a hardware shutdown kicks in at stage 2 (135?C ?). This
would be roughly in line with a system reset I observed in an earlier
test at a temperature > 125?C. If that's correct the trip points need
to be revisited.

Maybe David Collins who recently extended the driver to add support
for GEN2 PMIC peripherals can provide more details.

> Do you have any idea how we'll eventually want to specify a
> cooling-maps?  Are we just going to assume we're included by an sdm845
> device and refer to the big/little CPU phandles?

No clear idea on my side at this point, but limiting CPU frequencies
seems likely, potentially also devfreq devices.

> > diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > index f2d39074ed74..d85ceb4f976b 100644
> > --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > @@ -3,6 +3,7 @@
> >
> >  #include <dt-bindings/spmi/spmi.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  &spmi_bus {
> >         pm8998_lsid0: pmic at 0 {
> > @@ -59,3 +60,30 @@
> >                 #size-cells = <0>;
> >         };
> >  };
> > +
> > +&thermal_zones {
> 
> As per comments in patch #1, don't rely on a label.  Just put your
> stuff in a top-level "thermal-zones" node.

ack

> > +       pm8998 {
> > +               polling-delay-passive = <250>;
> > +               polling-delay = <1000>;
> > +
> > +               thermal-sensors = <&pm8998_temp>;
> > +
> > +               trips {
> > +                       passive {
> 
> IMO you should proactively put a label on these trips even if there's
> no cooling device yet.  It's expected that at some point someone will
> add a cooling device and refer to them, right?

ok
