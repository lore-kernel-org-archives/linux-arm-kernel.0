From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Jun 2013 17:02:49 +0200
Subject: [PATCH v4 02/10] pinctrl: mvebu: dove pinctrl driver
In-Reply-To: <20130618113606.GA26763@n2100.arm.linux.org.uk>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130618113606.GA26763@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZTVN2O-Rv4u-Ccb9EzV0At3zc7GYQyTq=HkseOi=GTeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 1:36 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Maybe what we need is something like this:
>
> static DEFINE_SPINLOCK(io_lock);
> static void modifyl(u32 new, u32 mask, void __iomem *reg)
> {
>         unsigned long flags;
>         u32 val;
>
>         spin_lock_irqsave(&io_lock, flags);
>         val = readl(reg) & ~mask;
>         val |= new | mask;
>         writel(val, reg);
>         spin_unlock_irqrestore(&io_lock, flags);
> }
>
> in order to provide arbitrated access to these kinds of multifunction
> registers in a safe, platform agnostic way.

Nowadays I would do the above with regmap_update_bits().

Mutual exclusion for read-modify-write of individual bits in a
register is one of those cases where doing a regmap over
a memory-mapped register range makes a lot of sense.
(drivers/mfd/syscon.c being a nice example)

Yours,
Linus Walleij
