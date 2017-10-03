From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 3 Oct 2017 23:08:11 +0800
Subject: [PATCH v3 12/12] ARM: dtsi: axp81x: set pinmux for GPIO0/1 when
 used as LDOs
In-Reply-To: <20171003144737.rhgtp3uwckhvoqdw@flea>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
 <20171002120854.5212-13-quentin.schulz@free-electrons.com>
 <CACRpkdZYcSuhvn0b0qa0k1PQHoyXjNyjoyhR2sPme_t1pF12Dg@mail.gmail.com>
 <20171003144737.rhgtp3uwckhvoqdw@flea>
Message-ID: <CAGb2v64=XL34x7iGJcEmmVnmzkA5wmyZJd-g827bY=kdHcZOMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 3, 2017 at 10:47 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Linus,
>
> On Tue, Oct 03, 2017 at 09:27:17AM +0000, Linus Walleij wrote:
>> On Mon, Oct 2, 2017 at 2:08 PM, Quentin Schulz
>> <quentin.schulz@free-electrons.com> wrote:
>>
>> > On AXP813/818, GPIO0 and GPIO1 can be used as LDO as (respectively)
>> > ldo_io0 and ldo_io1.
>> (...)
>> > +               gpio0_ldo: gpio0_ldo {
>> > +                       pins = "GPIO0";
>> > +                       function = "ldo";
>> > +               };
>> (...)
>> > +                       pinctrl-names = "default";
>> > +                       pinctrl-0 = <&gpio0_ldo>;
>> >                         /* Disable by default to avoid conflicts with GPIO */
>> >                         status = "disabled";
>>
>> So this is still by default disabled, but you make the default
>> mode something called "ldo".
>>
>> And I think that is to be understood as a low-dropout regulator?
>>
>> So is the idea that this should be represented as a regulator
>> in the end?
>>
>> Then I think the state name should not be "default" rather
>> something like "regulator" and "default" should be the GPIO
>> mode, as I guess something like that exists.
>>
>> Activating a regulator using pin control "default" mode is
>> not very pretty. It would probably be unintuitive and end
>> up wasting power because people will get confused about
>> what is going on.
>
> That's not really it. The PMIC has pins that can be muxed either to
> (regular) GPIOs, an ADC or to an LDO regulator.
>
> This is just muxing, the regulator will be enabled and disabled
> separately through another register. If it wasn't the case, it would
> indeed be very messy.

No. Actually they are controlled in the same register, so it is
very messy. The muxing options are:

    - 0: drive low
    - 1: drive high
    - 2: input with interrupt triggering
    - 3: LDO on
    - 4: LDO off
    - 5~7: floating (or ADC)

ChenYu
