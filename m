From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 18 Jan 2011 16:01:48 +0100
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <AANLkTinFBd9sN01jtHtpTonZN=nvoFFnsYQjHN=4ucSU@mail.gmail.com>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTik8J5M-+gk=qXZug3yXteWQGu0nFjOsSMETzJNS@mail.gmail.com>
	<4D3466AF.9030300@stericsson.com>
	<AANLkTinFBd9sN01jtHtpTonZN=nvoFFnsYQjHN=4ucSU@mail.gmail.com>
Message-ID: <AANLkTikjSR_1jmTCdkef2bXgU8-ZU7E-+_pFznfNh8FO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/17 Rabin Vincent <rabin@rab.in>:
> On Mon, Jan 17, 2011 at 21:26, Linus Walleij
>> The intention is to turn it off for HW which we know is broken,
>> (has broken_blocken set true) which is what happens above.
>
> Right, but don't you already remove the place where it was being set?
>
> | - ? ? ? mask = MCI_IRQENABLE;
> | - ? ? ? /* Don't use the datablockend flag if it's broken */
> | - ? ? ? if (variant->broken_blockend)
> | - ? ? ? ? ? ? ? mask &= ~MCI_DATABLOCKEND;
> | -
> | - ? ? ? writel(mask, host->base + MMCIMASK0);
> | + ? ? ? writel(MCI_IRQENABLE, host->base + MMCIMASK0);
> |
> | ? ? ? ?amba_set_drvdata(dev, mmc);
> |
> | diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> | index df06f01..7ac8c4d 100644
> | --- a/drivers/mmc/host/mmci.h
> | +++ b/drivers/mmc/host/mmci.h
> | @@ -137,7 +137,7 @@
> | ?#define MCI_IRQENABLE ?\
> | ? ? ? ?(MCI_CMDCRCFAILMASK|MCI_DATACRCFAILMASK|MCI_CMDTIMEOUTMASK| ? ? \
> | ? ? ? ?MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK| ? ? ? \
> | - ? ? ? MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATABLOCKENDMASK)
> | + ? ? ? MCI_CMDRESPENDMASK|MCI_CMDSENTMASK)

Um, this shows I should really split the patch, yes MCI_DATABLOCKENDMASK
is removed as set by default, then added back depending on whether the
.broken_blockend flag is set or not.

In the code quoted earlier actually:

       writel(datactrl, base + MMCIDATACTRL);
-       writel(readl(base + MMCIMASK0)&  ~MCI_DATAENDMASK, base + MMCIMASK0);
-       mmci_set_mask1(host, irqmask);
+       irqmask0 = readl(base + MMCIMASK0);
+       if (variant->broken_blockend)
+               irqmask0&= ~MCI_DATABLOCKENDMASK;
+       else
+               irqmask0 |= MCI_DATABLOCKENDMASK;
+       irqmask0&= ~MCI_DATAENDMASK;
+       writel(irqmask0, base + MMCIMASK0);
+       mmci_set_mask1(host, irqmask1);

Sorry for the confusion...

Yours,
Linus Walleij
