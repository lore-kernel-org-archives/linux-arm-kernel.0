From: minyard@acm.org (Corey Minyard)
Date: Tue, 28 Mar 2017 15:01:02 -0500
Subject: [PATCH] ACPI / IPMI: change warning to debug on timeout
In-Reply-To: <39c54677-1472-afff-ec70-45a790f56e50@codeaurora.org>
References: <1490283150-24000-1-git-send-email-okaya@codeaurora.org>
 <537c0d7a-fd95-2e7f-be07-9e3ca79ca07a@acm.org>
 <39c54677-1472-afff-ec70-45a790f56e50@codeaurora.org>
Message-ID: <67243d7f-0195-a214-b9d4-bdac48743893@acm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2017 09:08 AM, Sinan Kaya wrote:
> On 3/24/2017 10:55 PM, Corey Minyard wrote:
>> Why would a timeout for a message be expected?  The BMC should
>> at least respond with an error for an incorrect message.
> Let me add some more context...
>
> In this particular case, the FRU ID that I was trying to access was
> correct.
>
> Platform supports PCIe hotplug. The FRU is embedded into the HW that
> is being removed. That's what I mean by non-existent.
>
> When the device is ejected and a FRU command is executed, BMC times out
> reaching to the FRU on the device.
>
> When the device is inserted, everything works as expected.

I haven't added this yet.  Someone who knows more about the ACPI side of 
IPMI
should probably comment.  So I've added Lv Zheng.

This is ok with me, though.  If you remove a management controller, a 
timeout is
expected.  However, if the management controller is still present, a 
timeout is
probably not the best error code, "destination unavailable" is probably 
a better
choice.

So:

Acked-by: Corey Minyard <cminyard@mvista.com>

-corey

>
>> -corey
>>
>> On 03/23/2017 10:32 AM, Sinan Kaya wrote:
>>> Getting timeout message from BMC when trying to read from a non-existent
>>> FRU. This is expected but warning is not.
>>>
>>> Let's reduce the warning to debug.
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> ---
>>>    drivers/acpi/acpi_ipmi.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
>>> index 747c2ba..1b64419 100644
>>> --- a/drivers/acpi/acpi_ipmi.c
>>> +++ b/drivers/acpi/acpi_ipmi.c
>>> @@ -429,8 +429,7 @@ static void ipmi_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
>>>        if (msg->recv_type == IPMI_RESPONSE_RECV_TYPE &&
>>>            msg->msg.data_len == 1) {
>>>            if (msg->msg.data[0] == IPMI_TIMEOUT_COMPLETION_CODE) {
>>> -            dev_WARN_ONCE(dev, true,
>>> -                      "Unexpected response (timeout).\n");
>>> +            dev_dbg_once(dev, "Unexpected response (timeout).\n");
>>>                tx_msg->msg_done = ACPI_IPMI_TIMEOUT;
>>>            }
>>>            goto out_comp;
>>
>>
>
