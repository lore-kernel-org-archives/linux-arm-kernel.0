From: nvishwan@codeaurora.org (nvishwan at codeaurora.org)
Date: Tue, 21 Dec 2010 15:45:45 -0800 (PST)
Subject: [PATCH] msm: rmnet: msm rmnet smd virtual ethernet driver
In-Reply-To: <20101215134406.3a634aa8@nehalam>
References: <1292437866-11652-1-git-send-email-nvishwan@codeaurora.org>
	<20101215134406.3a634aa8@nehalam>
Message-ID: <2c27ccc1dd4db9a31cd961f0ffaed886.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, 15 Dec 2010 10:31:06 -0800
> Niranjana Vishwanathapura <nvishwan@codeaurora.org> wrote:
>
>> +
>> +static DECLARE_TASKLET(smd_net_data_tasklet, smd_net_data_handler, 0);
>> +
>> +static void smd_net_notify(void *_dev, unsigned event)
>> +{
>> +	if (event != SMD_EVENT_DATA)
>> +		return;
>> +
>> +	smd_net_data_tasklet.data = (unsigned long) _dev;
>> +
>> +	tasklet_schedule(&smd_net_data_tasklet);
>> +}
>> +
>
> Rather than having private tasklet, maybe using NAPI
> would be better?
>
> Also since you are already in tasklet, no need to call netif_rx()
> when receiving packet; instead use netif_receive_skb directly.
>
> --
>

NAPI will not buy much as the SMD transport doesn't provide a machanism to
stop interrupts.  I will consider using NAPI in the future (it requires
performance testing on lot of different targets).

However, I can replace netif_rx() by netif_receive_skb() and send out new
patch
