From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Jan 2015 10:39:56 +0100
Subject: [PATCH] pinctrl: rockchip: Only mask interrupts; never disable
In-Reply-To: <1422289444-15142-1-git-send-email-dianders@chromium.org>
References: <1422289444-15142-1-git-send-email-dianders@chromium.org>
Message-ID: <CACRpkdb-=brQmJT9oUwD1bqNLGHX9i+4LSuR4_Vi6BtKgaRKqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 5:24 PM, Doug Anderson <dianders@chromium.org> wrote:

> The Rockchip GPIO interrupt controller totally throws away all status
> about an interrupt when you "disable" the interrupt.  That has
> unfortunate consequences in the following situation:
>
> 1. An edge-triggered interrupt is enabled and should wake the system.
> 2. System suspend happens: interrupt is disabled and marked for wake.
> 3. rockchip_irq_suspend() reenables the interrupt so we can wake.
> 4. Interrupt happens when asleep.
> 5. rockchip_irq_resume() redisables the interrupt.
> 6. Disabling the interrupt throws away all status about it.
> 7. Normal system resume happens and we enable the interrupt again,
>    since we threw away status about the interrupt we don't know it
>    fired while suspended.  Even worse: if we need both edges of the
>    interrupt the logic to swap edges never runs.
>
> Note: even if we somehow can post the status about wakeup interrupts
> in rockchip_irq_resume() we would still have a window of losing any
> edges that came in while interrupts were disabled.
>
> If we use mask only then we don't need to worry.  The GPIO Interrupt
> controller keeps track of pending interrupts that are enabled and just
> masked.
>
> There was no real strong reason to support the enable/disable
> functionality (other than that it seemed right), so let's go back to
> just supporting mask/unmask but actually map it to the real
> mask/unmask.  This ends up with slightly different (and more correct)
> behavior than before (f2dd028 pinctrl: rockchip: Fix
> enable/disable/mask/unmask).
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Patch applied with Heiko's review tag, but not as a fix at this point,
it will be for v3.20.

Yours,
Linus Walleij
