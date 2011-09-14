From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 14 Sep 2011 10:28:06 +0530
Subject: [PATCH v15 11/12] OMAP: dmtimer: extend spinlock to exported APIs
In-Reply-To: <20110913231540.GI24252@atomide.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
	<1315516098-29761-12-git-send-email-tarun.kanti@ti.com>
	<20110913231540.GI24252@atomide.com>
Message-ID: <CAC83ZvK0rknVX3bw42dL-V2Dpq5wjwhU6H=fNjR1=oZCs+rkng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 4:45 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110908 13:36]:
>> Since the exported APIs can be called from interrupt context
>> extend spinlock protection to some more relevant APIs to avoid
>> race condition.
>
> We should have locking for requesting and releasing a timer etc,
> but I don't see need for that for the timer specific functions.
Alright... I will remove locking from timer specific functions.
In that case we have extension of locks to just following two functions:
omap_dm_timer_request()
omap_dm_timer_request_specific()

So, I can modify the patch subject and description accordingly.

>
>> @@ -317,9 +317,11 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
>> ?void omap_dm_timer_start(struct omap_dm_timer *timer)
>> ?{
>> ? ? ? u32 l;
>> + ? ? unsigned long flags;
>>
>> ? ? ? omap_dm_timer_enable(timer);
>>
>> + ? ? spin_lock_irqsave(&dm_timer_lock, flags);
>> ? ? ? if (timer->loses_context) {
>> ? ? ? ? ? ? ? u32 ctx_loss_cnt_after =
>> ? ? ? ? ? ? ? ? ? ? ? timer->get_context_loss_count(&timer->pdev->dev);
>
> Here the caller already owns the timer being started. So there
> should never be multiple users for a single timer. If there are,
> then the caller should take care of locking.
Ok.

>
>> ?void omap_dm_timer_stop(struct omap_dm_timer *timer)
>> ?{
>> - ? ? unsigned long rate = 0;
>> + ? ? unsigned long rate = 0, flags;
>> ? ? ? struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
>> ? ? ? bool is_omap2 = true;
>>
>> + ? ? spin_lock_irqsave(&dm_timer_lock, flags);
>> ? ? ? if (pdata->needs_manual_reset)
>> ? ? ? ? ? ? ? is_omap2 = false;
>> ? ? ? else
>
> Here too.
Right.

>
>> @@ -389,8 +394,10 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int load)
>> ?{
>> ? ? ? u32 l;
>> + ? ? unsigned long flags;
>>
>> ? ? ? omap_dm_timer_enable(timer);
>> + ? ? spin_lock_irqsave(&dm_timer_lock, flags);
>> ? ? ? l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
>> ? ? ? if (autoreload)
>> ? ? ? ? ? ? ? l |= OMAP_TIMER_CTRL_AR;
>
> And here.
Ok.

>
>> @@ -412,9 +420,11 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned int load)
>> ?{
>> ? ? ? u32 l;
>> + ? ? unsigned long flags;
>>
>> ? ? ? omap_dm_timer_enable(timer);
>>
>> + ? ? spin_lock_irqsave(&dm_timer_lock, flags);
>> ? ? ? if (timer->loses_context) {
>> ? ? ? ? ? ? ? u32 ctx_loss_cnt_after =
>> ? ? ? ? ? ? ? ? ? ? ? timer->get_context_loss_count(&timer->pdev->dev);
>
> Not needed here either. And that's the case for all the other functions
> too.
Sure.
--
Tarun
>
> Regards,
>
> Tony
>
