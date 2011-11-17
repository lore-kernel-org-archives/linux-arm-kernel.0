From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 17 Nov 2011 15:12:26 +0530
Subject: [PATCH v16 09/12] OMAP: dmtimer: low-power mode support
In-Reply-To: <CAPTm=KHxSvyCb4i02vnuU9Wz-0j3h+h_UvDc0An5mwb2472dPg@mail.gmail.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
 <1316518227-28116-10-git-send-email-tarun.kanti@ti.com>
 <CAPTm=KGDEKGxLpJt0t6k_NL5Wz81NkMmRJ+OkmyvHedd6_exgQ@mail.gmail.com>
 <CAC83ZvJSev97waAOuzoJsFTX4vmeVFxkg6BzpjQm+Tjo3cbhpg@mail.gmail.com>
 <CAPTm=KHxSvyCb4i02vnuU9Wz-0j3h+h_UvDc0An5mwb2472dPg@mail.gmail.com>
Message-ID: <CAC83Zv+8+gh_bvtp90s+jiQNuxLcA=R2503V9swupnA1S91L_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 6:23 AM, Omar Ramirez Luna <or.rmz1@gmail.com> wrote:
> On Wed, Nov 16, 2011 at 12:18 AM, DebBarma, Tarun Kanti
> <tarun.kanti@ti.com> wrote:
> ...
>>> My use case is as follows:
>>>
>>> DSP sends a mailbox message to ARM, this triggers a tasklet in mailbox
>>> for processing the message, when it reaches tidspbridge it turns out
>>> that the DSP wants to enable a gpt timer; however, locks involved
>>> "clocks_mutex" and "dm_timer_lock" now could cause a deadlock as they
>>> have been called from unsafe contexts in the past
>>> (http://pastebin.com/7Dtz8t0f).
>>>
>>> Is the intention to restrict enabling the dmtimer clocks from hard|soft irqs?
>> The aim is to prevent client drivers perform clock enable/disable independently.
>> Instead just use the request/start/stop APIs. In that way we can make clock
>> enable/disable functions static in the future.
>
> Those are the APIs I'm using, omap_dm_timer_request_specific from a
> softirq triggers this warning, this was not hinted by the patch or
> cover letter of the series, hence the question:
>
> Was this change intentional? Does omap_dm_timer_request_specific
> should be allowed on other contexts (soft|hard irq)?
omap_dm_timer_request_specific() uses spin_lock_irqsave and
spin_unlock_irqrestore
to protect the timer list. There is nothing specific to prevent this
function from being
called from interrupt context. But you probably have to be careful to
avoid deadlock
in the interrupt context by disabling interrupts appropriately so that
we avoid trying
to re-acquire the lock. If you send me the code snippet I can have a look.
--
Tarun
>
> ...
>> You are right. This change some how got missed in mainline.
>> I have posted a patch for this already.
>
> Ok.
>
> Regards,
>
> Omar
>
