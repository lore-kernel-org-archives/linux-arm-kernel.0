From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 14 Feb 2017 09:30:04 +0530
Subject: [PATCH v3 3/4] dmaengine: Add Broadcom SBA RAID driver
In-Reply-To: <CAALAos-dThk-h09Yox5AN37po3OqR1oReoZPfqjZVqTqVkCxUA@mail.gmail.com>
References: <1486717628-17580-1-git-send-email-anup.patel@broadcom.com>
 <1486717628-17580-4-git-send-email-anup.patel@broadcom.com>
 <CAPcyv4hE5gDiHhfaiHDHbhA2xKa45UdzKcSxnQXK-W92sr3Z1g@mail.gmail.com>
 <CAALAos-dThk-h09Yox5AN37po3OqR1oReoZPfqjZVqTqVkCxUA@mail.gmail.com>
Message-ID: <CAALAos_m5RkjAA2BNB9d3LP_mBSe5aEjyernXV28LTSe7qfFQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 2:43 PM, Anup Patel <anup.patel@broadcom.com> wrote:
> On Fri, Feb 10, 2017 at 11:20 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> On Fri, Feb 10, 2017 at 1:07 AM, Anup Patel <anup.patel@broadcom.com> wrote:
>>> The Broadcom stream buffer accelerator (SBA) provides offloading
>>> capabilities for RAID operations. This SBA offload engine is
>>> accessible via Broadcom SoC specific ring manager.
>>>
>>> This patch adds Broadcom SBA RAID driver which provides one
>>> DMA device with RAID capabilities using one or more Broadcom
>>> SoC specific ring manager channels. The SBA RAID driver in its
>>> current shape implements memcpy, xor, and pq operations.
>>>
>>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>> ---
>>>  drivers/dma/Kconfig        |   13 +
>>>  drivers/dma/Makefile       |    1 +
>>>  drivers/dma/bcm-sba-raid.c | 1711 ++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 1725 insertions(+)
>>>  create mode 100644 drivers/dma/bcm-sba-raid.c
>>>
>>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>>> index 263495d..bf8fb84 100644
>>> --- a/drivers/dma/Kconfig
>>> +++ b/drivers/dma/Kconfig
>>> @@ -99,6 +99,19 @@ config AXI_DMAC
>>>           controller is often used in Analog Device's reference designs for FPGA
>>>           platforms.
>>>
>>> +config BCM_SBA_RAID
>>> +       tristate "Broadcom SBA RAID engine support"
>>> +       depends on (ARM64 && MAILBOX && RAID6_PQ) || COMPILE_TEST
>>> +       select DMA_ENGINE
>>> +       select DMA_ENGINE_RAID
>>> +       select ASYNC_TX_ENABLE_CHANNEL_SWITCH
>>
>> ASYNC_TX_ENABLE_CHANNEL_SWITCH violates the DMA mapping API and
>> Russell has warned it's especially problematic on ARM [1].  If you
>> need channel switching for this offload engine to be useful then you
>> need to move DMA mapping and channel switching responsibilities to MD
>> itself.
>>
>> [1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-January/036753.html
>
> Actually driver works fine with/without
> ASYNC_TX_ENABLE_CHANNEL_SWITCH enabled
> so I am fine with removing dependency on this config option.

I stand corrected.

Previously, when I had tried removing
ASYNC_TX_ENABLE_CHANNEL_SWITCH
from BCM_SBA_RAID config option it worked because other
drivers such xgene-dma and mv_xor_v2 are selecting this option.

The BCM-SBA-RAID driver requires
ASYNC_TX_ENABLE_CHANNEL_SWITCH option

There is no issue reported for
ASYNC_TX_ENABLE_CHANNEL_SWITCH
with ARM64 kernel.

The issue you pointed out was with ARM kernel.

We will have to select
ASYNC_TX_ENABLE_CHANNEL_SWITCH
for BCM-SBA-RAID driver
just like other ARM64 RAID drivers such
as xgene-dma and mv_xor_v2.
(Refer, XGENE_DMA and MV_XOR_V2 options)

Regards,
Anup
