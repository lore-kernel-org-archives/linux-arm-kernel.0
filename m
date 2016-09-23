From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Fri, 23 Sep 2016 17:28:18 +0800
Subject: [PATCH v14 2/4] CMDQ: Mediatek CMDQ driver
In-Reply-To: <CABb+yY1U8WeSWTaeiPJDO1WCBm2AH2QGAiyBextga-KFHwspig@mail.gmail.com>
References: <1473039885-24009-1-git-send-email-hs.liao@mediatek.com>
 <1473039885-24009-3-git-send-email-hs.liao@mediatek.com>
 <CABb+yY1U8WeSWTaeiPJDO1WCBm2AH2QGAiyBextga-KFHwspig@mail.gmail.com>
Message-ID: <1474622898.21723.26.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

Please see my inline reply.

On Thu, 2016-09-22 at 13:47 +0530, Jassi Brar wrote:
> On Mon, Sep 5, 2016 at 7:14 AM, HS Liao <hs.liao@mediatek.com> wrote:
[...]
> > +struct cmdq_base *cmdq_register_device(struct device *dev)
> > +{
> > +       struct cmdq_base *cmdq_base;
> > +       struct resource res;
> > +       int subsys;
> > +       u32 base;
> > +
> > +       if (of_address_to_resource(dev->of_node, 0, &res))
> > +               return NULL;
> > +       base = (u32)res.start;
> > +
> > +       subsys = cmdq_subsys_base_to_id(base >> 16);
> > +       if (subsys < 0)
> > +               return NULL;
> > +
> > +       cmdq_base = devm_kmalloc(dev, sizeof(*cmdq_base), GFP_KERNEL);
> > +       if (!cmdq_base)
> > +               return NULL;
> > +       cmdq_base->subsys = subsys;
> > +       cmdq_base->base = base;
> > +
> > +       return cmdq_base;
> > +}
> > +EXPORT_SYMBOL(cmdq_register_device);
> > +
> > +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index)
> > +{
> > +       struct cmdq_client *client;
> > +
> > +       client = kzalloc(sizeof(*client), GFP_KERNEL);
> > +       client->client.dev = dev;
> > +       client->client.tx_block = false;
> > +       client->chan = mbox_request_channel(&client->client, index);
> > +       return client;
> > +}
> > +EXPORT_SYMBOL(cmdq_mbox_create);
> > +
> > +int cmdq_task_create(struct device *dev, struct cmdq_task **task_ptr)
> > +{
> > +       struct cmdq_task *task;
> > +       int err;
> > +
> > +       task = kzalloc(sizeof(*task), GFP_KERNEL);
> > +       if (!task)
> > +               return -ENOMEM;
> > +       task->cmdq = dev_get_drvdata(dev);
> > +       err = cmdq_task_realloc_cmd_buffer(task, PAGE_SIZE);
> > +       if (err < 0) {
> > +               kfree(task);
> > +               return err;
> > +       }
> > +       *task_ptr = task;
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL(cmdq_task_create);
> > +
> > +static int cmdq_task_append_command(struct cmdq_task *task, enum cmdq_code code,
> > +                                   u32 arg_a, u32 arg_b)
> > +{
> > +       u64 *cmd_ptr;
> > +       int err;
> > +
> > +       if (WARN_ON(task->finalized))
> > +               return -EBUSY;
> > +       if (unlikely(task->cmd_buf_size + CMDQ_INST_SIZE > task->buf_size)) {
> > +               err = cmdq_task_realloc_cmd_buffer(task, task->buf_size * 2);
> > +               if (err < 0)
> > +                       return err;
> > +       }
> > +       cmd_ptr = task->va_base + task->cmd_buf_size;
> > +       (*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> > +       task->cmd_buf_size += CMDQ_INST_SIZE;
> > +       return 0;
> > +}
> > +
> > +int cmdq_task_write(struct cmdq_task *task, u32 value, struct cmdq_base *base,
> > +                   u32 offset)
> > +{
> > +       u32 arg_a = ((base->base + offset) & CMDQ_ARG_A_WRITE_MASK) |
> > +                   (base->subsys << CMDQ_SUBSYS_SHIFT);
> > +       return cmdq_task_append_command(task, CMDQ_CODE_WRITE, arg_a, value);
> > +}
> > +EXPORT_SYMBOL(cmdq_task_write);
> > +
> > +int cmdq_task_write_mask(struct cmdq_task *task, u32 value,
> > +                        struct cmdq_base *base, u32 offset, u32 mask)
> > +{
> > +       u32 offset_mask = offset;
> > +       int err;
> > +
> > +       if (mask != 0xffffffff) {
> > +               err = cmdq_task_append_command(task, CMDQ_CODE_MASK, 0, ~mask);
> > +               if (err < 0)
> > +                       return err;
> > +               offset_mask |= CMDQ_WRITE_ENABLE_MASK;
> > +       }
> > +       return cmdq_task_write(task, value, base, offset_mask);
> > +}
> > +EXPORT_SYMBOL(cmdq_task_write_mask);
> > +
> > +static const u32 cmdq_event_value[CMDQ_MAX_EVENT] = {
> > +       /* Display start of frame(SOF) events */
> > +       [CMDQ_EVENT_DISP_OVL0_SOF] = 11,
> > +       [CMDQ_EVENT_DISP_OVL1_SOF] = 12,
> > +       [CMDQ_EVENT_DISP_RDMA0_SOF] = 13,
> > +       [CMDQ_EVENT_DISP_RDMA1_SOF] = 14,
> > +       [CMDQ_EVENT_DISP_RDMA2_SOF] = 15,
> > +       [CMDQ_EVENT_DISP_WDMA0_SOF] = 16,
> > +       [CMDQ_EVENT_DISP_WDMA1_SOF] = 17,
> > +       /* Display end of frame(EOF) events */
> > +       [CMDQ_EVENT_DISP_OVL0_EOF] = 39,
> > +       [CMDQ_EVENT_DISP_OVL1_EOF] = 40,
> > +       [CMDQ_EVENT_DISP_RDMA0_EOF] = 41,
> > +       [CMDQ_EVENT_DISP_RDMA1_EOF] = 42,
> > +       [CMDQ_EVENT_DISP_RDMA2_EOF] = 43,
> > +       [CMDQ_EVENT_DISP_WDMA0_EOF] = 44,
> > +       [CMDQ_EVENT_DISP_WDMA1_EOF] = 45,
> > +       /* Mutex end of frame(EOF) events */
> > +       [CMDQ_EVENT_MUTEX0_STREAM_EOF] = 53,
> > +       [CMDQ_EVENT_MUTEX1_STREAM_EOF] = 54,
> > +       [CMDQ_EVENT_MUTEX2_STREAM_EOF] = 55,
> > +       [CMDQ_EVENT_MUTEX3_STREAM_EOF] = 56,
> > +       [CMDQ_EVENT_MUTEX4_STREAM_EOF] = 57,
> > +       /* Display underrun events */
> > +       [CMDQ_EVENT_DISP_RDMA0_UNDERRUN] = 63,
> > +       [CMDQ_EVENT_DISP_RDMA1_UNDERRUN] = 64,
> > +       [CMDQ_EVENT_DISP_RDMA2_UNDERRUN] = 65,
> > +};
> > +
> > +int cmdq_task_wfe(struct cmdq_task *task, enum cmdq_event event)
> > +{
> > +       u32 arg_b;
> > +
> > +       if (event >= CMDQ_MAX_EVENT || event < 0)
> > +               return -EINVAL;
> > +
> > +       /*
> > +        * WFE arg_b
> > +        * bit 0-11: wait value
> > +        * bit 15: 1 - wait, 0 - no wait
> > +        * bit 16-27: update value
> > +        * bit 31: 1 - update, 0 - no update
> > +        */
> > +       arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
> > +       return cmdq_task_append_command(task, CMDQ_CODE_WFE,
> > +                       cmdq_event_value[event], arg_b);
> > +}
> > +EXPORT_SYMBOL(cmdq_task_wfe);
> > +
> > +int cmdq_task_clear_event(struct cmdq_task *task, enum cmdq_event event)
> > +{
> > +       if (event >= CMDQ_MAX_EVENT || event < 0)
> > +               return -EINVAL;
> > +
> > +       return cmdq_task_append_command(task, CMDQ_CODE_WFE,
> > +                       cmdq_event_value[event], CMDQ_WFE_UPDATE);
> > +}
> > +EXPORT_SYMBOL(cmdq_task_clear_event);
> > +
> > +static int cmdq_task_finalize(struct cmdq_task *task)
> > +{
> > +       int err;
> > +
> > +       if (task->finalized)
> > +               return 0;
> > +
> > +       /* insert EOC and generate IRQ for each command iteration */
> > +       err = cmdq_task_append_command(task, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
> > +       if (err < 0)
> > +               return err;
> > +
> > +       /* JUMP to end */
> > +       err = cmdq_task_append_command(task, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
> > +       if (err < 0)
> > +               return err;
> > +
> > +       task->finalized = true;
> > +       return 0;
> > +}
> > +
> > +int cmdq_task_flush_async(struct cmdq_client *client, struct cmdq_task *task,
> > +                         cmdq_async_flush_cb cb, void *data)
> > +{
> > +       struct cmdq *cmdq = task->cmdq;
> > +       int err;
> > +
> > +       mutex_lock(&cmdq->task_mutex);
> > +       if (cmdq->suspended) {
> > +               dev_err(cmdq->mbox.dev, "%s is called after suspended\n",
> > +                       __func__);
> > +               mutex_unlock(&cmdq->task_mutex);
> > +               return -EPERM;
> > +       }
> > +
> > +       err = cmdq_task_finalize(task);
> > +       if (err < 0) {
> > +               mutex_unlock(&cmdq->task_mutex);
> > +               return err;
> > +       }
> > +
> > +       INIT_LIST_HEAD(&task->list_entry);
> > +       task->cb.cb = cb;
> > +       task->cb.data = data;
> > +       task->pa_base = dma_map_single(cmdq->mbox.dev, task->va_base,
> > +                                      task->cmd_buf_size, DMA_TO_DEVICE);
> > +
> > +       mbox_send_message(client->chan, task);
> > +       /* We can send next task immediately, so just call txdone. */
> > +       mbox_client_txdone(client->chan, 0);
> > +       mutex_unlock(&cmdq->task_mutex);
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL(cmdq_task_flush_async);
> > +
> > +struct cmdq_flush_completion {
> > +       struct completion cmplt;
> > +       bool err;
> > +};
> > +
> > +static void cmdq_task_flush_cb(struct cmdq_cb_data data)
> > +{
> > +       struct cmdq_flush_completion *cmplt = data.data;
> > +
> > +       cmplt->err = data.err;
> > +       complete(&cmplt->cmplt);
> > +}
> > +
> > +int cmdq_task_flush(struct cmdq_client *client, struct cmdq_task *task)
> > +{
> > +       struct cmdq_flush_completion cmplt;
> > +       int err;
> > +
> > +       init_completion(&cmplt.cmplt);
> > +       err = cmdq_task_flush_async(client, task, cmdq_task_flush_cb, &cmplt);
> > +       if (err < 0)
> > +               return err;
> > +       wait_for_completion(&cmplt.cmplt);
> > +       return cmplt.err ? -EFAULT : 0;
> > +}
> > +EXPORT_SYMBOL(cmdq_task_flush);
> > +
> > +void cmdq_mbox_free(struct cmdq_client *client)
> > +{
> > +       mbox_free_channel(client->chan);
> > +       kfree(client);
> > +}
> > +EXPORT_SYMBOL(cmdq_mbox_free);
> > +
> All these exported functions implement the protocol, so should not be
> a part of this controller driver. That should go into
> drivers/soc/mediatek/
> 
> The controller driver (mtk-cmdq.c) should implement mainly the
> mbox_chan_ops and mbox.of_xlate.
> 

I can do that, but I would like to confirm with Matthias in advance.

[...]
> > +       cmdq->irq = irq_of_parse_and_map(node, 0);
> >
> why not,  cmdq->irq = platform_get_irq(pdev, 0);

Will do

[...]
> > +static struct platform_driver cmdq_drv = {
> > +       .probe = cmdq_probe,
> > +       .remove = cmdq_remove,
> > +       .driver = {
> > +               .name = "mtk_cmdq",
> > +               .owner = THIS_MODULE,
> >
> please remove the unnecessary .owner field.

Will do

> > +               .pm = &cmdq_pm_ops,
> > +               .of_match_table = cmdq_of_ids,
> > +       }
> > +};
> > +
> > +builtin_platform_driver(cmdq_drv);
> > diff --git a/include/linux/mailbox/mtk-cmdq.h b/include/linux/mailbox/mtk-cmdq.h
> > new file mode 100644
> > index 0000000..c3c924d
> > --- /dev/null
> > +++ b/include/linux/mailbox/mtk-cmdq.h
> >
> The api implemented is Mediateck proprietary, so I think it should be
> include/linux/soc/mediatek/cmdq.h
> 
> 
> > @@ -0,0 +1,180 @@
> > +/*
> > + * Copyright (c) 2015 MediaTek Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#ifndef __MTK_CMDQ_H__
> > +#define __MTK_CMDQ_H__
> > +
> > +#include <linux/mailbox_client.h>
> > +#include <linux/mailbox_controller.h>
> >
> Clients should not need to include mailbox_controller.h

This is because client needs to know controller's dev.

Please see my CMDQ v13.
http://www.spinics.net/lists/kernel/msg2327867.html
I add mailbox_controller.h for client to get controller's dev,
so I can remove a node reference in device tree.

Should I revert the modification of CMDQ v13?

> > +#include <linux/platform_device.h>
> > +#include <linux/types.h>
> > +
> > +/* display events in command queue(CMDQ) */
> > +enum cmdq_event {
> > +       /* Display start of frame(SOF) events */
> > +       CMDQ_EVENT_DISP_OVL0_SOF,
> >
> you may want to explicitly initialise the first element.

Will do

> > +       CMDQ_EVENT_DISP_OVL1_SOF,
> > +       CMDQ_EVENT_DISP_RDMA0_SOF,
> > +       CMDQ_EVENT_DISP_RDMA1_SOF,
> > +       CMDQ_EVENT_DISP_RDMA2_SOF,
> > +       CMDQ_EVENT_DISP_WDMA0_SOF,
> > +       CMDQ_EVENT_DISP_WDMA1_SOF,
> > +       /* Display end of frame(EOF) events */
> > +       CMDQ_EVENT_DISP_OVL0_EOF,
> > +       CMDQ_EVENT_DISP_OVL1_EOF,
> > +       CMDQ_EVENT_DISP_RDMA0_EOF,
> > +       CMDQ_EVENT_DISP_RDMA1_EOF,
> > +       CMDQ_EVENT_DISP_RDMA2_EOF,
> > +       CMDQ_EVENT_DISP_WDMA0_EOF,
> > +       CMDQ_EVENT_DISP_WDMA1_EOF,
> > +       /* Mutex end of frame(EOF) events */
> > +       CMDQ_EVENT_MUTEX0_STREAM_EOF,
> > +       CMDQ_EVENT_MUTEX1_STREAM_EOF,
> > +       CMDQ_EVENT_MUTEX2_STREAM_EOF,
> > +       CMDQ_EVENT_MUTEX3_STREAM_EOF,
> > +       CMDQ_EVENT_MUTEX4_STREAM_EOF,
> > +       /* Display underrun events */
> > +       CMDQ_EVENT_DISP_RDMA0_UNDERRUN,
> > +       CMDQ_EVENT_DISP_RDMA1_UNDERRUN,
> > +       CMDQ_EVENT_DISP_RDMA2_UNDERRUN,
> > +       /* Keep this at the end */
> > +       CMDQ_MAX_EVENT,
> > +};
> > +

Thanks,
HS


Hi Matthias,

Do you agree with Jassi's comments about moving parts of code back to
soc/mediatek/ ?
If I do it, the part in soc/mediatek/ will be similar to a library.
Could you tell me a good way to handle this situation?

Thanks,
HS
