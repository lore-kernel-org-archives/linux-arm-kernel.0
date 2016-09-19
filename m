From: dianders@chromium.org (Doug Anderson)
Date: Mon, 19 Sep 2016 10:22:43 -0700
Subject: [PATCH] arm: dts: fix rk3066a based boards vdd_log voltage
 initialization
In-Reply-To: <20160919191327.741a2b89@bbrezillon>
References: <1474274639-27768-1-git-send-email-andy.yan@rock-chips.com>
 <1474274696-28090-1-git-send-email-andy.yan@rock-chips.com>
 <CAD=FV=VawAOWBF_PoXqSj3oiVgfF8SnCBp56p8F==XsaVLmMcg@mail.gmail.com>
 <2318029.f7g774Bk76@phil>
 <CAD=FV=UOXcUZyXRj++GkKksyFedGt59vQz8958nhhF9UM7rOuw@mail.gmail.com>
 <20160919191327.741a2b89@bbrezillon>
Message-ID: <CAD=FV=Ufmvg1P8suOPQ53kpOD1pei4N2dOpKUCxZk001XKj_OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 19, 2016 at 10:13 AM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> Correct me if I'm wrong, but the main problem here is that, when we try
> to detect the initial regulator state, we ran into a "missing entry in
> the duty-cycle <-> voltage table" error, which then triggers an -EINVAL
> error preventing the PWM regulator probe to succeed.
>
> Of course, adding an entry for the 0% dutycle case would solve the
> issue, but I wonder if we should not allow "unknown value" at probe
> time, and let the regulator user set the voltage output when it claims
> it.
>
> Another option would be to fake a valid value in this case (choose the
> closest entry in the voltage table?).

If the goal is to avoid glitching the voltage at bootup, then the
above doesn't really solve it.

For instance, you could have:

0% - 1.5V
100% - 0.8V
When configured as input: 1.1V
Max useful value: 1.2V

So if firmware doesn't touch the PWM regulator then that means you're
booting up at 1.1V.

If you read out the PWM itself, it will claim that it's running at 0%.
While that's true, that doesn't mean that the voltage on the system is
actually 1.5V because at boot the system had configured the pinmux as
GPIO input.  ...so it's actually 1.1V because the PWM isn't actually
controlling the pins.

So if you want to avoid glitching the line then you want to make sure
that you properly init to 1.1V, _not_ to 1.5V.

In the case above, it's possible that 1.5V isn't really so great for
the hardware lifespan because 1.2V is the maximum useful value.  You
could argue that the hardware is badly designed in this case, but I
have certainly seen boards designed where the maximum achievable value
is higher than the maximum "safe" value.

-Doug
