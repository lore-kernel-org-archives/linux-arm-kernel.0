From: andy.yan@rock-chips.com (Andy Yan)
Date: Tue, 12 Apr 2016 17:27:27 +0800
Subject: [PATCH v7 2/4] power: reset: add reboot mode driver
In-Reply-To: <57045F9D.1000502@samsung.com>
References: <1459304304-9713-1-git-send-email-andy.yan@rock-chips.com>
 <1459304443-9811-1-git-send-email-andy.yan@rock-chips.com>
 <56FB49B3.2040505@samsung.com> <57045D6B.2080907@rock-chips.com>
 <57045F9D.1000502@samsung.com>
Message-ID: <570CBF7F.9090300@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof:

On 2016?04?06? 09:00, Krzysztof Kozlowski wrote:
> On 06.04.2016 09:50, Andy Yan wrote:
>
> (...)
>
>>>> +            return -ENOMEM;
>>>> +
>>>> +        info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
>>>> +        if (of_property_read_u32(np, prop->name, &info->magic)) {
>>>> +            dev_err(dev, "reboot mode %s without magic number\n",
>>>> +                info->mode);
>>>> +            devm_kfree(dev, info);
>>>> +            continue;
>>>> +        }
>>>> +        list_add_tail(&info->list, &reboot->head);
>>>> +    }
>>>> +    of_node_put(np);
>>> If you of_node_put() here, there is no sense in getting it before. I
>>> mentioned of_node_get() only because I am not sure about life-cycle of
>>> nodes in case of DT overlays and you are storing the pointer to string
>>> from DT.
>>>
>>> The doubts I have are concerning only the case of freeing nodes from
>>> overlay.
>>>
>>> I don't know if of_node_get() is needed but of_node_get()+of_node_put()
>>> seems useless.
>>
>>   I am also not sure about it. Maybe just drop of_node_get/put ?
> OK, let's drop both get() and put().
>
> (...)
>
>>>> +
>>>> +static const struct of_device_id syscon_reboot_mode_of_match[] = {
>>>> +    { .compatible = "syscon-reboot-mode" },
>>>> +    {}
>>>> +};
>>>> +
>>>> +static struct platform_driver syscon_reboot_mode_driver = {
>>>> +    .probe = syscon_reboot_mode_probe,
>>> Cleanup needed. What will happen after device unbind? Memory will be
>>> released (devm-*()) but reboot notifier won't thus leading to OOPS on
>>> reboot.
>>      From the kernel_restart_prepare function, the reboot notifier will
>> be called before device_shutdown. Is there any other case the device
>> unbind before reboot notifier
>> called?
> This is a regular module platform driver so unbind can happen any time
> initiated by user, either by unbind command or by module removal. User
> can then re-bind device or not - probably does not matter. Anyway after
> such first unbind, the restart will kaboom instead of do a restart.

     I just need to do clean up in remove?
> Beside that, you always should clean up, regardless of restart or not.
> If you do not want unbind (thus no need of cleanup) then forbid it by
> making it a non-module with suppressed bind.
>
> Best regards,
> Krzysztof
>
>
>
>
