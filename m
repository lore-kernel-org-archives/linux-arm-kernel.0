From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Oct 2016 01:30:13 +0200
Subject: [PATCH] pinctrl: st: don't specify default interrupt trigger
In-Reply-To: <1476774988-13484-1-git-send-email-patrice.chotard@st.com>
References: <1476774988-13484-1-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdbZq0O4jr_vO5Eet5vqpR+XuTrM7qALehiRqo1Ra1m3rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 9:16 AM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> Thanks to 332e99d5ae4 which now alerts of default
> trigger usage when configuring interrupts.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Patch applied with Peter's ACK.

Pls also look into the following: __gpio_irq_handler seems to be
doing some stuff per-IRQ that only pertains to edge-triggered IRQs.
Normally that should be handled by:

- Setting default handler to handle_bad_irq()
- Setting handler to handle_edge_irq() or handle_level_irq() in .set_type()
- Implement .irq_ack() on the irqchip and handle the edge-specific ACKing
  there.

See for example drivers/gpio/gpio-pl061.c.

I am not *sure* this applies to pinctrl-st.c but please check if it provides
more elegant code. Notmally the .irq_ack() is for edge detection hardware
that allows ACKing the ege IRQ in a separate register and after that we
can raise another edge IRQ while the current IRQ is being handled.

Yours,
Linus Walleij
