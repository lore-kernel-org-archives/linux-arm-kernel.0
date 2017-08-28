From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 29 Aug 2017 04:43:47 +0530
Subject: [PATCH v2 11/20] rpmsg: glink: Fix idr_lock from mutex to spinlock
In-Reply-To: <88b34df6-d697-1d98-6427-5ddfe14785b1@codeaurora.org>
References: <1503559302-3744-1-git-send-email-sricharan@codeaurora.org>
 <1503559302-3744-12-git-send-email-sricharan@codeaurora.org>
 <88b34df6-d697-1d98-6427-5ddfe14785b1@codeaurora.org>
Message-ID: <ad77bb2a-cfa2-68af-8a44-a99938aecadd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On 8/29/2017 3:21 AM, Chris Lew wrote:
> Hi Sricharan,
> 
> Minor bug in this patch.
> 
> On 8/24/2017 12:21 AM, Sricharan R wrote:
> [..]
>> @@ -829,11 +839,14 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
>> ????? struct device_node *node;
>> ????? int lcid;
>> ????? int ret;
>> +??? unsigned long flags;
>> ? +??? spin_lock_irqsave(&glink->idr_lock, flags);
>> ????? idr_for_each_entry(&glink->lcids, channel, lcid) {
>> ????????? if (!strcmp(channel->name, name))
>> ????????????? break;
>> ????? }
>> +??? spin_unlock_irqrestore(&glink->idr_lock, flags);
>> ? ????? if (!channel) {
>> ????????? channel = qcom_glink_alloc_channel(glink, name);
>> @@ -844,15 +857,15 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
>> ????????? create_device = true;
>> ????? }
>> ? -??? mutex_lock(&glink->idr_lock);
>> +??? spin_lock_irqsave(&glink->idr_lock, flags);
>> ????? ret = idr_alloc(&glink->rcids, channel, rcid, rcid + 1, GFP_KERNEL);
> 
> I think GFP_KERNEL should be changed to GFP_ATOMIC if the mutex is changed to spinlock.
> 

 ha, thanks for the catch.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
