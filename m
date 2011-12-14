From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 14 Dec 2011 14:26:11 -0700
Subject: [PATCH 3/9] irq: convert generic-chip to use irq_domain
In-Reply-To: <4EE913C7.1060901@gmail.com>
References: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
 <1323876538-20406-4-git-send-email-robherring2@gmail.com>
 <CACxGe6sqTx4h3vPgq+XrAoqLTiDMB-vcS5C9GgYssdsSYV_0qA@mail.gmail.com>
 <4EE913C7.1060901@gmail.com>
Message-ID: <CACxGe6uTp_=G4ODqzJdOTou2gzAM9LX8xHtKkeL8Safq0+B2rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 2:23 PM, Rob Herring <robherring2@gmail.com> wrote:
>
>
> On 12/14/2011 03:14 PM, Grant Likely wrote:
>> On Wed, Dec 14, 2011 at 8:28 AM, Rob Herring <robherring2@gmail.com> wrote:
>>> From: Rob Herring <rob.herring@calxeda.com>
>>>
>>> Add irq domain support to irq generic-chip. This enables users of
>>> generic-chip to support dynamic irq assignment needed for DT interrupt
>>> binding. Users must be converted to use irq_data.hwirq for determining
>>> local interrupt numbers rather than using the Linux irq number.
>>>
>>> irq_base is kept for now as there are a few users of it. Once they
>>> are converted to use the irq domain, it can be removed.
>>>
>>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> ---
>>> ?include/linux/irq.h ? ? ? | ? ?2 +-
>>> ?kernel/irq/Kconfig ? ? ? ?| ? ?1 +
>>> ?kernel/irq/generic-chip.c | ? 57 ++++++++++++++++++++++++++++----------------
>>> ?3 files changed, 38 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/include/linux/irq.h b/include/linux/irq.h
>>> index bff29c5..9ba8a30 100644
>>> --- a/include/linux/irq.h
>>> +++ b/include/linux/irq.h
>>> @@ -664,7 +664,7 @@ struct irq_chip_generic {
>>> ? ? ? ?raw_spinlock_t ? ? ? ? ?lock;
>>> ? ? ? ?void __iomem ? ? ? ? ? ?*reg_base;
>>> ? ? ? ?unsigned int ? ? ? ? ? ?irq_base;
>>> - ? ? ? unsigned int ? ? ? ? ? ?irq_cnt;
>>> + ? ? ? struct irq_domain ? ? ? *domain;
>>
>> Instead of making domain a pointer, why not embed the structure inside
>> irq_chip_generic? ?I don't see a reason for keeping it separate.
>>
>
> There is a circular header dependency between irq.h and irq_domain.h.
> Maybe I just need to put the include of irq_domain.h just above here
> rather than the top of the file.

Yes, try that.  I'd rather get the dependency problem sorted out.
Alternately, problematic bit of irq_domain.h can be moved to another
header.

g.
