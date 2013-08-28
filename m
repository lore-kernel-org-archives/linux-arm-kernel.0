From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 21:50:09 +0200
Subject: [PATCH v4 1/3] ARM: bcm281xx: Add GPIO driver
In-Reply-To: <CAPdLdq=atsbY8QDzH-aaHJvLk1CDe5qK3phSGLVZSvm=FoncjA@mail.gmail.com>
References: <1376938761-13657-1-git-send-email-markus.mayer@linaro.org>
 <1376938761-13657-2-git-send-email-markus.mayer@linaro.org>
 <CACRpkdbm2cKpz2SrUgsUpB4x5xjm=Bz=VCu279sEAKFJ1x9SPg@mail.gmail.com>
 <CAPdLdqm+r1P=48Aujz9nuDb_vpFj-wBvmCV=oOKNZ0YENmbL1g@mail.gmail.com>
 <CAPdLdq=atsbY8QDzH-aaHJvLk1CDe5qK3phSGLVZSvm=FoncjA@mail.gmail.com>
Message-ID: <CACRpkdb1wjJh1qCq1Zke0MmL0WZsMKqA5NSJF571aMAKY1mOuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 9:30 PM, Markus Mayer <markus.mayer@linaro.org> wrote:

> I have a follow-up question regarding status reads for each iteration.
> Is this what you are looking for?
>
>         for (;;) {
>                 sta = readl(reg_base + GPIO_INT_STATUS(bank_id)) &
>                     (~(readl(reg_base + GPIO_INT_MASK(bank_id))));
>                 if (sta == 0)
>                         break;

Yes, but follow the design pattern of other drivers such as the
drivers/irqchip/irq-vic.c:

static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
{
        u32 stat, irq;
        int handled = 0;

        while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
                irq = ffs(stat) - 1;
                handle_IRQ(irq_find_mapping(vic->domain, irq), regs);
                handled = 1;
        }
}

I.e use that nice while-construction.

Yours,
Linus Walleij
