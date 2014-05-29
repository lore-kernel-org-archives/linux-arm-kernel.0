From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 29 May 2014 19:59:37 +0200
Subject: [PATCH 5/5] pinctrl: sunxi: Implement multiple interrupt banks
 support
In-Reply-To: <CAGb2v65KU9UYU9Vn7X0b4-hE7WJchPxuF1UQDeECqc=-147gsA@mail.gmail.com>
References: <1401272851-15873-1-git-send-email-maxime.ripard@free-electrons.com>
 <1401272851-15873-6-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65KU9UYU9Vn7X0b4-hE7WJchPxuF1UQDeECqc=-147gsA@mail.gmail.com>
Message-ID: <20140529175937.GW4730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 07:47:15PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Wed, May 28, 2014 at 6:27 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The A23 and A31 support multiple interrupt banks. Support it by adding a linear
> > domain covering all the banks. It's trickier than it should because there's an
> > interrupt per bank, so we have multiple interrupts using the same domain.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 62 +++++++++++++++++++++++++++--------
> >  drivers/pinctrl/sunxi/pinctrl-sunxi.h | 11 +++++--
> >  2 files changed, 57 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> > index 71d6cd10d56f..69b58aacc636 100644
> > --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> > +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> > @@ -635,17 +635,25 @@ static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
> >  {
> >         struct irq_chip *chip = irq_get_chip(irq);
> >         struct sunxi_pinctrl *pctl = irq_get_handler_data(irq);
> > -       const unsigned long reg = readl(pctl->membase + IRQ_STATUS_REG);
> > +       unsigned long bank, reg, val;
> > +
> > +       for (bank = 0; bank < pctl->desc->irq_banks; bank++)
> > +               if (irq == pctl->irq[bank])
> > +                       break;
> 
> bail out or BUG_ON(bank == pctl->desc->irq_banks)?
> (dumb question: would this even happen?)

This can be a spurious interrupt, so I'd prefer to just bail out.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140529/6ea9a852/attachment.sig>
