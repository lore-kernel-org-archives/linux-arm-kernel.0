From: rabin@rab.in (Rabin Vincent)
Date: Mon, 17 Jan 2011 21:06:47 +0530
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTik8J5M-+gk=qXZug3yXteWQGu0nFjOsSMETzJNS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 20:07, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> - ? ? ? ?* In the U300, the IRQs can arrive out-of-order,
> - ? ? ? ?* e.g. MCI_DATABLOCKEND sometimes arrives after MCI_DATAEND,
> - ? ? ? ?* so for this case we use the flags "blockend" and
> - ? ? ? ?* "dataend" to make sure both IRQs have arrived before
> - ? ? ? ?* concluding the transaction.

Since this was your original rationale for adding the "blockend" flag,
why don't you just remove that flag in this patch instead of renaming to
last_blockend and still keeping it around?

On Mon, Jan 17, 2011 at 20:07, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> Also make sure the MCI_DATABLOCKENDMASK is set only when
> needed, instead of being set always and then masked off.

This seems to be unrelated to the actual problem this patch is trying to
solve.

> ? ? ? ?writel(datactrl, base + MMCIDATACTRL);
> - ? ? ? writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
> - ? ? ? mmci_set_mask1(host, irqmask);
> + ? ? ? irqmask0 = readl(base + MMCIMASK0);
> + ? ? ? if (variant->broken_blockend)
> + ? ? ? ? ? ? ? irqmask0 &= ~MCI_DATABLOCKENDMASK;
> + ? ? ? else
> + ? ? ? ? ? ? ? irqmask0 |= MCI_DATABLOCKENDMASK;
> + ? ? ? irqmask0 &= ~MCI_DATAENDMASK;
> + ? ? ? writel(irqmask0, base + MMCIMASK0);
> + ? ? ? mmci_set_mask1(host, irqmask1);
> ?}

If your intention is to not have to mask MCI_DATABLOCKENDMASK off, why
are you doing so?
