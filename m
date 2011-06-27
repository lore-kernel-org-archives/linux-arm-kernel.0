From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Jun 2011 15:28:57 -0700
Subject: [PATCH v3 11/12] OMAP2: Serial: Add has_async_wake flag.
In-Reply-To: <BANLkTik9ZLyA4+1VMFj08Zke151OqAhATQ@mail.gmail.com> (Govindraj's
	message of "Mon, 27 Jun 2011 18:39:54 +0530")
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-12-git-send-email-govindraj.raja@ti.com>
	<87y60qpxcq.fsf@ti.com>
	<BANLkTik9ZLyA4+1VMFj08Zke151OqAhATQ@mail.gmail.com>
Message-ID: <877h86aoye.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Sat, Jun 25, 2011 at 5:59 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> Prior to this patch the uart_clock was cut using prepare/resume calls since
>>> these funcs are no more available with runtime changes use has_async_wake
>>> flag to keep clock active during bootup otherwise uart port will disabled
>>> during boot-up and cannot be enabled back.
>>
>> Is this only a bootup issue, or a runtime PM issue? ?It appears to me
>> that with this patch, runtime PM is effectively disabled for the whole
>> time.
>>
>
> it boots up fine, its a runtime PM issue where there is
> no mechanism to wakeup after clock cutting from
> runtime autosuspend.
>
>
>> Why not just use pm_runtime_disable() in _probe() for devices with no
>> async wakeup.
>>
>
> Agree.
> can drop of this patch and bind below changes in runtime conversion patch  04/12
>
> do pm_runtime_enable only if device_may_wakeup
> is true in probe.
>
> <<SNIP>>
> in serial_omap_probe
>
> if (device_may_wakeup(&pdev->dev)) {
> 	pm_runtime_use_autosuspend(&pdev->dev);
> 	pm_runtime_set_autosuspend_delay(&pdev->dev,
> 				OMAP_UART_AUTOSUSPEND_DELAY);
> 	pm_runtime_enable(&pdev->dev);
> 	pm_runtime_irq_safe(&pdev->dev);
> }

Well, I think only the _enable() should be conditional.

>>> Also based on this flag we can disable uart port during suspend and
>>> enable back during resume for omap_socs that have not set
>>> has_async_wake.
>>
>> Then you can use pm_runtime_enable() in ->prepare() and
>> pm_runtime_disable() in ->complete()
>>
>
> u mean runtime enable in suspend and runtime disable in resume
> if device_may_wakeup is false.

No, I meant the .prepare (runs before .suspend) and .complete (runs
after .resume) callbacks.  

Kevin
