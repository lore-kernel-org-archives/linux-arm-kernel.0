From: rabin@rab.in (Rabin Vincent)
Date: Mon, 17 Jan 2011 22:26:04 +0530
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <4D3466AF.9030300@stericsson.com>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTik8J5M-+gk=qXZug3yXteWQGu0nFjOsSMETzJNS@mail.gmail.com>
	<4D3466AF.9030300@stericsson.com>
Message-ID: <AANLkTinFBd9sN01jtHtpTonZN=nvoFFnsYQjHN=4ucSU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 21:26, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> On 01/17/2011 04:36 PM, Rabin Vincent wrote:
>> On Mon, Jan 17, 2011 at 20:07, Linus Walleij <linus.walleij@stericsson.com> ?wrote:
>>> ? ? ? ?writel(datactrl, base + MMCIDATACTRL);
>>> - ? ? ? writel(readl(base + MMCIMASK0)& ?~MCI_DATAENDMASK, base +
>>> MMCIMASK0);
>>> - ? ? ? mmci_set_mask1(host, irqmask);
>>> + ? ? ? irqmask0 = readl(base + MMCIMASK0);
>>> + ? ? ? if (variant->broken_blockend)
>>> + ? ? ? ? ? ? ? irqmask0&= ~MCI_DATABLOCKENDMASK;
>>> + ? ? ? else
>>> + ? ? ? ? ? ? ? irqmask0 |= MCI_DATABLOCKENDMASK;
>>> + ? ? ? irqmask0&= ~MCI_DATAENDMASK;
>>> + ? ? ? writel(irqmask0, base + MMCIMASK0);
>>> + ? ? ? mmci_set_mask1(host, irqmask1);
>>> ?}
>>>
>>
>> If your intention is to not have to mask MCI_DATABLOCKENDMASK off, why
>> are you doing so?
>>
> The intention is to turn it off for HW which we know is broken,
> (has broken_blocken set true) which is what happens above.

Right, but don't you already remove the place where it was being set?

| -       mask = MCI_IRQENABLE;
| -       /* Don't use the datablockend flag if it's broken */
| -       if (variant->broken_blockend)
| -               mask &= ~MCI_DATABLOCKEND;
| -
| -       writel(mask, host->base + MMCIMASK0);
| +       writel(MCI_IRQENABLE, host->base + MMCIMASK0);
|
|        amba_set_drvdata(dev, mmc);
|
| diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
| index df06f01..7ac8c4d 100644
| --- a/drivers/mmc/host/mmci.h
| +++ b/drivers/mmc/host/mmci.h
| @@ -137,7 +137,7 @@
|  #define MCI_IRQENABLE  \
|        (MCI_CMDCRCFAILMASK|MCI_DATACRCFAILMASK|MCI_CMDTIMEOUTMASK|     \
|        MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|       \
| -       MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATABLOCKENDMASK)
| +       MCI_CMDRESPENDMASK|MCI_CMDSENTMASK)
|
