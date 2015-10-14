From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 14 Oct 2015 20:04:44 +0200
Subject: [PATCH 5/5] arm: dts: lpc32xx: add device node for the second pwm
 controller
In-Reply-To: <1444694045-22000-6-git-send-email-vz@mleia.com>
References: <1444694045-22000-1-git-send-email-vz@mleia.com>
 <1444694045-22000-6-git-send-email-vz@mleia.com>
Message-ID: <CAGhQ9Vx9ghfAD0=ntsFL50+iBQDag=HHGb6=X2-AfYPtSb_-yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 13 October 2015 at 01:54, Vladimir Zapolskiy <vz@mleia.com> wrote:
> LPC32xx SoCs have two independent PWM controllers, they have different
> clock parents, clock gates and even slightly different controls,
> each of these two PWM controllers has one output channel. Due to
> almost similar controls arranged in a row it is incorrectly assumed
> that there is one PWM controller with two channels, fix this problem
> in lpc32xx.dtsi, which at the moment prevents separate configuration
> of different clock parents and gates for both PWM controllers.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/boot/dts/lpc32xx.dtsi | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
> index 929458d..f4d2a0e 100644
> --- a/arch/arm/boot/dts/lpc32xx.dtsi
> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
> @@ -286,9 +286,15 @@
>                                 status = "disabled";
>                         };
>
> -                       pwm: pwm at 4005C000 {
> +                       pwm1: pwm at 4005C000 {
>                                 compatible = "nxp,lpc3220-pwm";
> -                               reg = <0x4005C000 0x8>;
> +                               reg = <0x4005C000 0x4>;
> +                               status = "disabled";
> +                       };
> +
> +                       pwm2: pwm at 4005C004 {
> +                               compatible = "nxp,lpc3220-pwm";
> +                               reg = <0x4005C004 0x4>;
>                                 status = "disabled";
>                         };
>                 };

I am not really against your change, but...

What's wrong with a binding like the one below?
pwm: pwm at 0x4005c000 {
    compatible = "nxp,lpc3220-pwm";
    reg = <0x4005C000 0x8>;
    clocks =<&clk CLK_PWM1, &clk CLK_PWM2>;
    clock-names = "pwm1", "pwm2";
    #pwm-cells = <3>;
};

With two clocks and where the first pwm-cell would select either PWM1 or PWM2.

Seems like the driver only handle one clock, but should be fairly easy to fix.

Note: with your DT change you would also need to change the driver
since it currently sets npwm to 2.


regards,
Joachim Eastwood
