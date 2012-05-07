From: jgutierrez@ti.com (Gutierrez, Juan)
Date: Mon, 7 May 2012 17:09:16 -0500
Subject: [PATCH v2 1/3] omap: mailbox: enable mailbox irq per instance
In-Reply-To: <CAK=WgbY3OaDH9ziavrXG4oM1ztO3mTmL_eoLPOzCHHKQpHn20w@mail.gmail.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
 <1334360392-1494-2-git-send-email-jgutierrez@ti.com>
 <CAK=WgbY3OaDH9ziavrXG4oM1ztO3mTmL_eoLPOzCHHKQpHn20w@mail.gmail.com>
Message-ID: <CADVn9RHc4b+hLth5j-1Jr+dv2ePB8W1pGAgQiBSgFKuDycG8pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad

On Sun, May 6, 2012 at 11:00 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Juan,
>
> On Sat, Apr 14, 2012 at 2:39 AM, Juan Gutierrez <jgutierrez@ti.com> wrote:
>> The machine-specific omap2_mbox_startup is called only once
>> to initialize the whole mbox module. Enabling mbox irq at
>> startup is only enabling the irq of the very first mailbox
>> instance created.
>>
>> The enable_irq function should be called every time a
>> new mbox instance is created,
>
> s/created/opened/
>
>> in the generic platform mailbox layer.
>
> This patch removes an omap2-specific code and then adds it to the
> "generic" layer, which also deals with omap1.
>
> Are we sure it's ok ?
>
> OMAP1 doesn't seem to enable its irq at this point: it doesn't even
> have a ->startup() handler (which actually somewhat implies it's been
> anyway broken for a long time now: omap_mbox_startup() seem to
> unhappily bail out if it doesn't find a machine-specific ->startup()
> handler).
>

In the ISR the mbox queue are used. If they are not ready a crash might happen.
So enabling_irq should be called after mbox queue allocation and after
ISR registration.
So I think for sure startup is not the right place. Besides that, its
reference counter is
preventing other mbox instances to enable irq's.

Startup it is now only used to enable pm runtime of the whole mbox module.

I think, if request_irq is called from the generic layer, it is kind
of logical to enable_irq
next to it.


>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
>> index ad32621..ebc1ba5 100644
>> --- a/arch/arm/plat-omap/mailbox.c
>> +++ b/arch/arm/plat-omap/mailbox.c
>> @@ -282,6 +282,8 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
>> ? ? ? ? ? ? ? ?}
>> ? ? ? ? ? ? ? ?mbox->rxq = mq;
>> ? ? ? ? ? ? ? ?mq->mbox = mbox;
>> +
>> + ? ? ? ? ? ? ? mbox->ops->enable_irq(mbox, IRQ_RX);
>
> Might be nicer to use omap_mbox_enable_irq() here instead of reaching
> out for the internal ops.
>
Ok, yes I will use omap_mbox_enable_irq

> It also looks like there's a race here: omap_mbox_get() registers the
> notifier_block only after omap_mbox_startup() returns, which probably
> means there's a small window where an interrupt can be received
> without us invoking the user's notifier callback.
>
> This isn't related to your patch of course, but since you're touching
> this area, it might be nice if you can fix it (i.e. simply by
> registering the notifier_block before enabling the mbox's irq).
>
Ok I can include this fix.

>> ? ? ? ?}
>> ? ? ? ?mutex_unlock(&mbox_configured_lock);
>> ? ? ? ?return 0;
>> @@ -305,6 +307,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
>> ? ? ? ?mutex_lock(&mbox_configured_lock);
>>
>> ? ? ? ?if (!--mbox->use_count) {
>> + ? ? ? ? ? ? ? mbox->ops->disable_irq(mbox, IRQ_RX);
>
> omap_mbox_disable_irq() ?
>
Ok

> Thanks,
> Ohad.



-- 
Thanks

juan gutierrez
