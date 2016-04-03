From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sun, 3 Apr 2016 12:46:15 +0900
Subject: [PATCH 01/11] ARM: dts: exynos: Fix DTC unit name warnings in
 cros-adc-thermistors
In-Reply-To: <CAL_JsqJi0w_j2wcb8f60XKOL3MFxkHFZpoyFhT-CCno_chb9Rw@mail.gmail.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
 <CAL_JsqJi0w_j2wcb8f60XKOL3MFxkHFZpoyFhT-CCno_chb9Rw@mail.gmail.com>
Message-ID: <20160403034615.GC4919@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 10:31:34AM -0500, Rob Herring wrote:
> On Fri, Apr 1, 2016 at 1:57 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
> > Fix following DTC warnings in cros-adc-thermistors:
> > Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 3 has a unit name, but no reg property
> > Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 4 has a unit name, but no reg property
> > Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 5 has a unit name, but no reg property
> > Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 6 has a unit name, but no reg property
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  arch/arm/boot/dts/cros-adc-thermistors.dtsi | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/cros-adc-thermistors.dtsi b/arch/arm/boot/dts/cros-adc-thermistors.dtsi
> > index acd4fe1833f2..87e676917603 100644
> > --- a/arch/arm/boot/dts/cros-adc-thermistors.dtsi
> > +++ b/arch/arm/boot/dts/cros-adc-thermistors.dtsi
> > @@ -13,28 +13,28 @@
> >  */
> >
> >  &adc {
> > -       ncp15wb473 at 3 {
> > +       ncp15wb473_3 {
> 
> Don't use underscores.

The ePAPR lists underscore as a acceptable character... but if you
insists then the sensible solution would be to rename all the nodes to
something like:
-       ncp15wb473 at 3 {
+       thermistor3 {

Is it okay?

> 
> >                 compatible = "murata,ncp15wb473";
> >                 pullup-uv = <1800000>;
> >                 pullup-ohm = <47000>;
> >                 pulldown-ohm = <0>;
> >                 io-channels = <&adc 3>;
> 
> I've not looked at the full binding here, but this case may warrant
> adding a reg property as an ADC channel number is what i'd consider an
> addressable thing.

This does not look entirely as an addressable thing. Altough this
particular driver (ntc_thermistor.c) uses one iio-channel... but others
are often using more than one.

> This is also kind of strange having a phandle to
> the parent node.

The Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
mentions that sensors can be added as child nodes or separately. The
exynos_adc driver indeed calls of_platform_populate() but I am not sure
why this was added.

Best regards,
Krzysztof
