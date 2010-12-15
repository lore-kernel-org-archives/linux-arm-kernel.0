From: shemminger@vyatta.com (Stephen Hemminger)
Date: Wed, 15 Dec 2010 13:44:06 -0800
Subject: [PATCH] msm: rmnet: msm rmnet smd virtual ethernet driver
In-Reply-To: <1292437866-11652-1-git-send-email-nvishwan@codeaurora.org>
References: <1292437866-11652-1-git-send-email-nvishwan@codeaurora.org>
Message-ID: <20101215134406.3a634aa8@nehalam>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Dec 2010 10:31:06 -0800
Niranjana Vishwanathapura <nvishwan@codeaurora.org> wrote:

> +
> +static DECLARE_TASKLET(smd_net_data_tasklet, smd_net_data_handler, 0);
> +
> +static void smd_net_notify(void *_dev, unsigned event)
> +{
> +	if (event != SMD_EVENT_DATA)
> +		return;
> +
> +	smd_net_data_tasklet.data = (unsigned long) _dev;
> +
> +	tasklet_schedule(&smd_net_data_tasklet);
> +}
> +

Rather than having private tasklet, maybe using NAPI
would be better?

Also since you are already in tasklet, no need to call netif_rx()
when receiving packet; instead use netif_receive_skb directly.

-- 
