From: mka@chromium.org (Matthias Kaehlcke)
Date: Mon, 27 Aug 2018 10:10:03 -0700
Subject: [PATCH 2/3] arm64: dts: qcom: pm8998: Add adc node
In-Reply-To: <CAD=FV=Ug3oiHOLxYRXtr0LbBUyXjBB=92fAYfpfhEQ8Xih6PNA@mail.gmail.com>
References: <20180808191339.16875-1-mka@chromium.org>
 <20180808191339.16875-3-mka@chromium.org>
 <CAD=FV=Ug3oiHOLxYRXtr0LbBUyXjBB=92fAYfpfhEQ8Xih6PNA@mail.gmail.com>
Message-ID: <20180827171003.GU160295@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2018 at 05:09:17PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Aug 8, 2018 at 12:13 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > This adds the adc node to pm8998 based on the examples in the
> > bindings. It also fixes the order of the included headers.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pm8998.dtsi | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > index 92bed1e7d4bb..f70f6101bceb 100644
> > --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > @@ -1,8 +1,9 @@
> >  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >  /* Copyright 2018 Google LLC. */
> >
> > -#include <dt-bindings/spmi/spmi.h>
> > +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/spmi/spmi.h>
> >
> >  &spmi_bus {
> >         pm8998_lsid0: pmic at 0 {
> > @@ -11,6 +12,16 @@
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >
> > +               pm8998_adc: adc at 3100 {
> > +                       compatible = "qcom,spmi-adc-rev2";
> > +                       reg = <0x3100>;
> > +                       interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       #io-channel-cells = <1>;
> > +                       io-channel-ranges;
> > +               };
> 
> I'm a little confused about what the "io-channel-ranges" does here.
> The documentation isn't clear at all to me for it.  If I'm reading it
> right it's also supposed to be for iio-consumers, but you're using it
> in a provider.  I see you copied this from the example.  Maybe the
> example is wrong?  ...or I'm just confused...

Yes, I copied it from the example, its use here is also not clear to
me, other ADC providers like adc at 126c0000 in exynos3250.dtsi or
adc at 180a6000 in bcm-cygnus.dtsi also specify it ...

Siddartha/Jonathan, could you help to clarify if "io-channel-ranges"
should really be specified here as the DT example suggests?

Thanks

Matthias
