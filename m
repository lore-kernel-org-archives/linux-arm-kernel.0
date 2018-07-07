From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 7 Jul 2018 20:33:12 +0200
Subject: [PATCH] ARM: dts: exynos: add max77693 irq configuration for midas
In-Reply-To: <20180707170848.GA29870@lineageos.org>
References: <20180707144527.6662-1-simon@lineageos.org>
 <CAJKOXPfUav7URsCDHFzMbtBiw5id+szVj_VtGJ-iu5ymmgWoXw@mail.gmail.com>
 <20180707170848.GA29870@lineageos.org>
Message-ID: <CAJKOXPdYrBDuiZCpO06doxeAbcZthncgAKbBmNJazVCxTSx+iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 July 2018 at 19:08, Simon Shields <simon@lineageos.org> wrote:
> On Sat, Jul 07, 2018 at 05:34:08PM +0200, Krzysztof Kozlowski wrote:
>> On 7 July 2018 at 16:45, Simon Shields <simon@lineageos.org> wrote:
>> > Currently, we assume that the bootloader has correctly configured
>> > the interrupt pin for max77693. This might not actually be the case -
>> > so it's better to configure it explicitly.
>> >
>> > Signed-off-by: Simon Shields <simon@lineageos.org>
>> > ---
>> >  arch/arm/boot/dts/exynos4412-midas.dtsi | 9 +++++++++
>> >  1 file changed, 9 insertions(+)
>> >
>> > diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
>> > index f35176a35a15..30760bf2eb71 100644
>> > --- a/arch/arm/boot/dts/exynos4412-midas.dtsi
>> > +++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
>> > @@ -156,6 +156,8 @@
>> >                         compatible = "maxim,max77693";
>> >                         interrupt-parent = <&gpx1>;
>> >                         interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
>> > +                       pinctrl-names = "default";
>> > +                       pinctrl-0 = <&max77693_irq>;
>> >                         reg = <0x66>;
>> >
>> >                         regulators {
>> > @@ -1117,6 +1119,13 @@
>> >                 samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
>> >         };
>> >
>> > +       max77693_irq: max77693-irq {
>> > +               samsung,pins = "gpx1-5";
>> > +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
>> > +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>> > +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
>> > +       };
>> > +
>>
>> Please put it before hdmi-hpd (gpx3-7).
>
> OK.
>
>> What about the interrupt for max77693 fuel gauge?
>> Maybe another patch for it as well?
>
> Yes - in fact, it looks like most interrupt pins are configured by the
> vendor kernel to have PULL_NONE, something which (as far as i can tell)
> mainline doesn't do.

The interrupt line of max77693 is marked as open-drain and there is
200k external pull up, so AFAIU such pin should have internal pull
down disabled. Mostly it works with pull down so no one cares. :)

> Maybe I should just prepare a series (or a single patch) which fixes all of them?
> Or would you prefer I added the (remaining) eint configurations to
> exynos4412-pinctrl.dtsi, and then used those?

Series will be ok but leave them in midas.dtsi.

Best regards,
Krzysztof
