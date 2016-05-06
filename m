From: nkaje@codeaurora.org (Naveen Kaje)
Date: Fri, 6 May 2016 11:36:17 -0600
Subject: [V2, 1/2] drivers: i2c: qup: Fix broken dma when CONFIG_DEBUG_SG
 is enabled
In-Reply-To: <1462534274-28925-2-git-send-email-sricharan@codeaurora.org>
References: <1462534274-28925-2-git-send-email-sricharan@codeaurora.org>
Message-ID: <91a135eb-b517-a9ec-5f96-cbed60bbe710@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/6/2016 5:31 AM, Sricharan R wrote:
> With CONFIG_DEBUG_SG is enabled and when dma mode is used, below dump is seen,
>
> ------------[ cut here ]------------
> kernel BUG at include/linux/scatterlist.h:140!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.0-00459-g9f087b9-dirty #7
> Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> task: ffffffc036868000 ti: ffffffc036870000 task.ti: ffffffc036870000
> PC is at qup_sg_set_buf.isra.13+0x138/0x154
> LR is at qup_sg_set_buf.isra.13+0x50/0x154
> pc : [<ffffffc0005a0ed8>] lr : [<ffffffc0005a0df0>] pstate: 60000145
> sp : ffffffc0368735c0
> x29: ffffffc0368735c0 x28: ffffffc036873752
> x27: ffffffc035233018 x26: ffffffc000c4e000
> x25: 0000000000000000 x24: 0000000000000004
> x23: 0000000000000000 x22: ffffffc035233668
> x21: ffffff80004e3000 x20: ffffffc0352e0018
> x19: 0000004000000000 x18: 0000000000000028
> x17: 0000000000000004 x16: ffffffc0017a39c8
> x15: 0000000000001cdf x14: ffffffc0019929d8
> x13: ffffffc0352e0018 x12: 0000000000000000
> x11: 0000000000000001 x10: 0000000000000001
> x9 : ffffffc0012b2d70 x8 : ffffff80004e3000
> x7 : 0000000000000018 x6 : 0000000030000000
> x5 : ffffffc00199f018 x4 : ffffffc035233018
> x3 : 0000000000000004 x2 : 00000000c0000000
> x1 : 0000000000000003 x0 : 0000000000000000
>
> Process swapper/0 (pid: 1, stack limit = 0xffffffc036870020)
> Stack: (0xffffffc0368735c0 to 0xffffffc036874000)
>
> Change allocation of sg buffers from dma_coherent memory to kzalloc
> to fix the issue.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>

Tested on QDF2432 with ACPI and SMBus support patches for regressions. 
Note that this platform does not use DMA mode.

Tested-by: Naveen Kaje <nkaje@codeaurora.org>

> ---
>   drivers/i2c/busses/i2c-qup.c | 53 ++++++++++++++------------------------------
>   1 file changed, 17 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index 23eaabb..8620e99 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -585,8 +585,8 @@ static void qup_i2c_bam_cb(void *data)
>   }
>   
>   static int qup_sg_set_buf(struct scatterlist *sg, void *buf,
> -			  struct qup_i2c_tag *tg, unsigned int buflen,
> -			  struct qup_i2c_dev *qup, int map, int dir)
> +			  unsigned int buflen, struct qup_i2c_dev *qup,
> +			  int dir)
>   {
>   	int ret;
>   
> @@ -595,9 +595,6 @@ static int qup_sg_set_buf(struct scatterlist *sg, void *buf,
>   	if (!ret)
>   		return -EINVAL;
>   
> -	if (!map)
> -		sg_dma_address(sg) = tg->addr + ((u8 *)buf - tg->start);
> -
>   	return 0;
>   }
>   
> @@ -670,16 +667,15 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   				/* scratch buf to read the start and len tags */
>   				ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
>   						     &qup->brx.tag.start[0],
> -						     &qup->brx.tag,
> -						     2, qup, 0, 0);
> +						     2, qup, DMA_FROM_DEVICE);
>   
>   				if (ret)
>   					return ret;
>   
>   				ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
>   						     &msg->buf[limit * i],
> -						     NULL, tlen, qup,
> -						     1, DMA_FROM_DEVICE);
> +						     tlen, qup,
> +						     DMA_FROM_DEVICE);
>   				if (ret)
>   					return ret;
>   
> @@ -688,7 +684,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   			}
>   			ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
>   					     &qup->start_tag.start[off],
> -					     &qup->start_tag, len, qup, 0, 0);
> +					     len, qup, DMA_TO_DEVICE);
>   			if (ret)
>   				return ret;
>   
> @@ -696,8 +692,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   			/* scratch buf to read the BAM EOT and FLUSH tags */
>   			ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
>   					     &qup->brx.tag.start[0],
> -					     &qup->brx.tag, 2,
> -					     qup, 0, 0);
> +					     2, qup, DMA_FROM_DEVICE);
>   			if (ret)
>   				return ret;
>   		} else {
> @@ -709,17 +704,15 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   				len = qup_i2c_set_tags(tags, qup, msg, 1);
>   
>   				ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
> -						     tags,
> -						     &qup->start_tag, len,
> -						     qup, 0, 0);
> +						     tags, len,
> +						     qup, DMA_TO_DEVICE);
>   				if (ret)
>   					return ret;
>   
>   				tx_len += len;
>   				ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
>   						     &msg->buf[limit * i],
> -						     NULL, tlen, qup, 1,
> -						     DMA_TO_DEVICE);
> +						     tlen, qup, DMA_TO_DEVICE);
>   				if (ret)
>   					return ret;
>   				i++;
> @@ -738,8 +731,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
>   							QUP_BAM_FLUSH_STOP;
>   				ret = qup_sg_set_buf(&qup->btx.sg[tx_buf++],
>   						     &qup->btx.tag.start[0],
> -						     &qup->btx.tag, len,
> -						     qup, 0, 0);
> +						     len, qup, DMA_TO_DEVICE);
>   				if (ret)
>   					return ret;
>   				tx_nents += 1;
> @@ -1268,6 +1260,8 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>   		}
>   	}
>   
> +	idx = 0;
> +
>   	do {
>   		if (msgs[idx].len == 0) {
>   			ret = -EINVAL;
> @@ -1407,27 +1401,21 @@ static int qup_i2c_probe(struct platform_device *pdev)
>   
>   		/* 2 tag bytes for each block + 5 for start, stop tags */
>   		size = blocks * 2 + 5;
> -		qup->dpool = dma_pool_create("qup_i2c-dma-pool", &pdev->dev,
> -					     size, 4, 0);
>   
> -		qup->start_tag.start = dma_pool_alloc(qup->dpool, GFP_KERNEL,
> -						      &qup->start_tag.addr);
> +		qup->start_tag.start = devm_kzalloc(&pdev->dev,
> +						    size, GFP_KERNEL);
>   		if (!qup->start_tag.start) {
>   			ret = -ENOMEM;
>   			goto fail_dma;
>   		}
>   
> -		qup->brx.tag.start = dma_pool_alloc(qup->dpool,
> -						    GFP_KERNEL,
> -						    &qup->brx.tag.addr);
> +		qup->brx.tag.start = devm_kzalloc(&pdev->dev, 2, GFP_KERNEL);
>   		if (!qup->brx.tag.start) {
>   			ret = -ENOMEM;
>   			goto fail_dma;
>   		}
>   
> -		qup->btx.tag.start = dma_pool_alloc(qup->dpool,
> -						    GFP_KERNEL,
> -						    &qup->btx.tag.addr);
> +		qup->btx.tag.start = devm_kzalloc(&pdev->dev, 2, GFP_KERNEL);
>   		if (!qup->btx.tag.start) {
>   			ret = -ENOMEM;
>   			goto fail_dma;
> @@ -1566,13 +1554,6 @@ static int qup_i2c_remove(struct platform_device *pdev)
>   	struct qup_i2c_dev *qup = platform_get_drvdata(pdev);
>   
>   	if (qup->is_dma) {
> -		dma_pool_free(qup->dpool, qup->start_tag.start,
> -			      qup->start_tag.addr);
> -		dma_pool_free(qup->dpool, qup->brx.tag.start,
> -			      qup->brx.tag.addr);
> -		dma_pool_free(qup->dpool, qup->btx.tag.start,
> -			      qup->btx.tag.addr);
> -		dma_pool_destroy(qup->dpool);
>   		dma_release_channel(qup->btx.dma);
>   		dma_release_channel(qup->brx.dma);
>   	}
