From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 23 Nov 2011 18:03:09 +0530
Subject: [PATCH] ARM: OMAP: dmtimer: fix missing content/correction in
 low-power mode support
In-Reply-To: <CAB-zwWiNc=aFMd2ccyL=s1c5qa8dnu6c-M29K1CrezJ01YXZWg@mail.gmail.com>
References: <1320732026-6783-1-git-send-email-tarun.kanti@ti.com>
 <CAB-zwWiNc=aFMd2ccyL=s1c5qa8dnu6c-M29K1CrezJ01YXZWg@mail.gmail.com>
Message-ID: <CAC83ZvK7-jfXm0YZo45pcd7D4_Ad858u1WJY1ozfy+z31Zk5Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 10:12 PM, Ramirez Luna, Omar
<omar.ramirez@ti.com> wrote:
> Hi,
>
> On Tue, Nov 8, 2011 at 12:00 AM, Tarun Kanti DebBarma
> <tarun.kanti@ti.com> wrote:
>> Since omap_dm_timer_write_reg/__omap_dm_timer_write is now modified
>> to use timer->func_base OCP_CFG should not use this wrapper anymore.
>> Instead use __raw_writel() directly and use timer->io_base instead
>> to write to OCP_CFG.
>>
>> The timer->sys_stat is valid only if timer->revision is 1. In the
>> context restore function make this correction.
>>
>> Save the contexts and loss count when timer is stopped.
>> Also, disable the clock. Else, clock usecount would become imbalanced.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ...
>> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
>> index af3b92b..f042c82 100644
>> --- a/arch/arm/plat-omap/dmtimer.c
>> +++ b/arch/arm/plat-omap/dmtimer.c
> ...
>> @@ -357,6 +357,21 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
>>
>> ? ? ? ?__omap_dm_timer_stop(timer, timer->posted, rate);
>>
>> + ? ? ? if (timer->loses_context) {
>> + ? ? ? ? ? ? ? if (timer->get_context_loss_count)
>
> Maybe: if (timer->loses_context && timer->get_context_loss_count)
Sure.
>
>> + ? ? ? ? ? ? ? ? ? ? ? timer->ctx_loss_count =
>> + ? ? ? ? ? ? ? ? ? ? ? timer->get_context_loss_count(&timer->pdev->dev);
>
> could get rid ?of this weird one-line formatting
ok.
>
>> + ? ? ? }
>> +
>> + ? ? ? /*
>> + ? ? ? ?* Since the register values are computed and written within
>> + ? ? ? ?* __omap_dm_timer_stop, we need to use read to retrieve the
>> + ? ? ? ?* context.
>> + ? ? ? ?*/
>> + ? ? ? timer->context.tclr =
>> + ? ? ? ? ? ? ? ? ? ? ? omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
>> + ? ? ? timer->context.tisr = __raw_readl(timer->irq_stat);
>> + ? ? ? omap_dm_timer_disable(timer);
>
> FWIW, functionally it looks good to me, besides it fixes the broken
> dmtimer start/stop sequence from 3.2-rc1. Tested with tidspbridge on
> omap3.
Thanks.

>
> If needed:
>
> Tested-by: Omar Ramirez Luna <omar.ramirez@ti.com>
Sure. Thanks.
--
Tarun
>
> Regards,
>
> Omar
>
