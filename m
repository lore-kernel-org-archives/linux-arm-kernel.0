From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Jul 2014 23:39:16 +0200
Subject: [PATCH v3 4/4] pinctrl: sunxi: Define enable / disable irq
 callbacks for level triggered irqs
In-Reply-To: <1404051062-24079-5-git-send-email-hdegoede@redhat.com>
References: <1404051062-24079-1-git-send-email-hdegoede@redhat.com>
 <1404051062-24079-5-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdZ15gMYp2ZSAhNzZMzqWx2xXwMmeKzVudQcVUqiziTW_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 4:11 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> Some drivers use disable_irq / enable_irq and do the work clearing the source
> in another thread instead of using a threaded interrupt handler.
>
> The irqchip used not having irq_disable and irq_enable callbacks in this case,
> will lead to unnecessary spurious interrupts:
>
> On a disable_irq in a chip without a handller for this, the irq core will
> remember the disable, but not actually call into the irqchip. With a level
> triggered interrupt (where the source has not been cleared) this will lead
> to an immediate retrigger, at which point the irq-core will mask the irq.
> So having an irq_disable callback in the irqchip will save us the interrupt
> firing a 2nd time for nothing.
>
> Drivers using disable / enable_irq like this, will call enable_irq when
> they finally have cleared the interrupt source, without an enable_irq callback,
> this will turn into an unmask, at which point the irq will trigger immediately
> because when it was originally acked the level was still high, so the ack was
> a nop.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
