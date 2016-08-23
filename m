From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 23 Aug 2016 15:42:30 +0100
Subject: [PATCH 03/13] scpi: Add legacy send, prepare and handle remote
 functions
In-Reply-To: <3d384710-c2c1-974f-c217-a2198d98ea22@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
 <1471515066-3626-4-git-send-email-narmstrong@baylibre.com>
 <b88c0ffc-09d2-4138-3007-b1e28c955cce@arm.com>
 <3d384710-c2c1-974f-c217-a2198d98ea22@baylibre.com>
Message-ID: <7dcd921d-e48f-ca46-2b86-4df3e332ff44@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/08/16 09:15, Neil Armstrong wrote:
> On 08/19/2016 06:13 PM, Sudeep Holla wrote:
>>
>>
>> On 18/08/16 11:10, Neil Armstrong wrote:
>>> In order to support the legacy SCPI procotol, add specific message_send,
>>> prepare_tx and handle_remote functions since the legacy procotol
>>> do not support message queuing and does not store the command word in the
>>> tx_payload data.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  drivers/firmware/arm_scpi.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 69 insertions(+)
>>>
>>> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
>>> index 0bb6134..50b1297 100644
>>> --- a/drivers/firmware/arm_scpi.c
>>> +++ b/drivers/firmware/arm_scpi.c

[..]

>>>
>>> +static void legacy_scpi_tx_prepare(struct mbox_client *c, void *__msg)
>>> +{
>>> +    struct scpi_chan *ch =
>>> +        container_of(c, struct scpi_chan, cl);
>>> +
>>> +    if (ch->t->tx_buf && ch->t->tx_len)
>>> +        memcpy_toio(ch->tx_payload, ch->t->tx_buf, ch->t->tx_len);
>>
>>
>> I see that you are not using the list. Any particular reason for that ?
>>
>> IMO, that *might* help to reuse more code, but I may be wrong. Let's see
>> Some commands like DVFS take more time compared to simple query type of
>> commands. Queuing does help there instead of blocking the channel until
>> the receipt of response.
>
> I'll like to use the list, but, the "cmd" value is not stored in the shared tx
> memory, so we cannot recover the original tranfer from reading the tx memory cmd.
>

Even in the current driver we read the mem->command and search the list
in scpi_process_cmd. Instead *(u32 *)msg gives the command value, no ?

> This is why I added a "struct scpi_xfer *t;" in the scpi_chan structure to store
> the current transfer.
>

I don't like that. I am trying to get rid of that.
1. list is not being used
2. scpi_xfer is stashed even though we have only one command in
    progress at any time in your case.

>>
>>> +}
>>> +
>>>  static int legacy_high_priority_cmds[] = {
>>>      LEGACY_SCPI_CMD_GET_CSS_PWR_STATE,
>>>      LEGACY_SCPI_CMD_CFG_PWR_STATE_STAT,
>>> @@ -434,6 +461,48 @@ static void put_scpi_xfer(struct scpi_xfer *t, struct scpi_chan *ch)
>>>      mutex_unlock(&ch->xfers_lock);
>>>  }
>>>
>>> +static int legacy_scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
>>> +                void *rx_buf, unsigned int rx_len)
>>> +{
>>> +    int ret;
>>> +    u8 chan;
>>> +    struct scpi_xfer *msg;
>>> +    struct scpi_chan *scpi_chan;
>>> +
>>> +    chan = legacy_scpi_get_chan(cmd);
>>> +    scpi_chan = scpi_info->channels + chan;
>>> +
>>> +    msg = get_scpi_xfer(scpi_chan);
>>> +    if (!msg)
>>> +        return -ENOMEM;
>>> +
>>> +    mutex_lock(&scpi_chan->xfers_lock);
>>> +
>>
>> May be you can copy msg->cmd to msg->slot and that may help to reuse
>> more code or worst-case keep them aligned.
>
> Yes, it could be. But since the msg is not reused bu the tx_prepare and handle_response,
> we can pass anything here.

IIUC, we should be able to handle it using msg pte in handle_remote_msg

> And for the rockchip case, we must pass an xfer unrelated pointer here since they need
> a specially crafted memory structure for the mailbox.
>

We can consider that when they upstream the driver. Let's not consider
it now.

>>
>>> +    msg->cmd = PACK_LEGACY_SCPI_CMD(cmd, tx_len);
>>> +    msg->tx_buf = tx_buf;
>>> +    msg->tx_len = tx_len;
>>> +    msg->rx_buf = rx_buf;
>>> +    msg->rx_len = rx_len;
>>> +    init_completion(&msg->done);
>>> +    scpi_chan->t = msg;
>>> +
>>> +    ret = mbox_send_message(scpi_chan->chan, &msg->cmd);
>>
>> If slot is initialized to cmd, then you can pass msg itself above.
>> Then you can evaluate how much this function deviates from
>> scpi_send_message and try to re-use.
>
> The function deviates quite a lot since the queing is not used.
>

You have not given me the reason for not using the list yet.
If the msg ptr is used in scpi_handle_remote_msg, you should be able to
make use of it.

>>
>>> +    if (ret < 0)
>>> +        goto out;
>>> +
>>> +    if (!wait_for_completion_timeout(&msg->done, MAX_RX_TIMEOUT))
>>> +        ret = -ETIMEDOUT;
>>> +    else
>>> +        /* first status word */
>>> +        ret = msg->status;
>>> +out:
>>> +    mutex_unlock(&scpi_chan->xfers_lock);
>>> +
>>> +    put_scpi_xfer(msg, scpi_chan);
>>> +    /* SCPI error codes > 0, translate them to Linux scale*/
>>> +    return ret > 0 ? scpi_to_linux_errno(ret) : ret;
>>> +}
>>> +
>>>  static int __scpi_send_message(u8 cmd, void *tx_buf, unsigned int tx_len,
>>>                     void *rx_buf, unsigned int rx_len, bool extn)
>>>  {
>>>
>>
>> [Nit]: Not sure if we need this as a separate patch. It might just
>> generate warnings, anyways we can merge into one later.
>
> I'll prefer to have functionnaly separate patches for now to clarify the changes.
> I'll eventually merge them for the final apply if needed.
>

Ah OK, then fine.

-- 
Regards,
Sudeep
