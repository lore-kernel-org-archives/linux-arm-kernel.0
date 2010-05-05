From: svenkatr@ti.com (Venkatraman S)
Date: Wed, 5 May 2010 17:21:51 +0530
Subject: [PATCH v8 1/2] sDMA: descriptor autoloading feature
In-Reply-To: <4BE142D4.5010106@nokia.com>
References: <l2i618f0c911004291035ja334efb0o5016c5cb70c4b5bc@mail.gmail.com>
	<4BE142D4.5010106@nokia.com>
Message-ID: <u2o618f0c911005050451l64e46271lf688c66d5b07b5bb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 5, 2010 at 3:35 PM, Adrian Hunter <adrian.hunter@nokia.com> wrote:
> Venkatraman S wrote:
>>>
>>> From d46f8a00728cc6c1fbdfce69435759c8cc49f25c Mon Sep 17 00:00:00 2001
>>
>> From: Venkatraman S <svenkatr@ti.com>
>> Date: Thu, 29 Apr 2010 22:34:04 +0530
>> Subject: [PATCH 1/2] sDMA: descriptor autoloading feature
>>
>> Add sDMA driver support for descriptor autoloading feature.
>> ?Descriptor autoloading is OMAP sDMA v5 hardware capability that can
>> be exploited for scatter gather
>> ?scenarios, currently available in OMAP3630 and OMAP4430.
>>
>> ?The feature works as described below.
>> ?1) A sDMA channel is programmed to be in 'linked list' mode.
>> ?2) The client (sDMA user) provides a list of descriptors in a linked
>> list format.
>> ?3) Each of the 'descriptor' (element in the linked list) contains an
>> updated set of DMA
>> ?configuration register values.
>> ?4) Client starts DMA transfer.
>> ?5) sDMA controller loads the first element to its register
>> configuration memory and executes the
>> ?transfer.
>> ?6) After completion, loads the next element (in linked list) to
>> configuration memory and executes
>> ?the transfer, without MCU intervention.
>> ?7) Interrupt is generated after all transfers are completed; this
>> can be configured to be done
>> ?differently.
>>
>> ?Configurations and additional features
>> ?1) Fast mode & non-fast mode
>> ? ? ? ?Fast mode/non-fast decides on how the first transfer begins.
>> In non-fast mode, the first
>> ? ? ? ?element in the linked list is loaded only after completing the
>> transfer according to the
>> ? ? ? ?configurations already in the sDMA channel registers. In fast mode,
>> the loading of the first
>> ? ? ? ?element precedes the transfer.
>>
>> ?2) Pause / resume of transfers
>> ? ? ? ?A transfer can be paused after a descriptor set has been loaded,
>> provided the 'pause
>> ? ? ? ?bit' is set in the linked list element.
>> ? ? ? ?An ongoing transfer cannot be paused. If the 'pause bit' is set,
>> transfer is not
>> ? ? ? ?started after loading the register set from memory.
>> ? ? ? ?Such a transfer can be resumed later.
>>
>> ?3) Descriptor types
>> ? ? ? ?3 possible configurations of descriptors (initialized as linked
>> list elements)
>> ? ? ? ?are possible. Type 1 provides the maximum flexibility, which
>> contains most
>> ? ? ? ?register definitions of a DMA logical channel. Fewer options are
>> present in type
>> ? ? ? ?2. Type 3 can just modify source/destinations address of transfers.
>> In all
>> ? ? ? ?transfers, unmodified registers settings are maintained for the
>> next transfer.
>>
>> ? ? ? ?Patch provides options / API for
>> ? ? ? ? ? ?1) Setting up a descriptor loading for DMA channel for sg type
>> transfers
>> ? ? ? ? ? ?2) configuration with linked list elements
>> ? ? ? ? ? ?3) Starting / pause and resume of the said transfers, query
>> state
>> ? ? ? ? ? ?4) Clearing the sglist mode
>>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> CC: Adrian Hunter <adrian.hunter@nokia.com>
>> CC: Madhusudhan C <madhu.cr@ti.com>
>> CC: Shilimkar Santosh <santosh.shilimkar@ti.com>
>> CC: Tony Lindgren <tony@atomide.com>
>> ---
>> ?Changes from v7:
>> ? * Added wmb() calls between descriptor data structure update and
>> start/resume of transfer
>> ? * Added proper commit log about the feature
>>
>> ?arch/arm/plat-omap/dma.c ? ? ? ? ? ? ?| ?289
>> ++++++++++++++++++++++++++++++++-
>> ?arch/arm/plat-omap/include/plat/dma.h | ?170 +++++++++++++++++++
>> ?2 files changed, 458 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
>> index f6c9bdc..d8d4df8 100644
>> --- a/arch/arm/plat-omap/dma.c
>> +++ b/arch/arm/plat-omap/dma.c
>> @@ -46,12 +46,40 @@ enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE,
>> DMA_CH_STARTED,
>> ?enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
>> ?#endif
>>
>> +/* CDP Register bitmaps */
>> +#define DMA_LIST_CDP_DST_VALID (BIT(0))
>> +#define DMA_LIST_CDP_SRC_VALID (BIT(2))
>> +#define DMA_LIST_CDP_TYPE1 ? ? (BIT(4))
>> +#define DMA_LIST_CDP_TYPE2 ? ? (BIT(5))
>> +#define DMA_LIST_CDP_TYPE3 ? ? (BIT(4) | BIT(5))
>> +#define DMA_LIST_CDP_PAUSEMODE (BIT(7))
>> +#define DMA_LIST_CDP_LISTMODE ?(BIT(8))
>> +#define DMA_LIST_CDP_FASTMODE ?(BIT(10))
>> +/* CAPS register bitmaps */
>> +#define DMA_CAPS_SGLIST_SUPPORT ? ? ? ?(BIT(20))
>> +
>> +#define DMA_LIST_DESC_PAUSE ? ?(BIT(0))
>> +#define DMA_LIST_DESC_SRC_VALID ? ? ? ?(BIT(24))
>> +#define DMA_LIST_DESC_DST_VALID ? ? ? ?(BIT(26))
>> +#define DMA_LIST_DESC_BLK_END ?(BIT(28))
>> +
>
> The () are not needed around BIT()
OK

>
>> ?#define OMAP_DMA_ACTIVE ? ? ? ? ? ? ? ? ? ? ? ?0x01
>> ?#define OMAP2_DMA_CSR_CLEAR_MASK ? ? ? 0xffe
>>
>> ?#define OMAP_FUNC_MUX_ARM_BASE ? ? ? ? (0xfffe1000 + 0xec)
>> +#define OMAP_DMA_INVALID_FRAME_COUNT ? (0xffff)
>> +#define OMAP_DMA_INVALID_ELEM_COUNT ? ?(0xffffff)
>> +#define OMAP_DMA_INVALID_DESCRIPTOR_POINTER ? ?(0xfffffffc)
>
> The () are not needed around literals
>
OK

>>
>> ?static int enable_1510_mode;
>> +static int dma_caps0_status;
>> +
