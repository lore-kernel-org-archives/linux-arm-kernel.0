From: houlong.wei@mediatek.com (houlong wei)
Date: Wed, 24 Oct 2018 21:17:34 +0800
Subject: [PATCH v26 2/2] soc: mediatek: Add Mediatek CMDQ helper
In-Reply-To: <1538970204-7517-3-git-send-email-houlong.wei@mediatek.com>
References: <1538970204-7517-1-git-send-email-houlong.wei@mediatek.com>
 <1538970204-7517-3-git-send-email-houlong.wei@mediatek.com>
Message-ID: <1540387054.4271.27.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-10-08 at 11:43 +0800, Houlong Wei wrote:
> Add Mediatek CMDQ helper to create CMDQ packet and assemble GCE op code.
> 
> Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig           |   12 ++
>  drivers/soc/mediatek/Makefile          |    1 +
>  drivers/soc/mediatek/mtk-cmdq-helper.c |  292 ++++++++++++++++++++++++++++++++
>  include/linux/soc/mediatek/mtk-cmdq.h  |  133 +++++++++++++++
>  4 files changed, 438 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
>  create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index a7d0667..17bd759 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -4,6 +4,18 @@
>  menu "MediaTek SoC drivers"
>  depends on ARCH_MEDIATEK || COMPILE_TEST
> 
> +config MTK_CMDQ
> +tristate "MediaTek CMDQ Support"
> +depends on ARCH_MEDIATEK || COMPILE_TEST
> +select MAILBOX
> +select MTK_CMDQ_MBOX
> +select MTK_INFRACFG
> +help
> +  Say yes here to add support for the MediaTek Command Queue (CMDQ)
> +  driver. The CMDQ is used to help read/write registers with critical
> +  time limitation, such as updating display configuration during the
> +  vblank.
> +
>  config MTK_INFRACFG
>  bool "MediaTek INFRACFG Support"
>  select REGMAP
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 12998b0..64ce5ee 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
>  obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> new file mode 100644
> index 0000000..45aa0cf
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -0,0 +1,292 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2018 MediaTek Inc.
> +
> +#include <linux/completion.h>
> +#include <linux/errno.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +
> +#define CMDQ_ARG_A_WRITE_MASK0xffff
> +#define CMDQ_WRITE_ENABLE_MASKBIT(0)
> +#define CMDQ_EOC_IRQ_ENBIT(0)
> +#define CMDQ_EOC_CMD((u64)((CMDQ_CODE_EOC << CMDQ_OP_CODE_SHIFT)) \
> +<< 32 | CMDQ_EOC_IRQ_EN)
> +
> +static void cmdq_client_timeout(struct timer_list *t)
> +{
> +struct cmdq_client *client = from_timer(client, t, timer);
> +
> +dev_err(client->client.dev, "cmdq timeout!\n");
> +}
> +
> +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index, u32 timeout)
> +{
> +struct cmdq_client *client;
> +
> +client = kzalloc(sizeof(*client), GFP_KERNEL);
> +if (!client)
> +return (struct cmdq_client *)-ENOMEM;
> +
> +client->timeout_ms = timeout;
> +if (timeout != CMDQ_NO_TIMEOUT) {
> +spin_lock_init(&client->lock);
> +timer_setup(&client->timer, cmdq_client_timeout, 0);
> +}
> +client->pkt_cnt = 0;
> +client->client.dev = dev;
> +client->client.tx_block = false;
> +client->chan = mbox_request_channel(&client->client, index);
> +
> +if (IS_ERR(client->chan)) {
> +long err;
> +
> +dev_err(dev, "failed to request channel\n");
> +err = PTR_ERR(client->chan);
> +kfree(client);
> +
> +return ERR_PTR(err);
> +}
> +
> +return client;
> +}
> +EXPORT_SYMBOL(cmdq_mbox_create);
> +
> +void cmdq_mbox_destroy(struct cmdq_client *client)
> +{
> +if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
> +spin_lock(&client->lock);
> +del_timer_sync(&client->timer);
> +spin_unlock(&client->lock);
> +}
> +mbox_free_channel(client->chan);
> +kfree(client);
> +}
> +EXPORT_SYMBOL(cmdq_mbox_destroy);
> +
> +struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size)
> +{
> +struct cmdq_pkt *pkt;
> +struct device *dev;
> +dma_addr_t dma_addr;
> +
> +pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
> +if (!pkt)
> +return ERR_PTR(-ENOMEM);
> +pkt->va_base = kzalloc(size, GFP_KERNEL);
> +if (!pkt->va_base) {
> +kfree(pkt);
> +return ERR_PTR(-ENOMEM);
> +}
> +pkt->buf_size = size;
> +pkt->cl = (void *)client;
> +
> +dev = client->chan->mbox->dev;
> +dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
> +  DMA_TO_DEVICE);
> +if (dma_mapping_error(dev, dma_addr)) {
> +dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
> +kfree(pkt->va_base);
> +kfree(pkt);
> +return ERR_PTR(-ENOMEM);
> +}
> +
> +pkt->pa_base = dma_addr;
> +
> +return pkt;
> +}
> +EXPORT_SYMBOL(cmdq_pkt_create);
> +
> +void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
> +{
> +struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
> +
> +dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
> + DMA_TO_DEVICE);
> +kfree(pkt->va_base);
> +kfree(pkt);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_destroy);
> +
> +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> +   u32 arg_a, u32 arg_b)
> +{
> +u64 *cmd_ptr;
> +
> +if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
> +pkt->cmd_buf_size += CMDQ_INST_SIZE;
> +WARN_ONCE(1, "%s: buffer size %u is too small !\n",
> +__func__, (u32)pkt->buf_size);
> +return -ENOMEM;
> +}
> +cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
> +(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> +pkt->cmd_buf_size += CMDQ_INST_SIZE;
> +
> +return 0;
> +}
> +
> +int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset)
> +{
> +u32 arg_a = (offset & CMDQ_ARG_A_WRITE_MASK) |
> +    (subsys << CMDQ_SUBSYS_SHIFT);
> +
> +return cmdq_pkt_append_command(pkt, CMDQ_CODE_WRITE, arg_a, value);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_write);
> +
> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
> +u32 subsys, u32 offset, u32 mask)
> +{
> +u32 offset_mask = offset;
> +int err = 0;
> +
> +if (mask != 0xffffffff) {
> +err = cmdq_pkt_append_command(pkt, CMDQ_CODE_MASK, 0, ~mask);
> +offset_mask |= CMDQ_WRITE_ENABLE_MASK;
> +}
> +err |= cmdq_pkt_write(pkt, value, subsys, offset_mask);
> +
> +return err;
> +}
> +EXPORT_SYMBOL(cmdq_pkt_write_mask);
> +
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
> +{
> +u32 arg_b;
> +
> +if (event >= CMDQ_MAX_EVENT)
> +return -EINVAL;
> +
> +/*
> + * WFE arg_b
> + * bit 0-11: wait value
> + * bit 15: 1 - wait, 0 - no wait
> + * bit 16-27: update value
> + * bit 31: 1 - update, 0 - no update
> + */
> +arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
> +
> +return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event, arg_b);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_wfe);
> +
> +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event)
> +{
> +if (event >= CMDQ_MAX_EVENT)
> +return -EINVAL;
> +
> +return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event,
> +       CMDQ_WFE_UPDATE);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_clear_event);
> +
> +static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
> +{
> +int err;
> +
> +/* insert EOC and generate IRQ for each command iteration */
> +err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
> +
> +/* JUMP to end */
> +err |= cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
> +
> +return err;
> +}
> +
> +static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
> +{
> +struct cmdq_pkt *pkt = (struct cmdq_pkt *)data.data;
> +struct cmdq_task_cb *cb = &pkt->cb;
> +struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
> +
> +if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
> +unsigned long flags = 0;
> +
> +spin_lock_irqsave(&client->lock, flags);
> +if (--client->pkt_cnt == 0)
> +del_timer(&client->timer);
> +else
> +mod_timer(&client->timer, jiffies +
> +  msecs_to_jiffies(client->timeout_ms));
> +spin_unlock_irqrestore(&client->lock, flags);
> +}
> +
> +dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base,
> +pkt->cmd_buf_size, DMA_TO_DEVICE);
> +if (cb->cb) {
> +data.data = cb->data;
> +cb->cb(data);
> +}
> +}
> +
> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
> + void *data)
> +{
> +int err;
> +unsigned long flags = 0;
> +struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
> +
> +err = cmdq_pkt_finalize(pkt);
> +if (err < 0)
> +return err;
> +
> +pkt->cb.cb = cb;
> +pkt->cb.data = data;
> +pkt->async_cb.cb = cmdq_pkt_flush_async_cb;
> +pkt->async_cb.data = pkt;
> +
> +dma_sync_single_for_device(client->chan->mbox->dev, pkt->pa_base,
> +   pkt->cmd_buf_size, DMA_TO_DEVICE);
> +
> +if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
> +spin_lock_irqsave(&client->lock, flags);
> +if (client->pkt_cnt++ == 0)
> +mod_timer(&client->timer, jiffies +
> +  msecs_to_jiffies(client->timeout_ms));
> +spin_unlock_irqrestore(&client->lock, flags);
> +}
> +
> +mbox_send_message(client->chan, pkt);
> +/* We can send next packet immediately, so just call txdone. */
> +mbox_client_txdone(client->chan, 0);
> +
> +return 0;
> +}
> +EXPORT_SYMBOL(cmdq_pkt_flush_async);
> +
> +struct cmdq_flush_completion {
> +struct completion cmplt;
> +bool err;
> +};
> +
> +static void cmdq_pkt_flush_cb(struct cmdq_cb_data data)
> +{
> +struct cmdq_flush_completion *cmplt;
> +
> +cmplt = (struct cmdq_flush_completion *)data.data;
> +if (data.sta != CMDQ_CB_NORMAL)
> +cmplt->err = true;
> +else
> +cmplt->err = false;
> +complete(&cmplt->cmplt);
> +}
> +
> +int cmdq_pkt_flush(struct cmdq_pkt *pkt)
> +{
> +struct cmdq_flush_completion cmplt;
> +int err;
> +
> +init_completion(&cmplt.cmplt);
> +err = cmdq_pkt_flush_async(pkt, cmdq_pkt_flush_cb, &cmplt);
> +if (err < 0)
> +return err;
> +wait_for_completion(&cmplt.cmplt);
> +
> +return cmplt.err ? -EFAULT : 0;
> +}
> +EXPORT_SYMBOL(cmdq_pkt_flush);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> new file mode 100644
> index 0000000..54ade13
> --- /dev/null
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -0,0 +1,133 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + *
> + */
> +
> +#ifndef __MTK_CMDQ_H__
> +#define __MTK_CMDQ_H__
> +
> +#include <linux/mailbox_client.h>
> +#include <linux/mailbox/mtk-cmdq-mailbox.h>
> +#include <linux/timer.h>
> +
> +#define CMDQ_NO_TIMEOUT0xffffffffu
> +
> +/** cmdq event maximum */
> +#define CMDQ_MAX_EVENT0x3ff
> +
> +struct cmdq_pkt;
> +
> +struct cmdq_client {
> +spinlock_t lock;
> +u32 pkt_cnt;
> +struct mbox_client client;
> +struct mbox_chan *chan;
> +struct timer_list timer;
> +u32 timeout_ms; /* in unit of microsecond */
> +};
> +
> +/**
> + * cmdq_mbox_create() - create CMDQ mailbox client and channel
> + * @dev:device of CMDQ mailbox client
> + * @index:index of CMDQ mailbox channel
> + * @timeout:timeout of a pkt execution by GCE, in unit of microsecond, set
> + *CMDQ_NO_TIMEOUT if a timer is not used.
> + *
> + * Return: CMDQ mailbox client pointer
> + */
> +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index,
> +     u32 timeout);
> +
> +/**
> + * cmdq_mbox_destroy() - destroy CMDQ mailbox client and channel
> + * @client:the CMDQ mailbox client
> + */
> +void cmdq_mbox_destroy(struct cmdq_client *client);
> +
> +/**
> + * cmdq_pkt_create() - create a CMDQ packet
> + * @client:the CMDQ mailbox client
> + * @size:required CMDQ buffer size
> + *
> + * Return: CMDQ packet pointer
> + */
> +struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size);
> +
> +/**
> + * cmdq_pkt_destroy() - destroy the CMDQ packet
> + * @pkt:the CMDQ packet
> + */
> +void cmdq_pkt_destroy(struct cmdq_pkt *pkt);
> +
> +/**
> + * cmdq_pkt_write() - append write command to the CMDQ packet
> + * @pkt:the CMDQ packet
> + * @value:the specified target register value
> + * @subsys:the CMDQ sub system code
> + * @offset:register offset from CMDQ sub system
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset);
> +
> +/**
> + * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
> + * @pkt:the CMDQ packet
> + * @value:the specified target register value
> + * @subsys:the CMDQ sub system code
> + * @offset:register offset from CMDQ sub system
> + * @mask:the specified target register mask
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
> +u32 subsys, u32 offset, u32 mask);
> +
> +/**
> + * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
> + * @pkt:the CMDQ packet
> + * @event:the desired event type to "wait and CLEAR"
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event);
> +
> +/**
> + * cmdq_pkt_clear_event() - append clear event command to the CMDQ packet
> + * @pkt:the CMDQ packet
> + * @event:the desired event to be cleared
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event);
> +
> +/**
> + * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
> + *                          packet and call back at the end of done packet
> + * @pkt:the CMDQ packet
> + * @cb:called at the end of done packet
> + * @data:this data will pass back to cb
> + *
> + * Return: 0 for success; else the error code is returned
> + *
> + * Trigger CMDQ to asynchronously execute the CMDQ packet and call back
> + * at the end of done packet. Note that this is an ASYNC function. When the
> + * function returned, it may or may not be finished.
> + */
> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
> + void *data);
> +
> +/**
> + * cmdq_pkt_flush() - trigger CMDQ to execute the CMDQ packet
> + * @pkt:the CMDQ packet
> + *
> + * Return: 0 for success; else the error code is returned
> + *
> + * Trigger CMDQ to execute the CMDQ packet. Note that this is a
> + * synchronous flush function. When the function returned, the recorded
> + * commands have been done.
> + */
> +int cmdq_pkt_flush(struct cmdq_pkt *pkt);
> +
> +#endif/* __MTK_CMDQ_H__ */
> --
> 1.7.9.5
> 
Hi Matthias,

Here is a simple example code of cmdq helper driver.

/* device tree: config cmdq in test device-tree node */
cmdq_client_test {
	... /* ommit some properities here */
	mediatek,gce = <&gce>;
	mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>;
	mediatek,gce-subsys = <SUBSYS_1400XXXX>;
	mutex-event-eof = <CMDQ_EVENT_MUTEX0_STREAM_EOF>;
};

/* example code */
/* assume it is added in probe function of the cmdq_client_test device
*/
struct cmdq_client *client;
u32 subsys_base;
u32 subsys_code;
u32 cmdq_event;
struct cmdq_pkt *pkt;
size_t cmdq_buf_size;
int ret;

client = cmdq_mbox_create(dev, 0, 2000);
of_address_to_resource(dev->of_node, 0, &res);
subsys_base = (u32)res.start & 0x0000FFFF;
of_property_read_u32(dev->of_node, "mediatek,gce-subsys",
		&subsys_code);
of_property_read_u32(dev->of_node, "mutex-event-eof", 
		&cmdq_event);

/* create a cmdq packet */
cmdq_buf_size = 0x1000;
pkt = cmdq_pkt_create(client, cmdq_buf_size);
if (IS_ERR(pkt)) {
	pr_err("Failed to create cmdq_pkt\n");
	return PTR_ERR(pkt);
}

/* fill the cmdq packet */
cmdq_pkt_clear_event(pkt, cmdq_event);
cmdq_pkt_wfe(pkt, cmdq_event);
cmdq_pkt_write(pkt, 0x1234, subsys_code, subsys_base + 0x20);
cmdq_pkt_write_mask(pkt, 0x10, subsys_code, subsys_base + 0x100, 0x10);
/* ommit the filling operations here */
...
ret = cmdq_pkt_flush(pkt);
if (ret != 0) {
	/* print error log and do error handling */
	pr_err("cmdq pkt flush failed! pkt->buf_size=%u, pkt->cmd_buf_size=%u
\n",
    	pkt->buf_size, pkt->cmd_buf_size);
	/**
	 * In developing phase, programmer should increase the initialization
value
	 * of cmdq_buf_size above if (pkt->cmd_buf_size < pkt->buf_size), and
test again.
	 * When committing code, the value of cmdq_buf_size is fixed.
	 * Same below.
	 */
}

/* reuse the cmdq packet, change the cmdq_buf_size to 0. */
pkt->cmd_buf_size = 0;
cmdq_pkt_write(pkt, 0x11223344, subsys_code, subsys_base + 0x60);
cmdq_pkt_write_mask(pkt, 0x10, subsys_code, subsys_base + 0x30, 0x10);
/* ommit the filling operations here */
...
ret = cmdq_pkt_flush(pkt);
if (ret != 0) {
	/* print error log and do error handing */
}

/* destroy the cmdq packet if it is unused any more */
cmdq_pkt_destroy(pkt);
/* destroy the cmdq mailbox client at last */
cmdq_mbox_destroy(client);
