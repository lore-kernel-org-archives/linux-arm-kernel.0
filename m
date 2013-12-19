From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 19 Dec 2013 16:39:57 +0900
Subject: [PATCH 01/04] ARM: shmobile: r7s72100 GPIO and PINCTRL device
 nodes
In-Reply-To: <2318501.G71aXxrBQH@avalon>
References: <20131217050232.727.9552.sendpatchset@w520>
 <24775601.3oo6NRXHkY@avalon>
 <CANqRtoTdyUJgj+L8goMRW5mELjv16SVxkJqgw8tWpHyQyKzb3Q@mail.gmail.com>
 <2318501.G71aXxrBQH@avalon>
Message-ID: <CANqRtoTj_tN6LrWewEQ4GAfZWhigv678smiUtpDMd2-TrB1iDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Thu, Dec 19, 2013 at 9:15 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus (and Linus, as there's a question for your below),
>
> On Wednesday 18 December 2013 11:07:15 Magnus Damm wrote:
>> On Wed, Dec 18, 2013 at 9:40 AM, Laurent Pinchart wrote:
>> > On Wednesday 18 December 2013 07:41:57 Magnus Damm wrote:
>> >> On Wed, Dec 18, 2013 at 1:29 AM, Laurent Pinchart wrote:
>> >> > On Tuesday 17 December 2013 14:02:42 Magnus Damm wrote:
>> >> >> From: Magnus Damm <damm@opensource.se>
>> >> >>
>> >> >> Add support for r7s72100 PFC and GPIO device nodes port0 -> port11
>> >> >> and jtagport0.
>> >> >>
>> >> >> Signed-off-by: Magnus Damm <damm@opensource.se>
>> >> >> ---
>> >> >>
>> >> >>  arch/arm/boot/dts/r7s72100.dtsi |  154 ++++++++++++++++++++++++++++++
>> >> >>  1 file changed, 154 insertions(+)
>> >> >>
>> >> >> --- 0001/arch/arm/boot/dts/r7s72100.dtsi
>> >> >> +++ work/arch/arm/boot/dts/r7s72100.dtsi      2013-11-27
>> >> >> 16:06:36.000000000 +0900
>> >
>> > [snip]
>> >
>> >> >> +
>> >> >> +     port0: gpio at fcfe3100 {
>> >> >> +             compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
>> >> >> +             reg = <0xfcfe3100 0x4>, /* PSR */
>> >> >> +                       <0xfcfe3200 0x2>, /* PPR */
>> >> >> +                       <0xfcfe3800 0x4>; /* PMSR */
>> >> >> +             #gpio-cells = <2>;
>> >> >> +             gpio-controller;
>> >> >> +             gpio-ranges = <&pfc 0 0 6>;
>> >> >> +     };
>> >> >> +
>> >> >> +     port1: gpio at fcfe3104 {
>> >> >> +             compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
>> >> >> +             reg = <0xfcfe3104 0x4>, /* PSR */
>> >> >> +                       <0xfcfe3204 0x2>, /* PPR */
>> >> >> +                       <0xfcfe3804 0x4>; /* PMSR */
>> >> >> +             #gpio-cells = <2>;
>> >> >> +             gpio-controller;
>> >> >> +             gpio-ranges = <&pfc 0 16 16>;
>> >> >
>> >> > As P0 has 6 pins only this should ideally be
>> >> >
>> >> >                 gpio-ranges = <&pfc 0 6 16>;
>> >> >
>> >> > Otherwise the PFC driver will expose pins that don't exist. However,
>> >> > that would require computing the pin numbers in the PFC driver
>> >> > differently, as we currently just use the bank * 16 + index formula.
>> >> > Given that we only have three ports with less than 16 pins we could
>> >> > come up with a not overly complex formula that can be evaluated at
>> >> > compile time. Something like this should do.
>> >> >
>> >> > #define RZ_PORT_PIN(bank, pin) \
>> >> >
>> >> >         (bank) < 1 ? (pin) : \
>> >> >         (bank) < 6 ? 6 + (((bank) - 1) * 16) + (pin)) : \
>> >> >         (bank) < 10 ? 6 + 11 + 4 * 16 + (((bank) - 6) * 16) + (pin)) :
>> >> >         \
>> >> >         6 + 11 + 8 + 7 * 16 + (((bank) - 10) * 16) + (pin))
>> >>
>> >> Uhm, well, you can make the mapping more compact yes, but I'm not sure
>> >> if I agree that it becomes any better. Isn't it better to simply
>> >> follow the per-port setup that the manual defines? Is there an actual
>> >> problem with having unused GPIOs?
>> >
>> > If I'm not mistaken it's unused pins, not unused GPIOs. They waste memory
>> > in data tables, although by a relatively small amount. Oh, and of course,
>> > it's not clean ;-)
>>
>> Yes, you are correct about pins vs GPIOs. Regarding how to implement
>> RZ_PORT_PIN(), I believe the only way not to shoot yourself in the foot is
>> to keep things simple. I also think that some level of redundancy is an
>> acceptable tradeoff if it keeps things simpler. So I suppose cleanliness is
>> a matter of taste. =)
>
> Absolutely, and there's no universal reason why my cleanliness would be better
> than yours :-)

I think we should count LOC, just to add a rigged metric to my side. =)

>> > Speaking of data tables, I'm thinking about simplifying them. The RZ/A1H
>> > is a good candidate for that, as each pin is handled individually, and
>> > several registers could be handled to with a small amount of code instead
>> > of large data tables. It's just a thought for now, I have more urgent
>> > tasks to work on.
>>
>> Incremental patches to improve the state is always nice, thanks.
>
> You're welcome.

Thanks.

>> >> Actually, I prefer going in the opposite direction so I would like to
>> >> share the simple version of RZ_PORT_PIN() in a header file like we do
>> >> with RCAR_GP_PIN() in <linux/platform_data/gpio-rcar.h>. This because
>> >> we would like to use the same macro in the GPIO driver and in the
>> >> current PFC code (and potentially more PFCs using the same GPIO
>> >> driver).
>> >
>> > What do you need it for in the GPIO driver ?
>>
>> Well, I thought I needed it but it turns out that I'm wrong. =)
>>
>> Initially I had the following two in the header file:
>> +#define RZ_GPIOS_PER_PORT 16
>> +#define RZ_PORT_PIN(bank, pin) (((bank) * RZ_GPIOS_PER_PORT) + (pin))
>>
>> RZ_GPIOS_PER_PORT was used in both the GPIO driver and
>> RZ_PORT_PIN() was used in the PFC driver
>>
>> On a second though, I don't mind duplicating them.
>
> I agree here, I don't think we need to share RZ_GPIOS_PER_PORT between the two
> drivers.

They have separate name spaces for GPIOS and pins anyway, so yes.

>> I do however think your version of the RZ_PORT_PIN() is overly complex. And
>> that needs to be matched with updated gpio-ranges that together seem quite
>> error prone to me.
>>
>> How would you like me to proceed?
>
> I have mixed feelings about this, and understand your concern about
> complexity. I usually tend to favor correctness over complexity (without
> reaching the overcomplexity level). In this case I'd like to hear Linus' point
> of view. If he's fine with your version of the code I'll be fine as well. Is
> that OK ?

Sure, that's fine. I may resend the series as-is and see what happens. =)

/ magnus
