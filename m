From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 12 Mar 2015 15:51:50 +0000
Subject: [PATCH v2 3/6] hw/char: pl011 don't keep setting the IRQ if
 nothing changed
In-Reply-To: <1425479753-18349-4-git-send-email-alex.bennee@linaro.org>
References: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
 <1425479753-18349-4-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA-RhZVe1qwKQ3LzfWbzYVcBQ-jrwTnhH0OX69GNtnoysw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2015 at 14:35, Alex Benn?e <alex.bennee@linaro.org> wrote:
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

Consider this sequence of events:

 * the guest does something causing the interrupt to
   be asserted; int_level and int_enabled are 1, and
   current_irq is also now 1. We call qemu_set_irq()
   to raise the interrupt with the GIC
 * we migrate the guest to another host
 * on the receiving end, QEMU is in a cleanly reset
   state, and so current_irq, int_level and int_enabled
   are all zero before incoming data arrives
 * int_level and int_enabled are both set to 1 from
   the incoming data stream
 * the GIC itself is set to the "interrupt is
   asserted" state by its own incoming data
 * current_irq remains zero, because it's not migrated
 * the guest is resumed, and does something to deassert
   the interrupt. the new 'flags' value is zero
 * because flags == s->current_irq, we don't call
   qemu_set_irq, and so we've just dropped the deassert
   of this interrupt on the floor.

-- PMM
