From: govindraj.ti@gmail.com (Govindraj)
Date: Fri, 14 Oct 2011 18:02:19 +0530
Subject: [PATCH v6 09/16] OMAP2+: UART: Add runtime pm support for
	omap-serial driver
In-Reply-To: <87obxkio3e.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-9-git-send-email-govindraj.raja@ti.com>
	<878voplppo.fsf@ti.com>
	<CAAL8m4yrXo4KRYxXxWECU99B6--FCMBDFUbNk+vsBV0Jnt0bcg@mail.gmail.com>
	<87obxkio3e.fsf@ti.com>
Message-ID: <CAAL8m4zbdA9rtwLhft8UGQTtvroNbYYoBoq4BG2Eu2nCToX5+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 2:52 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Thu, Oct 13, 2011 at 5:36 AM, Kevin Hilman <khilman@ti.com> wrote:
>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>
>>> [...]
>>>
>>>> Use device_may_wakeup to check whether uart has wakeup capabilities
>>>> and then enable uart runtime usage for the uart.
>>>
>>> Curious about what happens when device_may_wakeup() is not set during
>>> device init.
>>>
>>> [...]
>>>
>>>> @@ -1305,6 +1363,16 @@ static int serial_omap_probe(struct platform_device *pdev)
>>>> ? ? ? ? ? ? ? up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
>>>> ? ? ? }
>>>>
>>>> + ? ? pm_runtime_use_autosuspend(&pdev->dev);
>>>> + ? ? pm_runtime_set_autosuspend_delay(&pdev->dev,
>>>> + ? ? ? ? ? ? ? ? ? ? OMAP_UART_AUTOSUSPEND_DELAY);
>>>> +
>>>> + ? ? pm_runtime_irq_safe(&pdev->dev);
>>>> + ? ? if (device_may_wakeup(&pdev->dev)) {
>>>> + ? ? ? ? ? ? pm_runtime_enable(&pdev->dev);
>>>
>>> So if device_may_wakeup() is false, runtime PM is not enabled, then...
>>>
>>>> + ? ? ? ? ? ? pm_runtime_get_sync(&pdev->dev);
>>>
>>> ...this get doesn't happen, and the first register access causes a crash.
>>
>> Actually no crash, clocks will left enabled from boot up (hwmod_no_reset/idle)
>> that are idled and enabled back here.
>>
>> Since hwmod_idle is binded here later ([PATCH v6 15/16]),
>
> IMO, That's not a very maintainable solution.
>
> What happens when when someone fixes serial.c to only set
> HWMOD_INIT_NO_IDLE on the console UART? ?or if we fix things so we don't
> need INIT_NO_IDLE anymore? ?Then this will crash.
>
> Driver code should not make assumptions like this about what device init
> code is or isn't doing.
>

Okay, How about doing as below ensuring get_sync always
and forbid runtime to avoid clock_gating if wakeup is not set.

static int serial_omap_probe(struct platform_device *pdev) {
[..]
        pm_runtime_enable(&pdev->dev);
        pm_runtime_get_sync(&pdev->dev);

        if (!device_may_wakeup(&pdev->dev))
                pm_runtime_forbid(&pdev->dev);

[..]

        pm_runtime_put(&pdev->dev);
[..]
}


--
Thanks,
Govindraj.R
