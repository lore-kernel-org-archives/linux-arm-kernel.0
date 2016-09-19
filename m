From: dianders@chromium.org (Doug Anderson)
Date: Mon, 19 Sep 2016 09:38:34 -0700
Subject: [PATCH] arm: dts: fix rk3066a based boards vdd_log voltage
 initialization
In-Reply-To: <2318029.f7g774Bk76@phil>
References: <1474274639-27768-1-git-send-email-andy.yan@rock-chips.com>
 <1474274696-28090-1-git-send-email-andy.yan@rock-chips.com>
 <CAD=FV=VawAOWBF_PoXqSj3oiVgfF8SnCBp56p8F==XsaVLmMcg@mail.gmail.com>
 <2318029.f7g774Bk76@phil>
Message-ID: <CAD=FV=UOXcUZyXRj++GkKksyFedGt59vQz8958nhhF9UM7rOuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 19, 2016 at 9:15 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Montag, 19. September 2016, 08:15:30 CEST schrieb Doug Anderson:
>> Hi,
>>
>> On Mon, Sep 19, 2016 at 1:44 AM, Andy Yan <andy.yan@rock-chips.com> wrote:
>> > The current rk3066a based boards(Rayeager, Bqcurie2, Marsboard) use
>> > pwm modulate vdd_logic voltage, but the pwm is default disabled and
>> > the pwm pin acts as a gpio before pwm regulator probed, so the pwm
>> > regulator driver will get a zero dutycycle at probe time, so change
>> > the initial dutycycle to zero to match pwm_regulator_init_state check.
>> >
>> > Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>> >
>> > ---
>> >
>> >  arch/arm/boot/dts/rk3066a-bqcurie2.dts  | 2 +-
>> >  arch/arm/boot/dts/rk3066a-marsboard.dts | 2 +-
>> >  arch/arm/boot/dts/rk3066a-rayeager.dts  | 2 +-
>> >  3 files changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
>> > b/arch/arm/boot/dts/rk3066a-bqcurie2.dts index bc674ee..618450d 100644
>> > --- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
>> > +++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
>> > @@ -61,7 +61,7 @@
>> >
>> >                 regulator-min-microvolt = <1200000>;
>> >                 regulator-max-microvolt = <1200000>;
>> >                 regulator-always-on;
>> >
>> > -               voltage-table = <1000000 100>,
>> > +               voltage-table = <1000000 0>,
>>
>> In my opinion this isn't quite the right answer.  I think that you
>> should add a new property describing the voltage in the case that the
>> pin is an input and you should fill that property in, like:
>>
>>   voltage-when-input = <1000000>;
>
> I'd think this would be more of a pwm issue, not something the pwm-regulator
> should need to care about.
>
> Ideally the pwm driver should be able to return some state information even if
> disabled? I.e. deriving a duty-cycle value from its pin state similar to what
> Doug described below (it's either 0% or 100%)
>
> But right now I have a hard time understanding how the pwm could return any
> duty-cycle information for an input gpio to the pwm-regulator, as I assume the
> pwm-driver has to probe (and thus set pinctrl to the pwm function) before the
> pwm-regulator is able to get the pwm handle?

Hrm, right.  The PWM ought to own the pinctrl, not the regulator.
Hrm.  Then I guess this gets more complicated.

One thing to point out, though, is that an EE I talked to said that
the "voltage when input" is actually a well defined property and is
unrelated to the min/max voltage.  AKA: it's not guaranteed to be
equal to the 50% duty cycle.  ...so adding a property to the PWM
regulator that includes this value is something very sane.  The
"voltage when input" is defined by the pile of resistors and
capacitors that are used to actually make the PWM control the
regulator.

The "voltage when input" is super important because this is the
voltage that's used at bootup (when all pins are configured as inputs,
possible with a pull applied) and that's used during suspend time when
the PWM stops.

-Doug
