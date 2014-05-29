From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 29 May 2014 20:32:44 +0200
Subject: [PATCH 5/5] pinctrl: sunxi: Implement multiple interrupt banks
 support
In-Reply-To: <CAGb2v65-3ddhaiF-CMdem9NHHibboQYaqXC1axDX+VcpWSLPxw@mail.gmail.com>
References: <1401272851-15873-1-git-send-email-maxime.ripard@free-electrons.com>
 <1401272851-15873-6-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65KU9UYU9Vn7X0b4-hE7WJchPxuF1UQDeECqc=-147gsA@mail.gmail.com>
 <CAGb2v65-3ddhaiF-CMdem9NHHibboQYaqXC1axDX+VcpWSLPxw@mail.gmail.com>
Message-ID: <20140529183244.GX4730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 08:04:00PM +0800, Chen-Yu Tsai wrote:
> On Wed, May 28, 2014 at 7:47 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> > Hi,
> >
> > On Wed, May 28, 2014 at 6:27 PM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> >> The A23 and A31 support multiple interrupt banks. Support it by adding a linear
> >> domain covering all the banks. It's trickier than it should because there's an
> >> interrupt per bank, so we have multiple interrupts using the same domain.
> >>
> >> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >> ---
> >>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 62 +++++++++++++++++++++++++++--------
> >>  drivers/pinctrl/sunxi/pinctrl-sunxi.h | 11 +++++--
> >>  2 files changed, 57 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> index 71d6cd10d56f..69b58aacc636 100644
> >> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> @@ -635,17 +635,25 @@ static void sunxi_pinctrl_irq_handler(unsigned irq, struct irq_desc *desc)
> >>  {
> >>         struct irq_chip *chip = irq_get_chip(irq);
> >>         struct sunxi_pinctrl *pctl = irq_get_handler_data(irq);
> >> -       const unsigned long reg = readl(pctl->membase + IRQ_STATUS_REG);
> >> +       unsigned long bank, reg, val;
> >> +
> >> +       for (bank = 0; bank < pctl->desc->irq_banks; bank++)
> >> +               if (irq == pctl->irq[bank])
> >> +                       break;
> >
> > bail out or BUG_ON(bank == pctl->desc->irq_banks)?
> > (dumb question: would this even happen?)
> >
> >> +
> >> +       reg = sunxi_irq_status_reg_from_bank(bank);
> >> +       val = readl(pctl->membase + reg);
> >>
> >>         /* Clear all interrupts */
> >> -       writel(reg, pctl->membase + IRQ_STATUS_REG);
> >> +       writel(val, pctl->membase + reg);
> >>
> >> -       if (reg) {
> >> +       if (val) {
> >>                 int irqoffset;
> >>
> >>                 chained_irq_enter(chip, desc);
> >> -               for_each_set_bit(irqoffset, &reg, SUNXI_IRQ_NUMBER) {
> >> -                       int pin_irq = irq_find_mapping(pctl->domain, irqoffset);
> >> +               for_each_set_bit(irqoffset, &val, SUNXI_IRQ_NUMBER) {
> >> +                       int pin_irq = irq_find_mapping(pctl->domain,
> >> +                                                      bank * SUNXI_IRQ_NUMBER + irqoffset);
> >>                         generic_handle_irq(pin_irq);
> >>                 }
> >>                 chained_irq_exit(chip, desc);
> >> @@ -713,8 +721,11 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
> >>
> >>                 while (func->name) {
> >>                         /* Create interrupt mapping while we're at it */
> >> -                       if (!strcmp(func->name, "irq"))
> >> -                               pctl->irq_array[func->irqnum] = pin->pin.number;
> >> +                       if (!strcmp(func->name, "irq")) {
> >> +                               int irqnum = func->irqnum + func->irqbank * SUNXI_IRQ_NUMBER;
> >> +                               pctl->irq_array[irqnum] = pin->pin.number;
> >> +                       }
> >> +
> >>                         sunxi_pinctrl_add_function(pctl, func->name);
> >>                         func++;
> >>                 }
> >> @@ -784,6 +795,13 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
> >>         pctl->dev = &pdev->dev;
> >>         pctl->desc = desc;
> >>
> >> +       pctl->irq_array = devm_kcalloc(&pdev->dev,
> >> +                                      SUNXI_IRQ_NUMBER * pctl->desc->irq_banks,
> >> +                                      sizeof(*pctl->irq_array),
> >> +                                      GFP_KERNEL);
> >> +       if (!pctl->irq_array)
> >> +               return -ENOMEM;
> >> +
> >>         ret = sunxi_pinctrl_build_state(pdev);
> >>         if (ret) {
> >>                 dev_err(&pdev->dev, "dt probe failed: %d\n", ret);
> >> @@ -868,21 +886,34 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
> >>         if (ret)
> >>                 goto gpiochip_error;
> >>
> >> -       pctl->irq = irq_of_parse_and_map(node, 0);
> >> +       pctl->irq = devm_kcalloc(&pdev->dev,
> >> +                                pctl->desc->irq_banks,
> >> +                                sizeof(*pctl->irq),
> >> +                                GFP_KERNEL);
> >>         if (!pctl->irq) {
> >> -               ret = -EINVAL;
> >> +               ret = -ENOMEM;
> >>                 goto clk_error;
> >>         }
> >>
> >> -       pctl->domain = irq_domain_add_linear(node, SUNXI_IRQ_NUMBER,
> >> -                                            &irq_domain_simple_ops, NULL);
> >> +       for (i = 0; i < pctl->desc->irq_banks; i++) {
> >> +               pctl->irq[i] = platform_get_irq(pdev, i);
> >> +               if (pctl->irq[i] < 0) {
> >> +                       ret = pctl->irq[i];
> >> +                       goto clk_error;
> >> +               }
> >> +       }
> >> +
> >> +       pctl->domain = irq_domain_add_linear(node,
> >> +                                            pctl->desc->irq_banks * SUNXI_IRQ_NUMBER,
> >> +                                            &irq_domain_simple_ops,
> >> +                                            NULL);
> >>         if (!pctl->domain) {
> >>                 dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
> >>                 ret = -ENOMEM;
> >>                 goto clk_error;
> >>         }
> >>
> >> -       for (i = 0; i < SUNXI_IRQ_NUMBER; i++) {
> >> +       for (i = 0; i < (pctl->desc->irq_banks * SUNXI_IRQ_NUMBER); i++) {
> >>                 int irqno = irq_create_mapping(pctl->domain, i);
> >>
> >>                 irq_set_chip_and_handler(irqno, &sunxi_pinctrl_irq_chip,
> >> @@ -890,8 +921,11 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
> >>                 irq_set_chip_data(irqno, pctl);
> >>         };
> >>
> >> -       irq_set_chained_handler(pctl->irq, sunxi_pinctrl_irq_handler);
> >> -       irq_set_handler_data(pctl->irq, pctl);
> >> +       for (i = 0; i < pctl->desc->irq_banks; i++) {
> >> +               irq_set_chained_handler(pctl->irq[i],
> >> +                                       sunxi_pinctrl_irq_handler);
> >> +               irq_set_handler_data(pctl->irq[i], pctl);
> >> +       }
> >>
> >>         dev_info(&pdev->dev, "initialized sunXi PIO driver\n");
> >>
> >> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> >> index 7ddcce0f3c27..e4a808e66fd2 100644
> >> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> >> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
> >> @@ -68,6 +68,8 @@
> >>  #define IRQ_STATUS_IRQ_BITS            1
> >>  #define IRQ_STATUS_IRQ_MASK            ((1 << IRQ_STATUS_IRQ_BITS) - 1)
> >>
> >> +#define IRQ_MEM_SIZE           0x20
> >> +
> >>  #define IRQ_EDGE_RISING                0x00
> >>  #define IRQ_EDGE_FALLING       0x01
> >>  #define IRQ_LEVEL_HIGH         0x02
> >> @@ -115,8 +117,8 @@ struct sunxi_pinctrl {
> >>         unsigned                        nfunctions;
> >>         struct sunxi_pinctrl_group      *groups;
> >>         unsigned                        ngroups;
> >> -       int                             irq;
> >> -       int                             irq_array[SUNXI_IRQ_NUMBER];
> >> +       int                             *irq;
> >> +       unsigned                        *irq_array;
> >>         spinlock_t                      lock;
> >>         struct pinctrl_dev              *pctl_dev;
> >>  };
> >> @@ -250,6 +252,11 @@ static inline u32 sunxi_irq_ctrl_offset(u16 irq)
> >>         return irq_num * IRQ_CTRL_IRQ_BITS;
> >>  }
> >>
> >> +static inline u32 sunxi_irq_status_reg_from_bank(u8 bank)
> >> +{
> >> +       return IRQ_STATUS_REG + bank * IRQ_MEM_SIZE;
> >> +}
> >> +
> >>  static inline u32 sunxi_irq_status_reg(u16 irq)
> >>  {
> >>         u8 reg = irq / IRQ_STATUS_IRQ_PER_REG * 0x04;
> 
> Sorry, missed this. You should also change 0x04 to IRQ_MEM_SIZE
> (I believe that was the original intention?) for sunxi_irq_*_reg.
> 
> This should fix the mask/unmask/set_type callbacks.

Hmm right. I completely missed this, and used a PA* pin, so it never
made any difference.

I'm sending a new version.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140529/7dc0fb98/attachment.sig>
