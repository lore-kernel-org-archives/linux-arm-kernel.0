From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Nov 2014 09:05:52 +0100
Subject: [PATCH v2 1/2] pinctrl: rockchip: Handle wakeup pins
In-Reply-To: <1416437493-25588-2-git-send-email-dianders@chromium.org>
References: <1416437493-25588-1-git-send-email-dianders@chromium.org>
 <1416437493-25588-2-git-send-email-dianders@chromium.org>
Message-ID: <CACRpkdYT4hBrQdkRcqzG4=435MTTWkA2YOsq4y-6gEkLNmQD5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 11:51 PM, Doug Anderson <dianders@chromium.org> wrote:

> The rockchip pinctrl driver was using irq_gc_set_wake() as its
> implementation of irq_set_wake() but was totally ignoring everything
> that irq_gc_set_wake() did (which is to upkeep gc->wake_active).
>
> Let's fix that by setting gc->wake_active as GPIO_INTEN at suspend
> time and restoring GPIO_INTEN at resume time.
>
> NOTE a few quirks when thinking about this patch:
> - Rockchip pinctrl hardware supports both "disable/enable" and
>   "mask/unmask".  Right now we only use "disable/enable" and present
>   those to Linux as "mask/unmask".  This should be OK because
>   enable/disable is optional and Linux will implement it in terms of
>   mask/unmask.  At the moment we always tell hardware all interrupts
>   are unmasked (the boot default).
> - At suspend time Linux tries to call "disable" on all interrupts and
>   also enables wakeup on all wakeup interrupts.  One would think that
>   since "disable" is implemented as "mask" when "disable" isn't
>   provided and that since we were ignoring gc->wake_active that
>   nothing would have woken us up.  That's not the case since Linux
>   "optimizes" things and just leaves interrutps unmasked, assuming it
>   could mask them later when they go off.  That meant that at suspend
>   time all interrupts were actually being left enabled.
>
> With this patch random non-wakeup interrupts no longer wake the system
> up.  Wakeup interrupts still wake the system up.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Changes in v2: None

Patch applied.

Yours,
Linus Walleij
