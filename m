From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 13:18:27 +0200
Subject: [PATCH v7 2/4] power: reset: add reboot mode driver
In-Reply-To: <570CBF7F.9090300@rock-chips.com>
References: <1459304304-9713-1-git-send-email-andy.yan@rock-chips.com>
 <1459304443-9811-1-git-send-email-andy.yan@rock-chips.com>
 <56FB49B3.2040505@samsung.com> <57045D6B.2080907@rock-chips.com>
 <57045F9D.1000502@samsung.com> <570CBF7F.9090300@rock-chips.com>
Message-ID: <570CD983.9090202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2016 11:27 AM, Andy Yan wrote:
>>>>> +
>>>>> +static const struct of_device_id syscon_reboot_mode_of_match[] = {
>>>>> +    { .compatible = "syscon-reboot-mode" },
>>>>> +    {}
>>>>> +};
>>>>> +
>>>>> +static struct platform_driver syscon_reboot_mode_driver = {
>>>>> +    .probe = syscon_reboot_mode_probe,
>>>> Cleanup needed. What will happen after device unbind? Memory will be
>>>> released (devm-*()) but reboot notifier won't thus leading to OOPS on
>>>> reboot.
>>>      From the kernel_restart_prepare function, the reboot notifier will
>>> be called before device_shutdown. Is there any other case the device
>>> unbind before reboot notifier
>>> called?
>> This is a regular module platform driver so unbind can happen any time
>> initiated by user, either by unbind command or by module removal. User
>> can then re-bind device or not - probably does not matter. Anyway after
>> such first unbind, the restart will kaboom instead of do a restart.
> 
>     I just need to do clean up in remove?

Yes, you need to clean up everything in remove() callback (in a reversed
order).

Best regards,
Krzysztof
