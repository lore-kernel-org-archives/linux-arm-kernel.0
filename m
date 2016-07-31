From: timur@codeaurora.org (Timur Tabi)
Date: Sun, 31 Jul 2016 09:13:48 -0500
Subject: [PATCH V2] dmaengine: qcom_hidma: release the descriptor before
 the callback
In-Reply-To: <1469974266-28023-1-git-send-email-okaya@codeaurora.org>
References: <1469974266-28023-1-git-send-email-okaya@codeaurora.org>
Message-ID: <579E079C.2040500@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinan Kaya wrote:
> +	list_for_each_entry_safe(mdesc, next, &list, node) {
>   		enum dma_status llstat;
> +		dma_async_tx_callback callback;
> +		void *param;
>
>   		desc = &mdesc->desc;
>
> @@ -132,18 +135,19 @@ static void hidma_process_completed(struct hidma_chan *mchan)
>   		spin_unlock_irqrestore(&mchan->lock, irqflags);
>
>   		llstat = hidma_ll_status(mdma->lldev, mdesc->tre_ch);
> -		if (desc->callback && (llstat == DMA_COMPLETE))
> -			desc->callback(desc->callback_param);
> +		callback = desc->callback;
> +		param = desc->callback_param;

It looks to me like 'callback' and 'param' are never actually used.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
