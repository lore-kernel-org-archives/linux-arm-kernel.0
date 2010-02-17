From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 17 Feb 2010 11:21:41 +0800
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7DBB@dbde02.ent.ti.com>
References: <20100208065519.GE1290@ucw.cz>
	<1265628483.4020.63.camel@pc1117.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7D50@dbde02.ent.ti.com>
	<201002160922.47072.oliver@neukum.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C3CF7DBB@dbde02.ent.ti.com>
Message-ID: <d82e647a1002161921l669e08bficafc0c2bc5433cb3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/2/16 Shilimkar, Santosh <santosh.shilimkar@ti.com>:

>> > We have a below temporary patch to get around the issue and probably it
>> > needs to be fixed in the right way in the stack because some controllers
>> > may not have PIO option even for control transfers. (e.g. Synopsis EHCI
>> > controller)

Your temporary patch only removes dma map and umap for setup buffer in
control transfer.

>>
>> This seems wrong to me. Buffers for control transfers may be transfered
>> by DMA, so the caches must be flushed on architectures whose caches
>> are not coherent with respect to DMA.
> Indeed and that's what I mentioned in the comment. But we shouldn't have dma
> cache maintenance operations done for the buffers which would use pio based transfer.
>> Would you care to elaborate on the exact nature of the bug you are fixing?
> On the OMAP4 (ARM cortex-a9) platform, the enumeration fails because control
> transfer buffers are corrupted. On our platform, we use PIO mode for control
> transfers and DMA for bulk transfers.

I don't know you mean you use PIO mode for seup buffer only or whole control
transfer(setup sent, data in or data out).  If you mean do not use DMA
for setup sent, data in or data out in a control transfer, your
temporary patch maybe is not enough, right?

>
> The current stack performs dma cache maintenance even for the PIO transfers
> which leads to the corruption issue. The control buffers are handled by CPU
> and they already coherent from CPU point of view.

-- 
Lei Ming
