From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 18 Jul 2016 16:58:12 +0800
Subject: [PATCH V2 02/10] mailbox: tegra-hsp: Add HSP(Hardware
 Synchronization Primitives) driver
In-Reply-To: <20160707213313.GB9897@kickseed.nvidia.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-3-josephl@nvidia.com>
 <CAAVeFuK1nY2M3vU9j-D5TJwZCEj+sXRDy=W4XMTqSdsveTTQww@mail.gmail.com>
 <577CCA0A.4000203@nvidia.com>
 <CAAVeFuLHmYVt870UKPwhdqxi+dJWCskbswwKdVVntDJYkA5YTw@mail.gmail.com>
 <577DF8A7.4070209@nvidia.com> <20160707213313.GB9897@kickseed.nvidia.com>
Message-ID: <578C9A24.7090205@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2016 05:33 AM, Sivaram Nair wrote:
> On Thu, Jul 07, 2016 at 02:37:27PM +0800, Joseph Lo wrote:
>> On 07/06/2016 08:23 PM, Alexandre Courbot wrote:
>>> On Wed, Jul 6, 2016 at 6:06 PM, Joseph Lo <josephl@nvidia.com> wrote:
>>>> On 07/06/2016 03:05 PM, Alexandre Courbot wrote:
>>>>>
>>>>> On Tue, Jul 5, 2016 at 6:04 PM, Joseph Lo <josephl@nvidia.com> wrote:
>>>>>>
>>>>>> The Tegra HSP mailbox driver implements the signaling doorbell-based
>>>>>> interprocessor communication (IPC) for remote processors currently. The
>>>>>> HSP HW modules support some different features for that, which are
>>>>>> shared mailboxes, shared semaphores, arbitrated semaphores, and
>>>>>> doorbells. And there are multiple HSP HW instances on the chip. So the
>>>>>> driver is extendable to support more features for different IPC
>>>>>> requirement.
>>>>>>
>>>>>> The driver of remote processor can use it as a mailbox client and deal
>>>>>> with the IPC protocol to synchronize the data communications.
>>>>>>
>>>>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>>>>> ---
>>>>>> Changes in V2:
>>>>>> - Update the driver to support the binding changes in V2
>>>>>> - it's extendable to support multiple HSP sub-modules on the same HSP HW
>>>>>> block
>>>>>>     now.
>>>>>> ---
>>>>>>    drivers/mailbox/Kconfig     |   9 +
>>>>>>    drivers/mailbox/Makefile    |   2 +
>>>>>>    drivers/mailbox/tegra-hsp.c | 418
>>>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>>>    3 files changed, 429 insertions(+)
>>>>>>    create mode 100644 drivers/mailbox/tegra-hsp.c
>>>>>>
>>>>>> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
>>>>>> index 5305923752d2..fe584cb54720 100644
>>>>>> --- a/drivers/mailbox/Kconfig
>>>>>> +++ b/drivers/mailbox/Kconfig
>>>>>> @@ -114,6 +114,15 @@ config MAILBOX_TEST
>>>>>>             Test client to help with testing new Controller driver
>>>>>>             implementations.
>>>>>>
>>>>>> +config TEGRA_HSP_MBOX
>>>>>> +       bool "Tegra HSP(Hardware Synchronization Primitives) Driver"
>>>>>
>>>>>
>>>>> Space missing before the opening parenthesis (same in the patch title
>>>>> btw).
>>>>
>>>> Okay.
>>>>>
>>>>>
>>>>>> +       depends on ARCH_TEGRA_186_SOC
>>>>>> +       help
>>>>>> +         The Tegra HSP driver is used for the interprocessor
>>>>>> communication
>>>>>> +         between different remote processors and host processors on
>>>>>> Tegra186
>>>>>> +         and later SoCs. Say Y here if you want to have this support.
>>>>>> +         If unsure say N.
>>>>>
>>>>>
>>>>> Since this option is selected automatically by ARCH_TEGRA_186_SOC, you
>>>>> should probably drop the last 2 sentences.
>>>>
>>>> Okay.
>>>>
>>>>>
>>>>>> +
>>>>>>    config XGENE_SLIMPRO_MBOX
>>>>>>           tristate "APM SoC X-Gene SLIMpro Mailbox Controller"
>>>>>>           depends on ARCH_XGENE
>>>>>> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
>>>>>> index 0be3e742bb7d..26d8f91c7fea 100644
>>>>>> --- a/drivers/mailbox/Makefile
>>>>>> +++ b/drivers/mailbox/Makefile
>>>>>> @@ -25,3 +25,5 @@ obj-$(CONFIG_TI_MESSAGE_MANAGER) += ti-msgmgr.o
>>>>>>    obj-$(CONFIG_XGENE_SLIMPRO_MBOX) += mailbox-xgene-slimpro.o
>>>>>>
>>>>>>    obj-$(CONFIG_HI6220_MBOX)      += hi6220-mailbox.o
>>>>>> +
>>>>>> +obj-${CONFIG_TEGRA_HSP_MBOX}   += tegra-hsp.o
>>>>>> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..93c3ef58f29f
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/mailbox/tegra-hsp.c
>>>>>> @@ -0,0 +1,418 @@
>>>>>> +/*
>>>>>> + * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
>>>>>> + *
>>>>>> + * This program is free software; you can redistribute it and/or modify
>>>>>> it
>>>>>> + * under the terms and conditions of the GNU General Public License,
>>>>>> + * version 2, as published by the Free Software Foundation.
>>>>>> + *
>>>>>> + * This program is distributed in the hope it will be useful, but
>>>>>> WITHOUT
>>>>>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
>>>>>> for
>>>>>> + * more details.
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/interrupt.h>
>>>>>> +#include <linux/io.h>
>>>>>> +#include <linux/mailbox_controller.h>
>>>>>> +#include <linux/of.h>
>>>>>> +#include <linux/of_device.h>
>>>>>> +#include <linux/platform_device.h>
>>>>>> +#include <dt-bindings/mailbox/tegra186-hsp.h>
>>>>>> +
>>>>>> +#define HSP_INT_DIMENSIONING   0x380
>>>>>> +#define HSP_nSM_OFFSET         0
>>>>>> +#define HSP_nSS_OFFSET         4
>>>>>> +#define HSP_nAS_OFFSET         8
>>>>>> +#define HSP_nDB_OFFSET         12
>>>>>> +#define HSP_nSI_OFFSET         16
>>>>>
>>>>>
>>>>> Would be nice to have comments to understand what SM, SS, AS, etc.
>>>>> stand for (Shared Mailboxes, Shared Semaphores, Arbitrated Semaphores
>>>>> but you need to look at the patch description to understand that). A
>>>>> top-of-file comment explaning the necessary concepts to read this code
>>>>> would do the trick.
>>>>
>>>> Yes, will fix that.
>>>>>
>>>>>
>>>>>> +#define HSP_nINT_MASK          0xf
>>>>>> +
>>>>>> +#define HSP_DB_REG_TRIGGER     0x0
>>>>>> +#define HSP_DB_REG_ENABLE      0x4
>>>>>> +#define HSP_DB_REG_RAW         0x8
>>>>>> +#define HSP_DB_REG_PENDING     0xc
>>>>>> +
>>>>>> +#define HSP_DB_CCPLEX          1
>>>>>> +#define HSP_DB_BPMP            3
>>>>>
>>>>>
>>>>> Maybe turn this into enum and use that type for
>>>>> tegra_hsp_db_chan::db_id? Also have MAX_NUM_HSP_DB here, since it is
>>>>> related to these values?
>>>>
>>>> Okay.
>>>>
>>>>>
>>>>>> +
>>>>>> +#define MAX_NUM_HSP_CHAN 32
>>>>>> +#define MAX_NUM_HSP_DB 7
>>>>>> +
>>>>>> +#define hsp_db_offset(i, d) \
>>>>>> +       (d->base + ((1 + (d->nr_sm >> 1) + d->nr_ss + d->nr_as) << 16) +
>>>>>> \
>>>>>> +       (i) * 0x100)
>>>>>> +
>>>>>> +struct tegra_hsp_db_chan {
>>>>>> +       int master_id;
>>>>>> +       int db_id;
>>>>>> +};
>>>>>> +
>>>>>> +struct tegra_hsp_mbox_chan {
>>>>>> +       int type;
>>>>>> +       union {
>>>>>> +               struct tegra_hsp_db_chan db_chan;
>>>>>> +       };
>>>>>> +};
>>>>>> +
>>>>>> +struct tegra_hsp_mbox {
>>>>>> +       struct mbox_controller *mbox;
>>>>>> +       void __iomem *base;
>>>>>> +       void __iomem *db_base[MAX_NUM_HSP_DB];
>>>>>> +       int db_irq;
>>>>>> +       int nr_sm;
>>>>>> +       int nr_as;
>>>>>> +       int nr_ss;
>>>>>> +       int nr_db;
>>>>>> +       int nr_si;
>>>>>> +       spinlock_t lock;
>>>>>> +};
>>>>>> +
>>>>>> +static inline u32 hsp_readl(void __iomem *base, int reg)
>>>>>> +{
>>>>>> +       return readl(base + reg);
>>>>>> +}
>>>>>> +
>>>>>> +static inline void hsp_writel(void __iomem *base, int reg, u32 val)
>>>>>> +{
>>>>>> +       writel(val, base + reg);
>>>>>> +       readl(base + reg);
>>>>>> +}
>>>>>> +
>>>>>> +static int hsp_db_can_ring(void __iomem *db_base)
>>>>>> +{
>>>>>> +       u32 reg;
>>>>>> +
>>>>>> +       reg = hsp_readl(db_base, HSP_DB_REG_ENABLE);
>>>>>> +
>>>>>> +       return !!(reg & BIT(HSP_DB_MASTER_CCPLEX));
>>>>>> +}
>>>>>> +
>>>>>> +static irqreturn_t hsp_db_irq(int irq, void *p)
>>>>>> +{
>>>>>> +       struct tegra_hsp_mbox *hsp_mbox = p;
>>>>>> +       ulong val;
>>>>>> +       int master_id;
>>>>>> +
>>>>>> +       val = (ulong)hsp_readl(hsp_mbox->db_base[HSP_DB_CCPLEX],
>>>>>> +                              HSP_DB_REG_PENDING);
>>>>>> +       hsp_writel(hsp_mbox->db_base[HSP_DB_CCPLEX], HSP_DB_REG_PENDING,
>>>>>> val);
>>>>>> +
>>>>>> +       spin_lock(&hsp_mbox->lock);
>>>>>> +       for_each_set_bit(master_id, &val, MAX_NUM_HSP_CHAN) {
>>>>>> +               struct mbox_chan *chan;
>>>>>> +               struct tegra_hsp_mbox_chan *mchan;
>>>>>> +               int i;
>>>>>> +
>>>>>> +               for (i = 0; i < MAX_NUM_HSP_CHAN; i++) {
>>>>>
>>>>>
>>>>> I wonder if this could not be optimized. You are doing a double loop
>>>>> on MAX_NUM_HSP_CHAN to look for an identical master_id. Since it seems
>>>>> like the same master_id cannot be used twice (considering that the
>>>>> inner loop only processes the first match), couldn't you just select
>>>>> the free channel in of_hsp_mbox_xlate() by doing
>>>>> &mbox->chans[master_id] (and returning an error if it is already
>>>>> used), then simply getting chan as &hsp_mbox->mbox->chans[master_id]
>>>>> instead of having the inner loop below? That would remove the need for
>>>>> the second loop.
>>>>
>>>>
>>>> That was exactly what I did in the V1, which only supported one HSP
>>>> sub-module per HSP HW block. So we can just use the master_id as the mbox
>>>> channel ID.
>>>>
>>>> Meanwhile, the V2 is purposed to support multiple HSP sub-modules to be
>>>> running on the same HSP HW block. The "ID" between different modules could
>>>> be conflict. So I dropped the mechanism that used the master_id as the mbox
>>>> channel ID.
>>>>
>>>> Instead, the channel is allocated at the time, when the client is bound to
>>>> one of the HSP sub-modules. And we store the "ID" information into the
>>>> private mbox channel data, which can help us to figure out which mbox
>>>> channel should response to the interrupt.
>>>>
>>>> In the doorbell case, because all the DB clients are shared the same DB IRQ
>>>> at the CPU side. So in the ISR, we need to figure out the IRQ source, which
>>>> is the master_id that the IRQ came from. This is the outer loop. The inner
>>>> loop, we figure out which channel should response to by checking the type
>>>> and ID.
>>>>
>>>> And I think it should be pretty quick, because we only check the set bit
>>> >from the pending register. And finding the matching channel.
>>>
>>> Yeah, I am not worried about the CPU time (although in interrupt
>>> context, we always should), but rather about whether the code could be
>>> simplified.
>>>
>>> Ah, I think I get it. You want to be able to receive interrupts from
>>> the same master, but not necessarily for the doorbell function.
>>> Because of this you cannot use master_id as the index for the channel.
>>> Am I understanding correctly?
>>
>> Yes, the DB clients trigger the IRQ through the same master
>> (HSP_DB_CCPLEX) with it's master_id. We (CPU) can check the ID to
>> know who is requesting the HSP mbox service. Each ID is unique under
>> the DB module.
>>
>> But the ID could be conflict when the HSP mbox driver are working
>> with multiple HSP sub-function under the same HSP HW block. So we
>> can't just match the ID to the HSP mbox channel ID.
>
> Joseph, can you think about any other sub-function that uses the same
> master ids (& those that does not have their own irqs)? I wonder if we
> are over-engineering this. I think the hsp_db_startup() and
> hsp_db_shutdown() does not support sharing masters - _startup() by one
> followed by _shutdown() from another will mask the interrupt. If there
> is infact other potential sub-functions, I would imagine this will
> translate to other values of the tegra_hsp_mbox_chan.type than
> HSP_MBOX_TYPE_DB? If yes, then you should be able to remove need of this
> inner loop by having per-sub-function mboxes or by combining 'type' and
> 'master_id' to make single index value?
>

I will try to refactor the driver to fix the inner loop issue by 
separating the mbox channel with different HSP modules. And hook 
different sub channels for different masters.

Thanks,
-Joseph
