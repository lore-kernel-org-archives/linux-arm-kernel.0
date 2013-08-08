From: zonque@gmail.com (Daniel Mack)
Date: Thu, 08 Aug 2013 11:11:57 +0200
Subject: [PATCH 09/12] dma: mmp_pdma: add support for byte-aligned
 transfers
In-Reply-To: <4CF37FDA40C2184293FA2CF8CFAE31322007F0131D@SC-VEXCH4.marvell.com>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
 <1375870770-14263-10-git-send-email-zonque@gmail.com>
 <4CF37FDA40C2184293FA2CF8CFAE31322007F0131D@SC-VEXCH4.marvell.com>
Message-ID: <520360DD.9070906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xiang,

On 08.08.2013 11:04, Xiang Wang wrote:
>> Subject: [PATCH 09/12] dma: mmp_pdma: add support for byte-aligned
>> transfers
>> 
>> The PXA DMA controller has a DALGN register which allows for 
>> byte-aligned DMA transfers. Use it in case any of the transfer 
>> descriptors is not aligned to a mask of ~0x7.

[...]

> We do need to set DALGN bit in some of our drivers.

Which ones, and how do you currently do that? I didn't find any code to
support this yet in mmp-pdma.

> But we cannot
> configure this via standard dma engine API. In this patch, dma
> address is used to determine whether or not to set DALGN. But what if
> we need to use 1-byte-aligned mode when addresses are
> 8-byte-aligned?

Hmm, why would you need that? What's the constraint for this driver that
they have to rely on that?

> Is it proper to always use 1-byte-aligned mode? 

As far as I understand the datasheet, this bit has performance
implications and should only be used if really needed.

I think if you have that constraint in drivers, and the dmaengine
implementation can't determine that automatically, we should introduce a
flag or something in the dma_slave_config struct.


Daniel
