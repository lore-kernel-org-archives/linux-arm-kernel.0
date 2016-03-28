From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 28 Mar 2016 17:05:24 +0900
Subject: [PATCH v6 2/4] power: reset: add reboot mode driver
In-Reply-To: <56F8DFED.50905@rock-chips.com>
References: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
 <1458646642-591-1-git-send-email-andy.yan@rock-chips.com>
 <CAJKOXPcKzGTAicbsXK-cC9WQT0vBhpSG_q2GCn37+72x2hdhsQ@mail.gmail.com>
 <56F39F36.5050702@rock-chips.com> <56F8D078.6040503@samsung.com>
 <56F8DFED.50905@rock-chips.com>
Message-ID: <56F8E5C4.5010000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.03.2016 16:40, Andy Yan wrote:
> Hi Krzysztof :
> 
> On 2016?03?28? 14:34, Krzysztof Kozlowski wrote:
>> On 24.03.2016 17:03, Andy Yan wrote:
>>> Hi Krzystof:
>> (...)
>>
>>>>> +static int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>>>>> +                                const char *cmd)
>>>>> +{
>>>>> +       const char *normal = "normal";
>>>>> +       int magic = 0;
>>>>> +       struct mode_info *info;
>>>>> +
>>>>> +       if (!cmd)
>>>>> +               cmd = normal;
>>>>> +
>>>>> +       list_for_each_entry(info, &reboot->head, list) {
>>>>> +               if (!strcmp(info->mode, cmd)) {
>>>>> +                       magic = info->magic;
>>>>> +                       break;
>>>>> +               }
>>>>> +       }
>>>>> +
>>>>> +       return magic;
>>>> In absence of 'normal' mode (it is not described as required property)
>>>> the magic will be '0'. It would be nice to document that in bindings.
>>>> Imagine someone forgets about this and will wonder why 0x0 is written
>>>> to his precious register on normal reboot...
>>>      If the magic value is '0', we won't touch the register, please see
>>> reboot_mode_notify bellow.
>> Ah, indeed... so we cannot use value of '0' for magic (e.g. to clear any
>> existing value for normal reboot)?
> 
>     It seems that the value '0' cannot be used.

How about mentioning it in bindings documentation?

(...)

>>>>> +               strcpy(info->mode, prop->name + len);
>>>> Ehm, and how do you protect that name of mode is shorter than 32
>>>> characters?
>>>      How about info->mode = prop->name + len ?
>> I don't get your answer.
>> As fair as I read the code, the prop->name can be very long and you are
>> copying it from 5 character. If the name of the mode has bazillion
>> characters then again my question: how do you protect that it will fit
>> in 32 bytes of 'mode'?
> 
>     What I mean is set info->mode as a pointer point to prop->name + len
> 
>    struct mode_info {
>             char *mode;
>             ..........
>             .........
>    }
> 
>    info->mode = prop->name + len

Ahh, I get it. Then I guess you should also do of_node_get() and
of_node_put()... and use kstrdup_const(). Looks good but I am not
familiar with overlays and life-cycle of OF nodes (documentation for the
life-cycle is a todo list item: Documentation/devicetree/todo.txt).

Best regards,
Krzysztof
