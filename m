From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 17 Jan 2011 16:56:31 +0100
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <AANLkTik8J5M-+gk=qXZug3yXteWQGu0nFjOsSMETzJNS@mail.gmail.com>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTik8J5M-+gk=qXZug3yXteWQGu0nFjOsSMETzJNS@mail.gmail.com>
Message-ID: <4D3466AF.9030300@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2011 04:36 PM, Rabin Vincent wrote:
> On Mon, Jan 17, 2011 at 20:07, Linus Walleij
> <linus.walleij@stericsson.com>  wrote:
>    
>> -        * In the U300, the IRQs can arrive out-of-order,
>> -        * e.g. MCI_DATABLOCKEND sometimes arrives after MCI_DATAEND,
>> -        * so for this case we use the flags "blockend" and
>> -        * "dataend" to make sure both IRQs have arrived before
>> -        * concluding the transaction.
>>      
> Since this was your original rationale for adding the "blockend" flag,
> why don't you just remove that flag in this patch instead of renaming to
> last_blockend and still keeping it around?
>    

Because now I use it to soft-detect the error and auto-correct
when it occurs. (Try removing the broken_blockend flag
from Ux500 for example, see the prints and working
transfers.)

So as to get help from the code in future hardware.

Which is probably going to be useful, since I'm told that there
are actually two more drivers for PL180 derivates in the
kernel, just under different names... So one day when we
may consolidate them, such stuff is going to be helpful.

> On Mon, Jan 17, 2011 at 20:07, Linus Walleij
> <linus.walleij@stericsson.com>  wrote:
>    
>> Also make sure the MCI_DATABLOCKENDMASK is set only when
>> needed, instead of being set always and then masked off.
>>      
> This seems to be unrelated to the actual problem this patch is trying to
> solve.
>    

Yeah I can split it off in a two-series patch, no problem.

>>         writel(datactrl, base + MMCIDATACTRL);
>> -       writel(readl(base + MMCIMASK0)&  ~MCI_DATAENDMASK, base + MMCIMASK0);
>> -       mmci_set_mask1(host, irqmask);
>> +       irqmask0 = readl(base + MMCIMASK0);
>> +       if (variant->broken_blockend)
>> +               irqmask0&= ~MCI_DATABLOCKENDMASK;
>> +       else
>> +               irqmask0 |= MCI_DATABLOCKENDMASK;
>> +       irqmask0&= ~MCI_DATAENDMASK;
>> +       writel(irqmask0, base + MMCIMASK0);
>> +       mmci_set_mask1(host, irqmask1);
>>   }
>>      
> If your intention is to not have to mask MCI_DATABLOCKENDMASK off, why
> are you doing so?
>    

The intention is to turn it off for HW which we know is broken,
(has broken_blocken set true) which is what happens above.

If it is still broken, i.e. you get too few IRQs anyway, the driver
will now detect that and report the error, and attempt to cover
up for it, instead of hanging the system, which is what happens
otherwise (the driver hangs perpetually waiting for it's
last blockend IRQ).

Sort of thing I find helpful, but taste varies of course... Some
would call it over-cautious.

Russell can you indicate whether you want that to detect and
recover (as now) or detect and error or just hang?

Yours,
Linus Walleij
