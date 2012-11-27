From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Nov 2012 14:11:22 -0800
Subject: [PATCH] ARM: EXYNOS: Avoid early use of of_machine_is_compatible()
In-Reply-To: <1354045994-8977-1-git-send-email-dianders@chromium.org>
References: <1354045994-8977-1-git-send-email-dianders@chromium.org>
Message-ID: <CAOesGMjyXZwKjycyVcEV0ty0LCM_i61QxykYPhAvXxx2rhgP+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 11:53 AM, Doug Anderson <dianders@chromium.org> wrote:
> The recent commit "ARM: EXYNOS: add support for EXYNOS5440 SoC" broke
> support for exynos5250 because of_machine_is_compatible() was used too
> early in the boot process.  It also probably meant that the exynos5440
> failed to use the proper iotable.  Switch to use
> of_flat_dt_is_compatible() in both of these cases.
>
> The failure I was seeing in exynos5250 because of this was:
>   Division by zero in kernel.
>   [<80015ed4>] (unwind_backtrace+0x0/0xec) from [<8045c7a4>] (dump_stack+0x20/0x24)
>   [<8045c7a4>] (dump_stack+0x20/0x24) from [<80012990>] (__div0+0x20/0x28)
>   [<80012990>] (__div0+0x20/0x28) from [<8021ab04>] (Ldiv0_64+0x8/0x18)
>   [<8021ab04>] (Ldiv0_64+0x8/0x18) from [<80068560>] (__clocksource_updatefreq_scale+0x54/0x134)
>   [<80068560>] (__clocksource_updatefreq_scale+0x54/0x134) from [<8006865c>] (__clocksource_register_scale+0x1c/0x54)
>   [<8006865c>] (__clocksource_register_scale+0x1c/0x54) from [<80612a18>] (exynos_timer_init+0x100/0x1e8)
>   [<80612a18>] (exynos_timer_init+0x100/0x1e8) from [<8060d184>] (time_init+0x28/0x38)
>   [<8060d184>] (time_init+0x28/0x38) from [<8060a754>] (start_kernel+0x1e0/0x3c8)
>   [<8060a754>] (start_kernel+0x1e0/0x3c8) from [<40008078>] (0x40008078)
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Thanks Doug.

Kukjin, I'll apply this directly on top of the previous branch in
arm-soc, if that's OK with you.


-Olof
