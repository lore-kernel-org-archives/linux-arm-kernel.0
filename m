From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 7 Jul 2016 16:17:50 +0800
Subject: [PATCH V2 05/10] firmware: tegra: add BPMP support
In-Reply-To: <CAAVeFuKvp4d=RoPZGGLmhqXs1oHZPrEOxTJd_b6b7-rHq_mqqg@mail.gmail.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-6-josephl@nvidia.com>
 <CAAVeFuKvp4d=RoPZGGLmhqXs1oHZPrEOxTJd_b6b7-rHq_mqqg@mail.gmail.com>
Message-ID: <577E102E.8070602@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2016 07:39 PM, Alexandre Courbot wrote:
> Sorry, I will probably need to do several passes on this one to
> understand everything, but here is what I can say after a first look:
>
> On Tue, Jul 5, 2016 at 6:04 PM, Joseph Lo <josephl@nvidia.com> wrote:
>> The Tegra BPMP (Boot and Power Management Processor) is designed for the
>> booting process handling, offloading the power management tasks and
>> some system control services from the CPU. It can be clock, DVFS,
>> thermal/EDP, power gating operation and system suspend/resume handling.
>> So the CPU and the drivers of these modules can base on the service that
>> the BPMP firmware driver provided to signal the event for the specific PM
>> action to BPMP and receive the status update from BPMP.
>>
>> Comparing to the ARM SCPI, the service provided by BPMP is message-based
>> communication but not method-based. The BPMP firmware driver provides the
>> send/receive service for the users, when the user concerns the response
>> time. If the user needs to get the event or update from the firmware, it
>> can request the MRQ service as well. The user needs to take care of the
>> message format, which we call BPMP ABI.
>>
>> The BPMP ABI defines the message format for different modules or usages.
>> For example, the clock operation needs an MRQ service code called
>> MRQ_CLK with specific message format which includes different sub
>> commands for various clock operations. This is the message format that
>> BPMP can recognize.
>>
>> So the user needs two things to initiate IPC between BPMP. Get the
>> service from the bpmp_ops structure and maintain the message format as
>> the BPMP ABI defined.
>>
>> Based-on-the-work-by:
>> Sivaram Nair <sivaramn@nvidia.com>
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>> Changes in V2:
>> - None
>> ---
>>   drivers/firmware/tegra/Kconfig  |   12 +
>>   drivers/firmware/tegra/Makefile |    1 +
>>   drivers/firmware/tegra/bpmp.c   |  713 +++++++++++++++++
>>   include/soc/tegra/bpmp.h        |   29 +
>>   include/soc/tegra/bpmp_abi.h    | 1601 +++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 2356 insertions(+)
>>   create mode 100644 drivers/firmware/tegra/bpmp.c
>>   create mode 100644 include/soc/tegra/bpmp.h
>>   create mode 100644 include/soc/tegra/bpmp_abi.h
>>
>> diff --git a/drivers/firmware/tegra/Kconfig b/drivers/firmware/tegra/Kconfig
>> index 1fa3e4e136a5..ff2730d5c468 100644
>> --- a/drivers/firmware/tegra/Kconfig
>> +++ b/drivers/firmware/tegra/Kconfig
>> @@ -10,4 +10,16 @@ config TEGRA_IVC
>>            keeps the content is synchronization between host CPU and remote
>>            processors.
>>
>> +config TEGRA_BPMP
>> +       bool "Tegra BPMP driver"
>> +       depends on ARCH_TEGRA && TEGRA_HSP_MBOX && TEGRA_IVC
>> +       help
>> +         BPMP (Boot and Power Management Processor) is designed to off-loading
>
> s/off-loading/off-load
>
>> +         the PM functions which include clock/DVFS/thermal/power from the CPU.
>> +         It needs HSP as the HW synchronization and notification module and
>> +         IVC module as the message communication protocol.
>> +
>> +         This driver manages the IPC interface between host CPU and the
>> +         firmware running on BPMP.
>> +
>>   endmenu
>> diff --git a/drivers/firmware/tegra/Makefile b/drivers/firmware/tegra/Makefile
>> index 92e2153e8173..e34a2f79e1ad 100644
>> --- a/drivers/firmware/tegra/Makefile
>> +++ b/drivers/firmware/tegra/Makefile
>> @@ -1 +1,2 @@
>> +obj-$(CONFIG_TEGRA_BPMP)       += bpmp.o
>>   obj-$(CONFIG_TEGRA_IVC)                += ivc.o
>> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
>> new file mode 100644
>> index 000000000000..24fda626610e
>> --- /dev/null
>> +++ b/drivers/firmware/tegra/bpmp.c
>> @@ -0,0 +1,713 @@
>> +/*
>> + * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + */
>> +
>> +#include <linux/mailbox_client.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/semaphore.h>
>> +
>> +#include <soc/tegra/bpmp.h>
>> +#include <soc/tegra/bpmp_abi.h>
>> +#include <soc/tegra/ivc.h>
>> +
>> +#define BPMP_MSG_SZ            128
>> +#define BPMP_MSG_DATA_SZ       120
>> +
>> +#define __MRQ_ATTRS            0xff000000
>> +#define __MRQ_INDEX(id)                ((id) & ~__MRQ_ATTRS)
>> +
>> +#define DO_ACK                 BIT(0)
>> +#define RING_DOORBELL          BIT(1)
>> +
>> +struct tegra_bpmp_soc_data {
>> +       u32 ch_index;           /* channel index */
>> +       u32 thread_ch_index;    /* thread channel index */
>> +       u32 cpu_rx_ch_index;    /* CPU Rx channel index */
>> +       u32 nr_ch;              /* number of total channels */
>> +       u32 nr_thread_ch;       /* number of thread channels */
>> +       u32 ch_timeout;         /* channel timeout */
>> +       u32 thread_ch_timeout;  /* thread channel timeout */
>> +};
>
> With just these comments it is not clear what everything in this
> structure does. Maybe a file-level comment explaining how BPMP
> basically works and what the different channels are allocated to would
> help understanding the code.

We have two kinds of TX channels (channel & thread channel above) for 
the BPMP clients (clock, thermal, reset, power mgmt control, etc.) to use.

The channel means an atomic channel that could be used when the client 
needs the response immediately. e.g. setting clock rate, re-parent the 
clock source. Each CPUs have it's own atomic for the usage. The client 
can acquire one of them, and the ch_index means the first channel they 
are able to use in the channel array.

The response of thread channel can be postponed later. And the client 
allows getting the response after BPMP finished the service and response 
to them by IRQ. The thread_ch_index means the same the first  channel 
that the clients are available to use.

And the CPU RX channel is designed for the client to register some 
specific services (We call MRQ in the bpmp_abi.) listen to some update 
from the BPMP firmware.

Because we might have different numbers of these channels, using this 
structure as the bpmp_soc_data to get different configuration according 
to different SoC.

>
>> +
>> +struct channel_info {
>> +       u32 tch_free;
>> +       u32 tch_to_complete;
>> +       struct semaphore tch_sem;
>> +};
>> +
>> +struct mb_data {
>> +       s32 code;
>> +       s32 flags;
>> +       u8 data[BPMP_MSG_DATA_SZ];
>> +} __packed;
>> +
>> +struct channel_data {
>> +       struct mb_data *ib;
>> +       struct mb_data *ob;
>> +};
>> +
>> +struct mrq {
>> +       struct list_head list;
>> +       u32 mrq_code;
>> +       bpmp_mrq_handler handler;
>> +       void *data;
>> +};
>> +
>> +struct tegra_bpmp {
>> +       struct device *dev;
>> +       const struct tegra_bpmp_soc_data *soc_data;
>> +       void __iomem *tx_base;
>> +       void __iomem *rx_base;
>> +       struct mbox_client cl;
>> +       struct mbox_chan *chan;
>> +       struct ivc *ivc_channels;
>> +       struct channel_data *ch_area;
>> +       struct channel_info ch_info;
>> +       struct completion *ch_completion;
>> +       struct list_head mrq_list;
>> +       struct tegra_bpmp_ops *ops;
>> +       spinlock_t lock;
>> +       bool init_done;
>> +};
>> +
>> +static struct tegra_bpmp *bpmp;
>
> static? Ok, we only need one... for now. How about a private member in
> your ivc structure that allows you to retrieve the bpmp and going
> dynamic? This will require an extra argument in many functions, but is
> cleaner design IMHO.

IVC is designed as a generic IPC protocol among different modules (We 
have not introduced some other usages of the IVC right now.). Maybe 
don't churn some other stuff into IVC is better.

>
>> +
>> +static int bpmp_get_thread_ch(int idx)
>> +{
>> +       return bpmp->soc_data->thread_ch_index + idx;
>> +}
>> +
>> +static int bpmp_get_thread_ch_index(int ch)
>> +{
>> +       if (ch < bpmp->soc_data->thread_ch_index ||
>> +           ch >= bpmp->soc_data->cpu_rx_ch_index)
>
> Shouldn't that be ch >= bpmp->soc_data->cpu_rx_ch_index +
> bpmp->soc_data->nr_thread_ch?
>
> Either rx_ch_index indicates the upper bound of the threaded channels,
> and in that case you don't need tegra_bpmp_soc_data::nr_thread_ch, or
> it can be anywhere else and you should use the correct member.

According the to the table below, we have 14 channels.
atomic ch: 0 ~ 5, 6 chanls
thread ch: 6 ~ 17, 7 chanls
CPU RX ch: 13 ~ 14, 2 chanls

+static const struct tegra_bpmp_soc_data soc_data_tegra186 = {
+	.ch_index = 0,
+	.thread_ch_index = 6,
+	.cpu_rx_ch_index = 13,
+	.nr_ch = 14,
+	.nr_thread_ch = 7,
+	.ch_timeout = 60 * USEC_PER_SEC,
+	.thread_ch_timeout = 600 * USEC_PER_SEC,
+};

We use the index to check channel violation and nr_thread_ch for other 
usage to avoid redundant channel number calculation elsewhere.

>
>> +               return -1;
>> +       return ch - bpmp->soc_data->thread_ch_index;
>> +}
>> +
>> +static int bpmp_get_ob_channel(void)
>> +{
>> +       return smp_processor_id() + bpmp->soc_data->ch_index;
>> +}
>> +
>> +static struct completion *bpmp_get_completion_obj(int ch)
>> +{
>> +       int i = bpmp_get_thread_ch_index(ch);
>> +
>> +       return i < 0 ? NULL : bpmp->ch_completion + i;
>> +}
>> +
>> +static int bpmp_valid_txfer(void *ob_data, int ob_sz, void *ib_data, int ib_sz)
>> +{
>> +       return ob_sz >= 0 && ob_sz <= BPMP_MSG_DATA_SZ &&
>> +              ib_sz >= 0 && ib_sz <= BPMP_MSG_DATA_SZ &&
>> +              (!ob_sz || ob_data) && (!ib_sz || ib_data);
>> +}
>> +
>> +static bool bpmp_master_acked(int ch)
>> +{
>> +       struct ivc *ivc_chan;
>> +       void *frame;
>> +       bool ready;
>> +
>> +       ivc_chan = bpmp->ivc_channels + ch;
>> +       frame = tegra_ivc_read_get_next_frame(ivc_chan);
>> +       ready = !IS_ERR_OR_NULL(frame);
>> +       bpmp->ch_area[ch].ib = ready ? frame : NULL;
>> +
>> +       return ready;
>> +}
>> +
>> +static int bpmp_wait_ack(int ch)
>> +{
>> +       ktime_t t;
>> +
>> +       t = ns_to_ktime(local_clock());
>> +
>> +       do {
>> +               if (bpmp_master_acked(ch))
>> +                       return 0;
>> +       } while (ktime_us_delta(ns_to_ktime(local_clock()), t) <
>> +                bpmp->soc_data->ch_timeout);
>> +
>> +       return -ETIMEDOUT;
>> +}
>> +
>> +static bool bpmp_master_free(int ch)
>> +{
>> +       struct ivc *ivc_chan;
>> +       void *frame;
>> +       bool ready;
>> +
>> +       ivc_chan = bpmp->ivc_channels + ch;
>> +       frame = tegra_ivc_write_get_next_frame(ivc_chan);
>> +       ready = !IS_ERR_OR_NULL(frame);
>> +       bpmp->ch_area[ch].ob = ready ? frame : NULL;
>> +
>> +       return ready;
>> +}
>> +
>> +static int bpmp_wait_master_free(int ch)
>> +{
>> +       ktime_t t;
>> +
>> +       t = ns_to_ktime(local_clock());
>> +
>> +       do {
>> +               if (bpmp_master_free(ch))
>> +                       return 0;
>> +       } while (ktime_us_delta(ns_to_ktime(local_clock()), t)
>> +                < bpmp->soc_data->ch_timeout);
>> +
>> +       return -ETIMEDOUT;
>> +}
>> +
>> +static int __read_ch(int ch, void *data, int sz)
>> +{
>> +       struct ivc *ivc_chan;
>> +       struct mb_data *p;
>> +
>> +       ivc_chan = bpmp->ivc_channels + ch;
>> +       p = bpmp->ch_area[ch].ib;
>> +       if (data)
>> +               memcpy_fromio(data, p->data, sz);
>> +
>> +       return tegra_ivc_read_advance(ivc_chan);
>> +}
>> +
>> +static int bpmp_read_ch(int ch, void *data, int sz)
>> +{
>> +       unsigned long flags;
>> +       int i, ret;
>> +
>> +       i = bpmp_get_thread_ch_index(ch);
>
> i is not a very good name for this variable.
> Also note that bpmp_get_thread_ch_index() can return -1, this case is
> not handled.
Okay, will fix this.

>
>> +
>> +       spin_lock_irqsave(&bpmp->lock, flags);
>> +       ret = __read_ch(ch, data, sz);
>> +       bpmp->ch_info.tch_free |= (1 << i);
>> +       spin_unlock_irqrestore(&bpmp->lock, flags);
>> +
>> +       up(&bpmp->ch_info.tch_sem);
>> +
>> +       return ret;
>> +}
>> +
>> +static int __write_ch(int ch, int mrq_code, int flags, void *data, int sz)
>> +{
>> +       struct ivc *ivc_chan;
>> +       struct mb_data *p;
>> +
>> +       ivc_chan = bpmp->ivc_channels + ch;
>> +       p = bpmp->ch_area[ch].ob;
>> +
>> +       p->code = mrq_code;
>> +       p->flags = flags;
>> +       if (data)
>> +               memcpy_toio(p->data, data, sz);
>> +
>> +       return tegra_ivc_write_advance(ivc_chan);
>> +}
>> +
>> +static int bpmp_write_threaded_ch(int *ch, int mrq_code, void *data, int sz)
>> +{
>> +       unsigned long flags;
>> +       int ret, i;
>> +
>> +       ret = down_timeout(&bpmp->ch_info.tch_sem,
>> +                          usecs_to_jiffies(bpmp->soc_data->thread_ch_timeout));
>> +       if (ret)
>> +               return ret;
>> +
>> +       spin_lock_irqsave(&bpmp->lock, flags);
>> +
>> +       i = __ffs(bpmp->ch_info.tch_free);
>> +       *ch = bpmp_get_thread_ch(i);
>> +       ret = bpmp_master_free(*ch) ? 0 : -EFAULT;
>> +       if (!ret) {
>> +               bpmp->ch_info.tch_free &= ~(1 << i);
>> +               __write_ch(*ch, mrq_code, DO_ACK | RING_DOORBELL, data, sz);
>> +               bpmp->ch_info.tch_to_complete |= (1 << *ch);
>> +       }
>> +
>> +       spin_unlock_irqrestore(&bpmp->lock, flags);
>> +
>> +       return ret;
>> +}
>> +
>> +static int bpmp_write_ch(int ch, int mrq_code, int flags, void *data, int sz)
>> +{
>> +       int ret;
>> +
>> +       ret = bpmp_wait_master_free(ch);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return __write_ch(ch, mrq_code, flags, data, sz);
>> +}
>> +
>> +static int bpmp_send_receive_atomic(int mrq_code, void *ob_data, int ob_sz,
>> +                                   void *ib_data, int ib_sz)
>> +{
>> +       int ch, ret;
>> +
>> +       if (WARN_ON(!irqs_disabled()))
>> +               return -EPERM;
>> +
>> +       if (!bpmp_valid_txfer(ob_data, ob_sz, ib_data, ib_sz))
>> +               return -EINVAL;
>> +
>> +       if (!bpmp->init_done)
>> +               return -ENODEV;
>> +
>> +       ch = bpmp_get_ob_channel();
>> +       ret = bpmp_write_ch(ch, mrq_code, DO_ACK, ob_data, ob_sz);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = mbox_send_message(bpmp->chan, NULL);
>> +       if (ret < 0)
>> +               return ret;
>> +       mbox_client_txdone(bpmp->chan, 0);
>> +
>> +       ret = bpmp_wait_ack(ch);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return __read_ch(ch, ib_data, ib_sz);
>> +}
>> +
>> +static int bpmp_send_receive(int mrq_code, void *ob_data, int ob_sz,
>> +                            void *ib_data, int ib_sz)
>> +{
>> +       struct completion *comp_obj;
>> +       unsigned long timeout;
>> +       int ch, ret;
>> +
>> +       if (WARN_ON(irqs_disabled()))
>> +               return -EPERM;
>> +
>> +       if (!bpmp_valid_txfer(ob_data, ob_sz, ib_data, ib_sz))
>> +               return -EINVAL;
>> +
>> +       if (!bpmp->init_done)
>> +               return -ENODEV;
>> +
>> +       ret = bpmp_write_threaded_ch(&ch, mrq_code, ob_data, ob_sz);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = mbox_send_message(bpmp->chan, NULL);
>> +       if (ret < 0)
>> +               return ret;
>> +       mbox_client_txdone(bpmp->chan, 0);
>> +
>> +       comp_obj = bpmp_get_completion_obj(ch);
>> +       timeout = usecs_to_jiffies(bpmp->soc_data->thread_ch_timeout);
>> +       if (!wait_for_completion_timeout(comp_obj, timeout))
>> +               return -ETIMEDOUT;
>> +
>> +       return bpmp_read_ch(ch, ib_data, ib_sz);
>> +}
>> +
>> +static struct mrq *bpmp_find_mrq(u32 mrq_code)
>> +{
>> +       struct mrq *mrq;
>> +
>> +       list_for_each_entry(mrq, &bpmp->mrq_list, list) {
>> +               if (mrq_code == mrq->mrq_code)
>> +                       return mrq;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static void bpmp_mrq_return_data(int ch, int code, void *data, int sz)
>> +{
>> +       int flags = bpmp->ch_area[ch].ib->flags;
>> +       struct ivc *ivc_chan;
>> +       struct mb_data *frame;
>> +       int ret;
>> +
>> +       if (WARN_ON(sz > BPMP_MSG_DATA_SZ))
>> +               return;
>> +
>> +       ivc_chan = bpmp->ivc_channels + ch;
>> +       ret = tegra_ivc_read_advance(ivc_chan);
>> +       WARN_ON(ret);
>> +
>> +       if (!(flags & DO_ACK))
>> +               return;
>> +
>> +       frame = tegra_ivc_write_get_next_frame(ivc_chan);
>> +       if (IS_ERR_OR_NULL(frame)) {
>> +               WARN_ON(1);
>> +               return;
>> +       }
>> +
>> +       frame->code = code;
>> +       if (data != NULL)
>> +               memcpy_toio(frame->data, data, sz);
>> +       ret = tegra_ivc_write_advance(ivc_chan);
>> +       WARN_ON(ret);
>> +
>> +       if (flags & RING_DOORBELL) {
>> +               ret = mbox_send_message(bpmp->chan, NULL);
>> +               if (ret < 0) {
>> +                       WARN_ON(1);
>> +                       return;
>> +               }
>> +               mbox_client_txdone(bpmp->chan, 0);
>> +       }
>> +}
>> +
>> +static void bpmp_mail_return(int ch, int ret_code, int val)
>> +{
>> +       bpmp_mrq_return_data(ch, ret_code, &val, sizeof(val));
>> +}
>> +
>> +static void bpmp_handle_mrq(int mrq_code, int ch)
>> +{
>> +       struct mrq *mrq;
>> +
>> +       spin_lock(&bpmp->lock);
>> +
>> +       mrq = bpmp_find_mrq(mrq_code);
>> +       if (!mrq) {
>> +               spin_unlock(&bpmp->lock);
>> +               bpmp_mail_return(ch, -EINVAL, 0);
>> +               return;
>> +       }
>> +
>> +       mrq->handler(mrq_code, mrq->data, ch);
>> +
>> +       spin_unlock(&bpmp->lock);
>> +}
>> +
>> +static int bpmp_request_mrq(int mrq_code, bpmp_mrq_handler handler, void *data)
>> +{
>> +       struct mrq *mrq;
>> +       unsigned long flags;
>> +
>> +       if (!handler)
>> +               return -EINVAL;
>> +
>> +       mrq = devm_kzalloc(bpmp->dev, sizeof(*mrq), GFP_KERNEL);
>> +       if (!mrq)
>> +               return -ENOMEM;
>> +
>> +       spin_lock_irqsave(&bpmp->lock, flags);
>> +
>> +       mrq->mrq_code = __MRQ_INDEX(mrq_code);
>> +       mrq->handler = handler;
>> +       mrq->data = data;
>> +       list_add(&mrq->list, &bpmp->mrq_list);
>> +
>> +       spin_unlock_irqrestore(&bpmp->lock, flags);
>> +
>> +       return 0;
>> +}
>> +
>> +static void bpmp_mrq_handle_ping(int mrq_code, void *data, int ch)
>> +{
>> +       int challenge;
>> +       int reply;
>> +
>> +       challenge = *(int *)bpmp->ch_area[ch].ib->data;
>> +       reply = challenge << (smp_processor_id() + 1);
>> +       bpmp_mail_return(ch, 0, reply);
>> +}
>> +
>> +static int bpmp_mailman_init(void)
>> +{
>> +       return bpmp_request_mrq(MRQ_PING, bpmp_mrq_handle_ping, NULL);
>> +}
>> +
>> +static int bpmp_ping(void)
>> +{
>> +       unsigned long flags;
>> +       ktime_t t;
>> +       int challenge = 1;
>
> Mmmm, shouldn't use a mrq_ping_request instead of an parameter which
> size may vary depending on the architecture? On a 64-bit big endian
> architecture, your messages would be corrupted.

Clarify one thig first. The mrq_ping_request and mrq_handle_ping above 
are used for the ping form BPMP to CPU. Like I said above, it's among 
CPU RX channel to get some information from BPMP firmware.

Here is the ping request from CPU to BPMP to make sure we can IPC with 
BPMP during the probe stage.

About the endian issue, I think we don't consider that in the message 
format right now. So I think we only support little endian for the IPC 
messages right now.

>
>> +       int reply = 0;
>
> And this should probably be a mrq_ping_response. These remarks may
> also apply to bpmp_mrq_handle_ping().
That is for receiving the ping request from BPMP.

>
>> +       int ret;
>> +
>> +       t = ktime_get();
>> +       local_irq_save(flags);
>> +       ret = bpmp_send_receive_atomic(MRQ_PING, &challenge, sizeof(challenge),
>> +                                      &reply, sizeof(reply));
>> +       local_irq_restore(flags);
>> +       t = ktime_sub(ktime_get(), t);
>> +
>> +       if (!ret)
>> +               dev_info(bpmp->dev,
>> +                        "ping ok: challenge: %d, reply: %d, time: %lld\n",
>> +                        challenge, reply, ktime_to_us(t));
>> +
>> +       return ret;
>> +}
>> +
>> +static int bpmp_get_fwtag(void)
>> +{
>> +       unsigned long flags;
>> +       void *vaddr;
>> +       dma_addr_t paddr;
>> +       u32 addr;
>
> Here also we should use a mrq_query_tag_request.
The is one-way request from CPU to BPMP. So we don't request an MRQ for 
that.

>
>> +       int ret;
>> +
>> +       vaddr = dma_alloc_coherent(bpmp->dev, BPMP_MSG_DATA_SZ, &paddr,
>> +                                  GFP_KERNEL);
>
> dma_addr_t may be 64 bit here, and you may get an address higher than
> the 32 bits allowed by mrq_query_tag_request! I guess you want to add
> GFP_DMA32 as flag to your call to dma_alloc_coherent.
BPMP should able to handle the address above 32 bits, but I am not sure 
does it configure to support that?

Will fix this.

>
>> +       if (!vaddr)
>> +               return -ENOMEM;
>> +       addr = paddr;
>> +
>> +       local_irq_save(flags);
>> +       ret = bpmp_send_receive_atomic(MRQ_QUERY_TAG, &addr, sizeof(addr),
>> +                                      NULL, 0);
>> +       local_irq_restore(flags);
>> +
>> +       if (!ret)
>> +               dev_info(bpmp->dev, "fwtag: %s\n", (char *)vaddr);
>> +
>> +       dma_free_coherent(bpmp->dev, BPMP_MSG_DATA_SZ, vaddr, paddr);
>> +
>> +       return ret;
>> +}
>> +
>> +static void bpmp_signal_thread(int ch)
>> +{
>> +       int flags = bpmp->ch_area[ch].ob->flags;
>> +       struct completion *comp_obj;
>> +
>> +       if (!(flags & RING_DOORBELL))
>> +               return;
>> +
>> +       comp_obj = bpmp_get_completion_obj(ch);
>> +       if (!comp_obj) {
>> +               WARN_ON(1);
>> +               return;
>> +       }
>> +
>> +       complete(comp_obj);
>> +}
>> +
>> +static void bpmp_handle_rx(struct mbox_client *cl, void *data)
>> +{
>> +       int i, rx_ch;
>> +
>> +       rx_ch = bpmp->soc_data->cpu_rx_ch_index;
>> +
>> +       if (bpmp_master_acked(rx_ch))
>> +               bpmp_handle_mrq(bpmp->ch_area[rx_ch].ib->code, rx_ch);
>> +
>> +       spin_lock(&bpmp->lock);
>> +
>> +       for (i = 0; i < bpmp->soc_data->nr_thread_ch &&
>> +                       bpmp->ch_info.tch_to_complete; i++) {
>> +               int ch = bpmp_get_thread_ch(i);
>> +
>> +               if ((bpmp->ch_info.tch_to_complete & (1 << ch)) &&
>> +                   bpmp_master_acked(ch)) {
>> +                       bpmp->ch_info.tch_to_complete &= ~(1 << ch);
>> +                       bpmp_signal_thread(ch);
>> +               }
>> +       }
>> +
>> +       spin_unlock(&bpmp->lock);
>> +}
>> +
>> +static void bpmp_ivc_notify(struct ivc *ivc)
>> +{
>> +       int ret;
>> +
>> +       ret = mbox_send_message(bpmp->chan, NULL);
>> +       if (ret < 0)
>> +               return;
>> +
>> +       mbox_send_message(bpmp->chan, NULL);
>
> Why the second call to mbox_send_message? May to useful to add a
> comment explaining it.
Ah!! It should be mbox_client_txdone(). Good catch.

>
>> +}
>> +
>> +static int bpmp_msg_chan_init(int ch)
>> +{
>> +       struct ivc *ivc_chan;
>> +       u32 hdr_sz, msg_sz, que_sz;
>> +       uintptr_t rx_base, tx_base;
>> +       int ret;
>> +
>> +       msg_sz = tegra_ivc_align(BPMP_MSG_SZ);
>> +       hdr_sz = tegra_ivc_total_queue_size(0);
>
> I believe hdr_sz is never used?
You are right. Should fix this.

>
>> +       que_sz = tegra_ivc_total_queue_size(msg_sz);
>> +
>> +       rx_base =  (uintptr_t)(bpmp->rx_base + que_sz * ch);
>> +       tx_base =  (uintptr_t)(bpmp->tx_base + que_sz * ch);
>> +
>> +       ivc_chan = bpmp->ivc_channels + ch;
>> +       ret = tegra_ivc_init(ivc_chan, rx_base, DMA_ERROR_CODE, tx_base,
>> +                            DMA_ERROR_CODE, 1, msg_sz, bpmp->dev,
>> +                            bpmp_ivc_notify);
>> +       if (ret) {
>> +               dev_err(bpmp->dev, "%s fail: ch %d returned %d\n",
>> +                       __func__, ch, ret);
>> +               return ret;
>> +       }
>> +
>> +       /* reset the channel state */
>> +       tegra_ivc_channel_reset(ivc_chan);
>> +
>> +       /* sync the channel state with BPMP */
>> +       while (tegra_ivc_channel_notified(ivc_chan))
>> +               ;
>> +
>> +       return 0;
>> +}
>> +
>> +struct tegra_bpmp_ops *tegra_bpmp_get_ops(void)
>> +{
>> +       if (bpmp->init_done && bpmp->ops)
>> +               return bpmp->ops;
>> +       return NULL;
>> +}
>> +EXPORT_SYMBOL(tegra_bpmp_get_ops);
>> +
>> +static struct tegra_bpmp_ops bpmp_ops = {
>> +       .send_receive = bpmp_send_receive,
>> +       .send_receive_atomic = bpmp_send_receive_atomic,
>> +       .request_mrq = bpmp_request_mrq,
>> +       .mrq_return = bpmp_mail_return,
>> +};
>> +
>> +static const struct tegra_bpmp_soc_data soc_data_tegra186 = {
>> +       .ch_index = 0,
>> +       .thread_ch_index = 6,
>> +       .cpu_rx_ch_index = 13,
>> +       .nr_ch = 14,
>> +       .nr_thread_ch = 7,
>> +       .ch_timeout = 60 * USEC_PER_SEC,
>> +       .thread_ch_timeout = 600 * USEC_PER_SEC,
>> +};
>> +
>> +static const struct of_device_id tegra_bpmp_match[] = {
>> +       { .compatible = "nvidia,tegra186-bpmp", .data = &soc_data_tegra186 },
>> +       { }
>> +};
>> +
>> +static int tegra_bpmp_probe(struct platform_device *pdev)
>> +{
>> +       const struct of_device_id *match;
>> +       struct resource shmem_res;
>> +       struct device_node *shmem_np;
>> +       int i, ret;
>> +
>> +       bpmp = devm_kzalloc(&pdev->dev, sizeof(*bpmp), GFP_KERNEL);
>> +       if (!bpmp)
>> +               return -ENOMEM;
>> +       bpmp->dev = &pdev->dev;
>> +
>> +       match = of_match_device(tegra_bpmp_match, &pdev->dev);
>> +       if (!match)
>> +               return -EINVAL;
>> +       bpmp->soc_data = match->data;
>> +
>> +       shmem_np = of_parse_phandle(pdev->dev.of_node, "shmem", 0);
>> +       of_address_to_resource(shmem_np, 0, &shmem_res);
>
> Maybe check return value for these two calls?
>
>> +       bpmp->tx_base = devm_ioremap_resource(&pdev->dev, &shmem_res);
>> +       if (IS_ERR(bpmp->tx_base))
>> +               return PTR_ERR(bpmp->tx_base);
>> +
>> +       shmem_np = of_parse_phandle(pdev->dev.of_node, "shmem", 1);
>> +       of_address_to_resource(shmem_np, 0, &shmem_res);
>
> And here too.
Okay, will fix.

Thanks,
-Joseph

>
>> +       bpmp->rx_base = devm_ioremap_resource(&pdev->dev, &shmem_res);
>> +       if (IS_ERR(bpmp->rx_base))
>> +               return PTR_ERR(bpmp->rx_base);
>> +
>> +       bpmp->ivc_channels = devm_kcalloc(&pdev->dev, bpmp->soc_data->nr_ch,
>> +                                         sizeof(*bpmp->ivc_channels),
>> +                                         GFP_KERNEL);
>> +       if (!bpmp->ivc_channels)
>> +               return -ENOMEM;
>> +
>> +       bpmp->ch_area = devm_kcalloc(&pdev->dev, bpmp->soc_data->nr_ch,
>> +                                    sizeof(*bpmp->ch_area), GFP_KERNEL);
>> +       if (!bpmp->ch_area)
>> +               return -ENOMEM;
>> +
>> +       bpmp->ch_completion = devm_kcalloc(&pdev->dev,
>> +                                          bpmp->soc_data->nr_thread_ch,
>> +                                          sizeof(*bpmp->ch_completion),
>> +                                          GFP_KERNEL);
>> +       if (!bpmp->ch_completion)
>> +               return -ENOMEM;
>> +
>> +       /* mbox registration */
>> +       bpmp->cl.dev = &pdev->dev;
>> +       bpmp->cl.rx_callback = bpmp_handle_rx;
>> +       bpmp->cl.tx_block = false;
>> +       bpmp->cl.knows_txdone = false;
>> +       bpmp->chan = mbox_request_channel(&bpmp->cl, 0);
>> +       if (IS_ERR(bpmp->chan)) {
>> +               if (PTR_ERR(bpmp->chan) != -EPROBE_DEFER)
>> +                       dev_err(&pdev->dev,
>> +                               "fail to get HSP mailbox, bpmp init fail.\n");
>> +               return PTR_ERR(bpmp->chan);
>> +       }
>> +
>> +       /* message channel initialization */
>> +       for (i = 0; i < bpmp->soc_data->nr_ch; i++) {
>> +               struct completion *comp_obj;
>> +
>> +               ret = bpmp_msg_chan_init(i);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               comp_obj = bpmp_get_completion_obj(i);
>> +               if (comp_obj)
>> +                       init_completion(comp_obj);
>> +       }
>> +
>> +       bpmp->ch_info.tch_free = (1 << bpmp->soc_data->nr_thread_ch) - 1;
>> +       sema_init(&bpmp->ch_info.tch_sem, bpmp->soc_data->nr_thread_ch);
>> +
>> +       spin_lock_init(&bpmp->lock);
>> +       INIT_LIST_HEAD(&bpmp->mrq_list);
>> +       if (bpmp_mailman_init())
>> +               return -ENODEV;
>> +
>> +       bpmp->init_done = true;
>> +
>> +       ret = bpmp_ping();
>> +       if (ret)
>> +               dev_err(&pdev->dev, "ping failed: %d\n", ret);
>> +
>> +       ret = bpmp_get_fwtag();
>> +       if (ret)
>> +               dev_err(&pdev->dev, "get fwtag failed: %d\n", ret);
>> +
>> +       /* BPMP is ready now. */
>> +       bpmp->ops = &bpmp_ops;
>> +
>> +       return 0;
>> +}
>> +
>> +static struct platform_driver tegra_bpmp_driver = {
>> +       .driver = {
>> +               .name = "tegra-bpmp",
>> +               .of_match_table = tegra_bpmp_match,
>> +       },
>> +       .probe = tegra_bpmp_probe,
>> +};
>> +
>> +static int __init tegra_bpmp_init(void)
>> +{
>> +       return platform_driver_register(&tegra_bpmp_driver);
>> +}
>> +core_initcall(tegra_bpmp_init);
>> diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
>> new file mode 100644
>> index 000000000000..aaa0ef34ad7b
>> --- /dev/null
>> +++ b/include/soc/tegra/bpmp.h
>> @@ -0,0 +1,29 @@
>> +/*
>> + * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + */
>> +
>> +#ifndef __TEGRA_BPMP_H
>> +
>> +typedef void (*bpmp_mrq_handler)(int mrq_code, void *data, int ch);
>> +
>> +struct tegra_bpmp_ops {
>> +       int (*send_receive)(int mrq_code, void *ob_data, int ob_sz,
>> +                           void *ib_data, int ib_sz);
>> +       int (*send_receive_atomic)(int mrq_code, void *ob_data, int ob_sz,
>> +                           void *ib_data, int ib_sz);
>> +       int (*request_mrq)(int mrq_code, bpmp_mrq_handler handler, void *data);
>> +       void (*mrq_return)(int ch, int ret_code, int val);
>> +};
>> +
>> +struct tegra_bpmp_ops *tegra_bpmp_get_ops(void);
>> +
>> +#endif /* __TEGRA_BPMP_H */
>> diff --git a/include/soc/tegra/bpmp_abi.h b/include/soc/tegra/bpmp_abi.h
>> new file mode 100644
>> index 000000000000..0aaef5960e29
>> --- /dev/null
>> +++ b/include/soc/tegra/bpmp_abi.h
>> @@ -0,0 +1,1601 @@
>> +/*
>> + * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef _ABI_BPMP_ABI_H_
>> +#define _ABI_BPMP_ABI_H_
>> +
>> +#ifdef LK
>> +#include <stdint.h>
>> +#endif
>> +
>> +#ifndef __ABI_PACKED
>> +#define __ABI_PACKED __attribute__((packed))
>> +#endif
>> +
>> +#ifdef NO_GCC_EXTENSIONS
>> +#define EMPTY char empty;
>> +#define EMPTY_ARRAY 1
>> +#else
>> +#define EMPTY
>> +#define EMPTY_ARRAY 0
>> +#endif
>> +
>> +#ifndef __UNION_ANON
>> +#define __UNION_ANON
>> +#endif
>> +/**
>> + * @file
>> + */
>> +
>> +
>> +/**
>> + * @defgroup MRQ MRQ Messages
>> + * @brief Messages sent to/from BPMP via IPC
>> + * @{
>> + *   @defgroup MRQ_Format Message Format
>> + *   @defgroup MRQ_Codes Message Request (MRQ) Codes
>> + *   @defgroup MRQ_Payloads Message Payloads
>> + *   @defgroup Error_Codes Error Codes
>> + * @}
>> + */
>
> ...
>
> There is a lot of stuff in this file, most of which we are not using
> now - this is ok, but unless this is a file synced from an outside
> resource maybe we should trim the structures we don't need and add
> them as we make use of them? It helps dividing the work in bite-size
> chunks.
>
> Regarding the documentation format of this file, is this valid kernel
> documentation since the adoption of Sphynx? Or is it whatever the
> origin is using?
>
