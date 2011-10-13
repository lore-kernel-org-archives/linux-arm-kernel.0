From: govindraj.ti@gmail.com (Govindraj)
Date: Thu, 13 Oct 2011 06:58:48 +0530
Subject: [PATCH v6 09/16] OMAP2+: UART: Add runtime pm support for
	omap-serial driver
In-Reply-To: <878voplppo.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-9-git-send-email-govindraj.raja@ti.com>
	<878voplppo.fsf@ti.com>
Message-ID: <CAAL8m4yrXo4KRYxXxWECU99B6--FCMBDFUbNk+vsBV0Jnt0bcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 5:36 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
> [...]
>
>> Use device_may_wakeup to check whether uart has wakeup capabilities
>> and then enable uart runtime usage for the uart.
>
> Curious about what happens when device_may_wakeup() is not set during
> device init.
>
> [...]
>
>> @@ -1305,6 +1363,16 @@ static int serial_omap_probe(struct platform_device *pdev)
>> ? ? ? ? ? ? ? up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
>> ? ? ? }
>>
>> + ? ? pm_runtime_use_autosuspend(&pdev->dev);
>> + ? ? pm_runtime_set_autosuspend_delay(&pdev->dev,
>> + ? ? ? ? ? ? ? ? ? ? OMAP_UART_AUTOSUSPEND_DELAY);
>> +
>> + ? ? pm_runtime_irq_safe(&pdev->dev);
>> + ? ? if (device_may_wakeup(&pdev->dev)) {
>> + ? ? ? ? ? ? pm_runtime_enable(&pdev->dev);
>
> So if device_may_wakeup() is false, runtime PM is not enabled, then...
>
>> + ? ? ? ? ? ? pm_runtime_get_sync(&pdev->dev);
>
> ...this get doesn't happen, and the first register access causes a crash.

Actually no crash, clocks will left enabled from boot up (hwmod_no_reset/idle)
that are idled and enabled back here.

Since hwmod_idle is binded here later ([PATCH v6 15/16]),

>
> So either this get isn't needed, because there is no device access in
> this path, or this path is broken and needs validation.
>
>> + ? ? }
>> +
>> ? ? ? ui[pdev->id] = up;
>> ? ? ? serial_omap_add_console_port(up);
>>
>> @@ -1312,6 +1380,7 @@ static int serial_omap_probe(struct platform_device *pdev)
>> ? ? ? if (ret != 0)
>> ? ? ? ? ? ? ? goto do_release_region;
>>
>> + ? ? pm_runtime_put(&pdev->dev);
>
> ...also, this put is not balanced with a corresponding get.

this needs to happen only when runtime is enabled.

will correct this.

--
Thanks,
Govindraj.,R
