From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 21 Aug 2018 17:06:07 +0200
Subject: [PATCH] mailbox: mediatek: Add check for possible failure of
 kzalloc
In-Reply-To: <1534846964-13224-1-git-send-email-houlong.wei@mediatek.com>
References: <1534846964-13224-1-git-send-email-houlong.wei@mediatek.com>
Message-ID: <1534863967.5009.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-08-21 at 18:22 +0800, Houlong Wei wrote:
> The patch 623a6143a845("mailbox: mediatek: Add Mediatek CMDQ driver")
> introduce the following static checker warning:
>   drivers/mailbox/mtk-cmdq-mailbox.c:366 cmdq_mbox_send_data()
>   error: potential null dereference 'task'.  (kzalloc returns null)
> 
> Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index aec46d5..f7cc29c 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -363,6 +363,9 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
>  	WARN_ON(cmdq->suspended);
>  
>  	task = kzalloc(sizeof(*task), GFP_ATOMIC);
> +	if (!task)
> +		return -ENOMEM;
> +
>  	task->cmdq = cmdq;
>  	INIT_LIST_HEAD(&task->list_entry);
>  	task->pa_base = pkt->pa_base;

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
