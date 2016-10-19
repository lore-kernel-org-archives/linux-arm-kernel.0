From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 19 Oct 2016 11:37:23 +0100
Subject: [PATCH v4 2/8] scpi: Add alternative legacy structures, functions
 and macros
In-Reply-To: <24e6ef19-b88d-a5b8-f514-d39a7b5725e8@baylibre.com>
References: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
 <1475652814-30619-3-git-send-email-narmstrong@baylibre.com>
 <7bf3b68c-19aa-85c3-8b20-66b7380eaf3f@arm.com>
 <ecdedaf0-a4a4-9881-1068-9f186f7ac6af@baylibre.com>
 <e3f774ee-5268-3668-e7f8-0ae3bbceba6c@arm.com>
 <24e6ef19-b88d-a5b8-f514-d39a7b5725e8@baylibre.com>
Message-ID: <d243c5f3-91b3-46ee-c456-49d3c9886742@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/10/16 11:28, Neil Armstrong wrote:
> On 10/17/2016 01:16 PM, Sudeep Holla wrote:

[...]

>>
>> and the above 2 can be moved out of the conditions, no ?
>>
>> if (scpi_info->is_legacy) {
>>     struct legacy_scpi_shared_mem *mem = ch->rx_payload;
>>     len = match->rx_len;
>> } else {
>>     struct scpi_shared_mem *mem = ch->rx_payload;
>>     len = min(match->rx_len, CMD_SIZE(cmd));
>> }
>> match->status = le32_to_cpu(mem->status);
>> memcpy_fromio(match->rx_buf, mem->payload, len);
>>
>> should work.
>
> Well, we will have "error: ?mem? undeclared (first use in this
> function)" since mem is not declared outside the if/else.
>
> I don't see good solutions even with an union.

Right, I missed to see that. You can leave it as you had before then.


[...]
>>>>>      if (t->rx_buf) {
>>>>>          if (!(++ch->token))
>>>>>              ++ch->token;
>>>>>          ADD_SCPI_TOKEN(t->cmd, ch->token);
>>>>> +        if (scpi_info->is_legacy)
>>>>> +            t->slot = t->cmd;
>>>>
>>>> I thought passing token was not an issue from your previous response,
>>>> but you are overriding it here, why ?
>>>
>>> Indeed, I can leave it, but it's useless since it won't serve to
>>> distinguish multiple similar commands.
>>>
>>
>> OK, I don't see any point in such micro optimization, so please retain it.
>>
>
> I misread my code, I leaved the token passing, but I copy back the
> cmd  to the slot which is used by the MHU.
> If I remove the "t->slot = t->cmd;", the token won't be passed to the
> FW.
>

Right, sorry I think I misled you :)

-- 
Regards,
Sudeep
