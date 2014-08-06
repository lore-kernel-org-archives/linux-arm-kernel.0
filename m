From: dianders@chromium.org (Doug Anderson)
Date: Wed, 6 Aug 2014 15:46:21 -0700
Subject: [PATCH v4 2/2] pwm: rockchip: Added to support for RK3288 SoC
In-Reply-To: <1406197295-10604-3-git-send-email-caesar.wang@rock-chips.com>
References: <1406197295-10604-1-git-send-email-caesar.wang@rock-chips.com>
 <1406197295-10604-3-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <CAD=FV=V4Kp-H3CcAKZPV1jBnYX+Ntwvxx6RB13TLxS5RRPHTWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Thu, Jul 24, 2014 at 3:21 AM, Caesar Wang <caesar.wang@rock-chips.com> wrote:
> +static const struct rockchip_pwm_data pwm_data_v1 = {
> +       .regs.duty = PWM_HRC,
> +       .regs.period = PWM_LRC,
> +       .regs.cntr = PWM_CNTR,
> +       .regs.ctrl = PWM_CTRL,
> +       .prescaler = PRESCALER,
> +       .set_enable = rockchip_pwm_set_enable_v1,
> +};
> +
> +static const struct rockchip_pwm_data pwm_data_v2 = {
> +       .regs.duty = PWM_LRC,
> +       .regs.period = PWM_HRC,
> +       .regs.cntr = PWM_CNTR,
> +       .regs.ctrl = PWM_CTRL,
> +       .prescaler = PRESCALER-1,
> +       .set_enable = rockchip_pwm_set_enable_v2,
> +};
> +
> +static const struct rockchip_pwm_data pwm_data_vop = {
> +       .regs.duty = PWM_LRC,
> +       .regs.period = PWM_HRC,
> +       .regs.cntr = PWM_CTRL,
> +       .regs.ctrl = PWM_CNTR,

Did you really mean to flip CTRL and CNTR here?  If so, that's super
confusing and deserves a comment.  AKA, I think the above should not
be:

 +       .regs.cntr = PWM_CTRL,
 +       .regs.ctrl = PWM_CNTR,

...but should be

 +       .regs.cntr = PWM_CNTR,
 +       .regs.ctrl = PWM_CTRL,

If you didn't mean to flip CTRL and CNTR here, then just get rid of
pwm_data_vop and refer to pwm_data_v2.  In fact, I'd suggest that you
totally remove the "rockchip,vop-pwm" since there's nothing different
between "rockchip,rk3288-pwm" and "rockchip,vop-pwm".


Have you validated Thierry's suggestion to allow you to access your
memory range?

-Doug
