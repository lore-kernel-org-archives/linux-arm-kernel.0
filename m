From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 23 Feb 2018 13:34:15 +0100
Subject: [PATCH 1/6] arm64: dts: renesas: r8a77965: Add "reg" properties
In-Reply-To: <20180223122250.GP7203@w540>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519326370-15805-2-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdWGYpeOMJQKcT8=wm1YzQoB+vpK5H99Kg_pJ_HeBUw8Sw@mail.gmail.com>
 <20180223122250.GP7203@w540>
Message-ID: <CAMuHMdWoryzK05SvAXQiD6epy3zsYrHOq9a6=7F3ZWinxb3mdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

On Fri, Feb 23, 2018 at 1:22 PM, jacopo mondi <jacopo@jmondi.org> wrote:
> On Fri, Feb 23, 2018 at 10:19:21AM +0100, Geert Uytterhoeven wrote:
>> On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
>> > Add "reg" properties to place-holder nodes with unit address defined for
>> > R-Car M3-N SoC.
>> >
>> > This silences the following DTC compiler warning:
>> > Warning (unit_address_vs_reg): Node /soc/... has a unit name,
>> > but no reg property
>> >
>> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>
>> A few minor nits below...
>>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> > --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
>> > +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
>>
>> > @@ -520,130 +521,163 @@
>> >                 };
>> >
>> >                 avb: ethernet at e6800000 {
>> > +                       reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
>>
>> The first reg part would be sufficient for a placeholder.
>> I think even setting the size to zero would work...
>
> Not sure I fully got your point here.
>
> Do you mean I have to remove the second (and third, fourth...)  addresses range block
> in all placeholder device nodes with multiple blocks (avb, du, rcar-sound) ?

No, you don't have to.

> Do you mean I have to set to 0 the address length in all placeholder nodes?
> What's the point if they have to be added back once the device is
> enabled?

No, you don't have to.

The point is to do the minimum amount of work for the placeholders.
But since you've already done the work (and I've done the work to review it),
it doesn't make sense to remove all of this, to be redone later.

For a new future SoC+board combination, we may consider this.
Actually we could get rid of the "reg" requirement as well, if would drop
the unit addresses from the placeholders (e.g. "avb: ethernet { ... }", and
"vin2: video-2 { ...}"). Even less to look up in the datasheet...
(to be broken by Rob adding more dtc checks ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
