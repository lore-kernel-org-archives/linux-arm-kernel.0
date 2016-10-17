From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 17 Oct 2016 12:16:23 +0100
Subject: [PATCH v4 2/8] scpi: Add alternative legacy structures, functions
 and macros
In-Reply-To: <ecdedaf0-a4a4-9881-1068-9f186f7ac6af@baylibre.com>
References: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
 <1475652814-30619-3-git-send-email-narmstrong@baylibre.com>
 <7bf3b68c-19aa-85c3-8b20-66b7380eaf3f@arm.com>
 <ecdedaf0-a4a4-9881-1068-9f186f7ac6af@baylibre.com>
Message-ID: <e3f774ee-5268-3668-e7f8-0ae3bbceba6c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/10/16 09:25, Neil Armstrong wrote:
> On 10/10/2016 04:36 PM, Sudeep Holla wrote:
>> Hi Neil,
>>
>> Sorry, I could not reply to your response on v3. Anyways I will review v4.
>>
>> On 05/10/16 08:33, Neil Armstrong wrote:
>>> This patch adds support for the Legacy SCPI protocol in early JUNO versions and
>>> shipped Amlogic ARMv8 based SoCs. Some Rockchip SoC are also known to use this
>>> version of protocol with extended vendor commands
>>> .
>>> In order to support the legacy SCPI protocol variant, add back the structures
>>> and macros that varies against the final specification.
>>> Then add indirection table for legacy commands.
>>> Finally Add bitmap field for channel selection since the Legacy protocol mandates to
>>> send a selected subset of the commands on the high priority channel instead of the
>>> low priority channel.
>>>
>>> The message sending path differs from the final SCPI procotocol because the
>>> Amlogic SCP firmware always reply 1 instead of a special value containing the command
>>> byte and replied rx data length.
>>> For this reason commands queuing cannot be used and we assume the reply command is
>>> the head of the rx_pending list since we ensure sequential command sending with a
>>> separate dedicated mutex.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  drivers/firmware/arm_scpi.c | 221 +++++++++++++++++++++++++++++++++++++++-----
>>>  1 file changed, 199 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
>>> index 498afa0..6244eb1 100644
>>> --- a/drivers/firmware/arm_scpi.c
>>> +++ b/drivers/firmware/arm_scpi.c
>>
>> [...]
>>
>>> @@ -307,21 +398,46 @@ static void scpi_process_cmd(struct scpi_chan *ch, u32 cmd)
>>>          return;
>>>      }
>>>
>>> -    list_for_each_entry(t, &ch->rx_pending, node)
>>> -        if (CMD_XTRACT_UNIQ(t->cmd) == CMD_XTRACT_UNIQ(cmd)) {
>>> -            list_del(&t->node);
>>> -            match = t;
>>> -            break;
>>> -        }
>>> +    /* Command type is not replied by the SCP Firmware in legacy Mode
>>> +     * We should consider that command is the head of pending RX commands
>>> +     * if the list is not empty. In TX only mode, the list would be empty.
>>> +     */
>>> +    if (scpi_info->is_legacy) {
>>> +        match = list_first_entry(&ch->rx_pending, struct scpi_xfer,
>>> +                     node);
>>> +        list_del(&match->node);
>>> +    } else {
>>> +        list_for_each_entry(t, &ch->rx_pending, node)
>>> +            if (CMD_XTRACT_UNIQ(t->cmd) == CMD_XTRACT_UNIQ(cmd)) {
>>> +                list_del(&t->node);
>>> +                match = t;
>>> +                break;
>>> +            }
>>> +    }
>>>      /* check if wait_for_completion is in progress or timed-out */
>>>      if (match && !completion_done(&match->done)) {
>>> -        struct scpi_shared_mem *mem = ch->rx_payload;
>>> -        unsigned int len = min(match->rx_len, CMD_SIZE(cmd));
>>> +        unsigned int len;
>>> +
>>> +        if (scpi_info->is_legacy) {
>>> +            struct legacy_scpi_shared_mem *mem = ch->rx_payload;
>>> +
>>> +            /* RX Length is not replied by the lagcy Firmware */

Typo above legacy

>>> +            len = match->rx_len;
>>> +
>>> +            match->status = le32_to_cpu(mem->status);
>>> +            memcpy_fromio(match->rx_buf, mem->payload, len);
>>
>> The above 2 seems common to both, no ?
>
> No, the shared_mem structure differs.
>

Yes I see that, I was just referring the last 2 statements.

>>
>>> +        } else {
>>> +            struct scpi_shared_mem *mem = ch->rx_payload;
>>> +
>>> +            len = min(match->rx_len, CMD_SIZE(cmd));
>>> +
>>> +            match->status = le32_to_cpu(mem->status);
>>> +            memcpy_fromio(match->rx_buf, mem->payload, len);

and the above 2 can be moved out of the conditions, no ?

if (scpi_info->is_legacy) {
	struct legacy_scpi_shared_mem *mem = ch->rx_payload;
	len = match->rx_len;
} else {
	struct scpi_shared_mem *mem = ch->rx_payload;
	len = min(match->rx_len, CMD_SIZE(cmd));
}
match->status = le32_to_cpu(mem->status);
memcpy_fromio(match->rx_buf, mem->payload, len);

should work.


[...]

>>
>>> +    else
>>> +        cmd = le32_to_cpu(mem->command);
>>>
>>>      scpi_process_cmd(ch, cmd);
>>>  }
>>> @@ -343,17 +464,26 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
>>>      struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
>>>      struct scpi_shared_mem *mem = (struct scpi_shared_mem *)ch->tx_payload;
>>>
>>> -    if (t->tx_buf)
>>> -        memcpy_toio(mem->payload, t->tx_buf, t->tx_len);
>>> +    if (t->tx_buf) {
>>> +        if (scpi_info->is_legacy)
>>> +            memcpy_toio(ch->tx_payload, t->tx_buf, t->tx_len);
>>> +        else
>>> +            memcpy_toio(mem->payload, t->tx_buf, t->tx_len);
>>> +    }
>>> +
>>>      if (t->rx_buf) {
>>>          if (!(++ch->token))
>>>              ++ch->token;
>>>          ADD_SCPI_TOKEN(t->cmd, ch->token);
>>> +        if (scpi_info->is_legacy)
>>> +            t->slot = t->cmd;
>>
>> I thought passing token was not an issue from your previous response,
>> but you are overriding it here, why ?
>
> Indeed, I can leave it, but it's useless since it won't serve to
> distinguish multiple similar commands.
>

OK, I don't see any point in such micro optimization, so please retain it.

[...]

>>> +    /* Since we cannot distinguish the original command in the
>>> +     * MHU reply stat value from a Legacy SCP firmware, ensure
>>> +     * sequential command sending to the firmware.
>>> +     */
>>
>> OK this comment now questions the existence of this extra lock.
>> The mailbox will always send the commands in the sequential order.
>> It's only firmware that can re-order the response. Since that can't
>> happen in you case, I really don't see the need for this.
>>
>> Please explain the race you would see without this locking. Yes I
>> understand that only one command is supposed to be sent to firmware at a
>> time. Suppose you allow more callers here, all will wait on the
>> completion flags and the first in the list gets unblocked right ?
>> I am just trying to understand if there's real need for this extra
>> lock when we already have that from the list.
>
> In my current tests I have huge kernel hang when having multiple callers,
> I must find out where this issue comes from...

Yes IMO, you should understand the root cause of this issue. There may
be issue with the existing driver itself. But just adding a lock just to
avoid the hang without understanding it is wrong.

> In any case, we have an issue about the command sequencing. If we
> push a tx-only command and then right after a tx-rx command, the
> mailbox callback from the first command won't be able to distinguish
> which command is handled !

Hmm, how exactly ? I won't expect scpi_handle_remote_msg to becalled in
that case.

> In this case, the rx_pending list will not be empty, some garbage
> will be returned to the second command handler and the real data from
> the second command handling will be lost thinking it's a tx-only
> command.
>

Yes as I said why is scpi_handle_remote_msg called for tx only command.
And more over we don't have any tx only command in the driver, I am
still unable to understand the issue you are facing. Are you sure you
have tx-only command in the failure/hang case ?

>
> We have two choices here : - Also push the tx-only commands to the
> rx_pending list, and also wait for their completion

See above, I need to know details on this tx-only command. In fact, they
may not be tx-only as SCP is sending some response back, may just status.

> - Add an extra lock
>

Not this for sure.

> What is your preferred scheme ?
>

Option 1 if it legitimate case. I mean we may be misunderstanding the
definition of tx-only command.


>>> +    if (scpi_info->is_legacy)
>>> +        mutex_lock(&scpi_chan->legacy_lock);
>>> +
>>>      ret = mbox_send_message(scpi_chan->chan, msg);
>>>      if (ret < 0 || !rx_buf)
>>>          goto out;
>>> @@ -421,9 +567,13 @@ static int scpi_send_message(unsigned int offset, void *tx_buf,
>>>          /* first status word */
>>>          ret = msg->status;
>>>  out:
>>> -    if (ret < 0 && rx_buf) /* remove entry from the list if timed-out */
>>> +    if (ret < 0 && rx_buf)
>>> +        /* remove entry from the list if timed-out */
>>>          scpi_process_cmd(scpi_chan, msg->cmd);
>>>
>>> +    if (scpi_info->is_legacy)
>>> +        mutex_unlock(&scpi_chan->legacy_lock);
>>> +
>>>      put_scpi_xfer(msg, scpi_chan);
>>>      /* SCPI error codes > 0, translate them to Linux scale*/
>>>      return ret > 0 ? scpi_to_linux_errno(ret) : ret;
>>

[...]

>
> I will fix the issues, but I need your advice for the locking scheme. I really want this
> to be merged and be able to go forward !
>

Yes I agree and I have no major concern with the series now except the
locking.

-- 
Regards,
Sudeep
