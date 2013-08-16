From: wangx@marvell.com (Xiang Wang)
Date: Fri, 16 Aug 2013 16:05:47 +0800
Subject: [PATCH 09/12] dma: mmp_pdma: add support for byte-aligned
 transfers
In-Reply-To: <520360DD.9070906@gmail.com>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
 <1375870770-14263-10-git-send-email-zonque@gmail.com>
 <4CF37FDA40C2184293FA2CF8CFAE31322007F0131D@SC-VEXCH4.marvell.com>
 <520360DD.9070906@gmail.com>
Message-ID: <520DDD5B.6080605@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 05:11 PM, Daniel Mack wrote:
> Hi Xiang,
>
> On 08.08.2013 11:04, Xiang Wang wrote:
>>> Subject: [PATCH 09/12] dma: mmp_pdma: add support for byte-aligned
>>> transfers
>>>
>>> The PXA DMA controller has a DALGN register which allows for
>>> byte-aligned DMA transfers. Use it in case any of the transfer
>>> descriptors is not aligned to a mask of ~0x7.
>
> [...]
>
>> We do need to set DALGN bit in some of our drivers.
>
> Which ones, and how do you currently do that? I didn't find any code to
> support this yet in mmp-pdma.
Hi, Daniel
When we use DMA in UART and let DMA handle the UART trailing bytes, we 
should set the DALGN bit. Otherwise, DMA controller cannot move the 
bytes from UART FIFO to memory correctly because they are not 
8-bytes-alligned.
>
>> But we cannot
>> configure this via standard dma engine API. In this patch, dma
>> address is used to determine whether or not to set DALGN. But what if
>> we need to use 1-byte-aligned mode when addresses are
>> 8-byte-aligned?
>
> Hmm, why would you need that? What's the constraint for this driver that
> they have to rely on that?
>
>> Is it proper to always use 1-byte-aligned mode?
>
> As far as I understand the datasheet, this bit has performance
> implications and should only be used if really needed.
>
> I think if you have that constraint in drivers, and the dmaengine
> implementation can't determine that automatically, we should introduce a
> flag or something in the dma_slave_config struct.
>
>
> Daniel
>


-- 
Regards,
Xiang
