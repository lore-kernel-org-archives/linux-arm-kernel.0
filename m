From: nm@ti.com (Nishanth Menon)
Date: Wed, 02 Mar 2011 23:18:19 +0530
Subject: [PATCH v2 10/18] omap3+: sr: call handler with interrupt disabled
In-Reply-To: <4D6E80B6.9090901@ru.mvista.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
	<1299063331-27968-11-git-send-email-nm@ti.com>
	<4D6E4866.6070107@ru.mvista.com> <4D6E80B6.9090901@ru.mvista.com>
Message-ID: <4D6E82E3.70206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote, on 03/02/2011 11:09 PM:
> I wrote:
>
>>> Request the handler irq such that there is no nesting for calls.
>>> the notifiers are not expected to be nested, further the interrupt
>>> events for status change should be handled prior to the next event
>>> else there is a risk of loosing events.
>
>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>> ---
>>> arch/arm/mach-omap2/smartreflex.c | 2 +-
>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>>> diff --git a/arch/arm/mach-omap2/smartreflex.c
>>> b/arch/arm/mach-omap2/smartreflex.c
>>> index 99e4c4f..a4e9f2d 100644
>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>> @@ -278,7 +278,7 @@ static int sr_late_init(struct omap_sr *sr_info)
>>> goto error;
>>> }
>>> ret = request_irq(sr_info->irq, sr_interrupt,
>>> - 0, name, (void *)sr_info);
>>> + IRQF_DISABLED, name, (void *)sr_info);
>
>> Isn't this flag a nop now?
>
> Indeed, it is, according to the comment in <linux/interrupt.h>. So what
> does this patch really achieve?

Carry over since I had implemented this driver originally on an ancient 
kernel and other than the showing off the obvious fact that I am not 
reading lwn.net enough, I dont think it achieved anything much :(

The original intent was as following: since bootloaders may have used 
the same h/w logic which could generate pending interrupt status, I 
wanted to explicitly flag that requesting the irq should also ensure the 
IRQ is in disabled status before I get a chance to clean things up.


-- 
Regards,
Nishanth Menon
