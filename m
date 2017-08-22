From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 22 Aug 2017 18:05:36 +0530
Subject: [PATCH 10/18] rpmsg: glink: Add support for TX intents
In-Reply-To: <4c244f12-7420-3e25-fed3-b89847a8697e@codeaurora.org>
References: <1502903951-5403-1-git-send-email-sricharan@codeaurora.org>
 <1502903951-5403-11-git-send-email-sricharan@codeaurora.org>
 <4c244f12-7420-3e25-fed3-b89847a8697e@codeaurora.org>
Message-ID: <22a403ef-dfd1-48ab-675b-b78881e2c4b8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

<snip>

> 
> spinlock intent_lock initialization is missed ?

 right, should add that.

>> ????? kref_init(&channel->refcount);
>> ? ????? return channel;
>> @@ -187,6 +215,7 @@ static void qcom_glink_channel_release(struct kref *ref)
>> ????? struct glink_channel *channel = container_of(ref, struct glink_channel,
>> ?????????????????????????????? refcount);
>> ? +??? idr_destroy(&channel->liids);
> 
> idr_destroy shouldn`t be covered by intent_lock ?
> 

 hmm, will fix this.

>> ????? kfree(channel->name);
>> ????? kfree(channel);
>> ? }
>> @@ -423,6 +452,130 @@ static void qcom_glink_receive_version_ack(struct qcom_glink *glink,
>> ????? }
>> ? }
>> ? +/**
>> + * qcom_glink_send_intent_req_ack() - convert an rx intent request ack cmd to
>> +????????????????????? wire format and transmit
>> + * @glink:??? The transport to transmit on.
>> + * @channel:??? The glink channel
>> + * @granted:??? The request response to encode.
>> + *
>> + * Return: 0 on success or standard Linux error code.
>> + */
>> +static int qcom_glink_send_intent_req_ack(struct qcom_glink *glink,
>> +????????????????????? struct glink_channel *channel,
>> +????????????????????? bool granted)
>> +{
>> +??? struct glink_msg msg;
>> +
>> +??? msg.cmd = cpu_to_le16(RPM_CMD_RX_INTENT_REQ_ACK);
>> +??? msg.param1 = cpu_to_le16(channel->lcid);
>> +??? msg.param2 = cpu_to_le32(granted);
>> +
>> +??? qcom_glink_tx(glink, &msg, sizeof(msg), NULL, 0, true);
>> +
>> +??? return 0;
>> +}
>> +
>> +/**
>> + * tx_cmd_local_rx_intent() - convert an rx intent cmd to wire format and
>> + *?????????????? transmit
> 
> copy-paste mistake

 ok.

>> + * @glink:??? The transport to transmit on.
>> + * @channel:??? The local channel
>> + * @size:??? The intent to pass on to remote.
>> + *
>> + * Return: 0 on success or standard Linux error code.
>> + */
>> +static int qcom_glink_advertise_intent(struct qcom_glink *glink,
>> +?????????????????????? struct glink_channel *channel,
>> +?????????????????????? struct glink_core_rx_intent *intent)
>> +{
>> +??? struct command {
>> +??????? u16 id;
>> +??????? u16 lcid;
>> +??????? u32 count;
>> +??????? u32 size;
>> +??????? u32 liid;
>> +??? } __packed;
>> +??? struct command cmd;
>> +
>> +??? cmd.id = cpu_to_le16(RPM_CMD_INTENT);
>> +??? cmd.lcid = cpu_to_le16(channel->lcid);
>> +??? cmd.count = cpu_to_le32(1);
>> +??? cmd.size = cpu_to_le32(intent->size);
>> +??? cmd.liid = cpu_to_le32(intent->id);
>> +
>> +??? qcom_glink_tx(glink, &cmd, sizeof(cmd), NULL, 0, true);
>> +
>> +??? return 0;
>> +}
>> +
>> +static struct glink_core_rx_intent *
>> +qcom_glink_alloc_intent(struct qcom_glink *glink,
>> +??????????? struct glink_channel *channel,
>> +??????????? size_t size,
>> +??????????? bool reuseable)
>> +{
>> +??? struct glink_core_rx_intent *intent;
>> +??? int ret;
>> +??? unsigned long flags;
>> +
>> +??? intent = kzalloc(sizeof(*intent), GFP_KERNEL);
>> +
>> +??? if (!intent)
>> +??????? return NULL;
>> +
>> +??? intent->data = kzalloc(size, GFP_KERNEL);
>> +??? if (!intent->data)
>> +??????? return NULL;
>> +
>> +??? spin_lock_irqsave(&channel->intent_lock, flags);
>> +??? ret = idr_alloc_cyclic(&channel->liids, intent, 1, -1, GFP_ATOMIC);
>> +??? if (ret < 0) {
>> +??????? spin_unlock_irqrestore(&channel->intent_lock, flags);
>> +??????? return NULL;
>> +??? }
>> +??? spin_unlock_irqrestore(&channel->intent_lock, flags);
>> +
>> +??? intent->id = ret;
>> +??? intent->size = size;
>> +??? intent->reuse = reuseable;
>> +
>> +??? return intent;
>> +}
>> +
>> +/**
>> + * glink_core_rx_cmd_remote_rx_intent_req() - Receive a request for rx_intent
>> + *??????????????????????? from remote side
> 
> copy-paste mistake

 ok.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
