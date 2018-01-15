From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 Jan 2018 09:38:13 +0100
Subject: [PATCH v1 4/4] ARM: dts: add pwm node for r40.
In-Reply-To: <CAJeuY78QLOYZUUS7ghakqqpdzigdvpdHCsw+6onkUCjgZMqTzA@mail.gmail.com>
References: <20180111113412.GA22008@arx-s1>
 <20180111124752.2ljspnaclwgz2s62@flea.lan>
 <CAJeuY78QLOYZUUS7ghakqqpdzigdvpdHCsw+6onkUCjgZMqTzA@mail.gmail.com>
Message-ID: <20180115083813.ad2yqdwnd2nskbhs@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 14, 2018 at 02:43:39PM +0800, Hao Zhang wrote:
> 2018-01-11 20:47 GMT+08:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> > On Thu, Jan 11, 2018 at 07:34:12PM +0800, hao_zhang wrote:
> >> This patch add pwm node for r40.
> >>
> >> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> >> ---
> >>  arch/arm/boot/dts/sun8i-r40.dtsi | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> >> index 173dcc1..84c963c 100644
> >> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> >> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> >> @@ -295,6 +295,11 @@
> >>                               bias-pull-up;
> >>                       };
> >>
> >> +                     pwm_pins: pwm-pins {
> >> +                             pins = "PB2", "PB3";
> >> +                             function = "pwm";
> >> +                     };
> >> +
> >
> > Is it the only combination of pins that is usable?
> >
> > If so, you can add the pinctrl-0 property directly in the pwm nodes.
> >
> 
> There are 8 channel pwm of R40/V40/T3, the pins that can be configed
> to pwm are: PB2, PB3, PI20, PI21, PB20, PB21, PB9, PB10

And a single controller, or several of them?

> PB2, PB3 can be configed on bananapi-m2-ultra and on my T3 board,
> but the other pins is not exist on the board or some pin is confilct
> with other functions, so i just add PB2, PB3. but i think split it
> is better, just like this :
> 
> pwm0_pin: pwm0-pin {
>     pins = "PB2";
>     function = "pwm";
> };
> 
> pwm1_pin: pwm1-pin {
>     pins = "PB3";
>     function = "pwm";
> };

Yep, that would be better. If it's just a matter of channels, maybe we
can even name them pwm-ch0-pin and pwm-ch1-pin? That would be more
explicit.

> the node of pwm2~7 should also be added here?

If there's no users, no.

> On sun8i-r40-bananapi-m2-ultra.dts:
> because of the special customize board, i think just add pinctrl-0 = <&pwm0_pin>
> (PB3 I just use to test pwm channel 1)for bananapi-m2-ultra board is enough.
> 
> &pwm {
>     pinctrl-names = "default";
>     pinctrl-0 = <&pwm0_pin>;
>     status = "okay";
> };

It depends if that PWM is used as a PWM all the time (for example to
drive a backlight for a panel tied to the board), or if it's exported
through one of the generic pin headers, please leave it populated but
disabled (with a comment that it is exported on one of the pin of the
headers)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180115/bee9321d/attachment.sig>
