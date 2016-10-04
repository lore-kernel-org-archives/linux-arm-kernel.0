From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Oct 2016 14:23:51 +0200
Subject: [PATCH] dmaengine: coh901318: fix integer overflow when shifting
 more than 32 places
In-Reply-To: <1475172392.2027.12.camel@perches.com>
References: <20160929175725.14157-1-colin.king@canonical.com>
 <1475172392.2027.12.camel@perches.com>
Message-ID: <CACRpkdZ1gfZu=Snh9YK1X9w+ZW-zcuEFh8aojGi-LUKoyMKcCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 8:06 PM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2016-09-29 at 18:57 +0100, Colin King wrote:
>> Currently U300_DMA_CHANNELS is set to 40, meaning that the shift of 1 can
>> be more than 32 places, which leads to a 32 bit integer overflow. Fix this
>> by casting 1 to a u64 (the same type as started_channels) before shifting
>> it.
>
> trivia:
>
>> diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
> []
>> @@ -1353,7 +1353,7 @@ static ssize_t coh901318_debugfs_read(struct file *file, char __user *buf,
>>       tmp += sprintf(tmp, "DMA -- enabled dma channels\n");
>>
>>       for (i = 0; i < U300_DMA_CHANNELS; i++)
>> -             if (started_channels & (1 << i))
>> +             if (started_channels & ((u64)1 << i))
>
> Using
>
>                 if (started_channels & (1ULL << i))
>
> would be more common.

Even better (IMO):

#include <linux/bitops.h>

if (started_channels & BIT(i))

Apparently code is there to avoid the bit 31 problem, mea culpa.

Yours,
Linus Walleij
