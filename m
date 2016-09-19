From: dianders@chromium.org (Doug Anderson)
Date: Mon, 19 Sep 2016 08:15:30 -0700
Subject: [PATCH] arm: dts: fix rk3066a based boards vdd_log voltage
 initialization
In-Reply-To: <1474274696-28090-1-git-send-email-andy.yan@rock-chips.com>
References: <1474274639-27768-1-git-send-email-andy.yan@rock-chips.com>
 <1474274696-28090-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <CAD=FV=VawAOWBF_PoXqSj3oiVgfF8SnCBp56p8F==XsaVLmMcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 19, 2016 at 1:44 AM, Andy Yan <andy.yan@rock-chips.com> wrote:
> The current rk3066a based boards(Rayeager, Bqcurie2, Marsboard) use
> pwm modulate vdd_logic voltage, but the pwm is default disabled and
> the pwm pin acts as a gpio before pwm regulator probed, so the pwm
> regulator driver will get a zero dutycycle at probe time, so change
> the initial dutycycle to zero to match pwm_regulator_init_state check.
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>
> ---
>
>  arch/arm/boot/dts/rk3066a-bqcurie2.dts  | 2 +-
>  arch/arm/boot/dts/rk3066a-marsboard.dts | 2 +-
>  arch/arm/boot/dts/rk3066a-rayeager.dts  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> index bc674ee..618450d 100644
> --- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> +++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> @@ -61,7 +61,7 @@
>                 regulator-min-microvolt = <1200000>;
>                 regulator-max-microvolt = <1200000>;
>                 regulator-always-on;
> -               voltage-table = <1000000 100>,
> +               voltage-table = <1000000 0>,

In my opinion this isn't quite the right answer.  I think that you
should add a new property describing the voltage in the case that the
pin is an input and you should fill that property in, like:

  voltage-when-input = <1000000>;

Once you have this property you should ideally be able to read whether
the pin is currently configured as an input or as a special function
at bootup.  Note that I don't actually know if this is possible with
the current pinctrl API, but it does seem like the ideal way to do it
since it means you'll work even if the BIOS changes (AKA: if the BIOS
leaves the pin as an input you can keep the voltage the same and if
the BIOS leaves the pin as PWM you can keep the voltage the same).

It's also possible that you could just add a property that says "init
to a certain value at bootup no matter what the BIOS left it as".  As
long as that voltage is the maximum (and you'll lower it later) this
ought to be safe and you shouldn't risk temporarily undervolting
things.


Note that, if you haven't already done so, you almost certainly want
to make sure your pinctrl species an "init" state in addition to a
"default" state.  See <https://patchwork.kernel.org/patch/7454311/>.

-Doug
