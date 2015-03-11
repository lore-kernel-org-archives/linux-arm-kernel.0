From: greg.bellows@linaro.org (Greg Bellows)
Date: Wed, 11 Mar 2015 09:44:11 -0500
Subject: [Qemu-devel] [PATCH v2 3/6] hw/char: pl011 don't keep setting the
 IRQ if nothing changed
In-Reply-To: <1425479753-18349-4-git-send-email-alex.bennee@linaro.org>
References: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
 <1425479753-18349-4-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAOgzsHVVw-gZE0_O=NH3xn_4jV2+7=Adrs2tsogwKK_ofptL9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 4, 2015 at 8:35 AM, Alex Benn?e <alex.bennee@linaro.org> wrote:
> While observing KVM traces I can see additional IRQ calls on pretty much
> every MMIO access which is just plain inefficient. Only update the QEMU
> IRQ level if something has actually changed from last time. Otherwise we
> may be papering over other failure modes.
>
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 0a45115..bb554bc 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -36,6 +36,9 @@ typedef struct PL011State {
>      CharDriverState *chr;
>      qemu_irq irq;
>      const unsigned char *id;
> +
> +    /* not serialised, prevents pl011_update doing extra set_irqs */
> +    uint32_t current_irq;
>  } PL011State;
>
>  #define PL011_INT_TX 0x20
> @@ -53,10 +56,11 @@ static const unsigned char pl011_id_luminary[8] =
>
>  static void pl011_update(PL011State *s)
>  {
> -    uint32_t flags;
> -
> -    flags = s->int_level & s->int_enabled;
> -    qemu_set_irq(s->irq, flags != 0);
> +    uint32_t flags = s->int_level & s->int_enabled;
> +    if (flags != s->current_irq) {
> +        s->current_irq = flags;
> +        qemu_set_irq(s->irq, s->current_irq != 0);
> +    }
>  }
>
>  static uint64_t pl011_read(void *opaque, hwaddr offset,
> --
> 2.3.1
>
>

Did you find the source of the additional IRQs? This seems like it
could be potentially be hiding an issue.  From looking at the code, it
appears that one source of the additional updates is in pl011_read,
where we possibly do an update without a change in int_level.  I
wonder if finding and fixing the updates is a better approach.
