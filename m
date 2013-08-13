From: dsd@laptop.org (Daniel Drake)
Date: Tue, 13 Aug 2013 16:53:39 -0600
Subject: [PATCH v6 02/11] irqchip: mmp: support irqchip
In-Reply-To: <CAMLZHHTsYqSB-dPGZvAZT+aJ70sbV679CyJgm-V6-Q7NFtgVbQ@mail.gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <1374833133-21119-3-git-send-email-haojian.zhuang@gmail.com>
 <CAMLZHHTsYqSB-dPGZvAZT+aJ70sbV679CyJgm-V6-Q7NFtgVbQ@mail.gmail.com>
Message-ID: <CAMLZHHQF2xAC8McNyH_8Ln-yVAUegHKk9wJqQd7LY9KhMRciuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 4:53 PM, Daniel Drake <dsd@laptop.org> wrote:

> This patch causes boot to fail, tested on OLPC XO-1.75 (MMP2).
>
> Calibrating delay loop... irq 13, desc: db804740, depth: 1, count: 0,
> unhandled: 0
> ->handle_irq():  c00704f4, handle_bad_irq+0x0/0x214
> ->irq_data.chip(): c05aa2e8, 0xc05aa2e8
> ->action():   (null)
>    IRQ_NOPROBE set
>  IRQ_NOREQUEST set
>
> continues as infinite loop.
>
> I had a poke, trying to figure out what would have caused this,
> without much luck. I tried to go back to irq_domain_add_legacy() and
> sprinkled some icu_mask_irq() calls around, nothing changed. Any
> ideas?

In my above experiments I was assuming things were crashing during the
IRQ setup path (e.g mmp_setup_bases). That was wrong - I now realise
that the setup code moved around by this patch exits OK, then the
timer driver loads and requests + unmasks interrupt 13, and these
messages start appearing upon the first interrupt which happens right
after.

It is not happy because no IRQ handler was registered. This is
normally done by mmp_irq_domain_map(), previously called immediately
from irq_domain_add_legacy().
Now that we moved to irq_domain_add_linear() in this patch, the map
function is not called.
I fixed this by calling irq_set_chip_and_handler() and set_irq_flags()
in the loop immediately after where irq_create_mapping() is used, as
is done by irq-bcm2835.c.

Now I get a new crash, still handling the first interrupt. In
icu_mask_ack_irq(), d->domain is NULL. We dereference it, causing a
crash. The domain field should have been set by irq_create_mapping().

What actually happens is that early_irq_init (kernel/irqdesc.c)
allocates 16 interrupt descriptors even before we've looked at the
device tree. Are those "legacy" interrupts? I can't figure out what
that is supposed to mean. Then the interrupts registered by irq-mmp.c
start at 16 (e.g. hwirq 0 becomes virq 16).

When the hardware interrupt 13 comes in, the call chain is:
handle_IRQ()
generic_handle_irq()
handle_level_irq()
icu_mask_ack_irq()

generic_handle_irq() above looks up the descriptor for IRQ 13, but it
does it without considering the mapping. So it picks up the descriptor
for "legacy" interrupt 13 and passes that to icu_mask_ack_irq() -
rather than passing the descriptor for the hwirq 13 that irq-mmp.c
registered and was expecting (i.e. no translation was performed).

How is this supposed to work?

Thanks
Daniel
