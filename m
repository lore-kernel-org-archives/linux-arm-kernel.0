From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Jul 2010 13:25:52 +0100
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 , with
	RealView  platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <AANLkTimtpIQaKVHidWP9fvOKGGiQRc0tne1kO5mO-Zzs@mail.gmail.com>
References: <AANLkTimtpIQaKVHidWP9fvOKGGiQRc0tne1kO5mO-Zzs@mail.gmail.com>
Message-ID: <1279196752.6664.19.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-07-15 at 17:13 +0800, David Yang wrote:
>        I encountered this problem when porting my ethernet driver from
> linux-2.6.28 to linux-2.6.33-arm1.
> 
>        In the linux-2.6.28, I used the dma_alloc_coherent to share the
> informations between cpu and ethernet device.The program flow in the
> function ndo_start_xmit:
>                1,preparing the struct sk_buff->data for device internal DMA to
> read,using the dma_map_single function.
>                2,update the information in the memory which is allocated by
> dma_alloc_coherent to tell the device DMA the data is readable.
>                3,write the device register to inform the device DMA
> to read the data.

You need a wmb() before the writel() which tells the device to start the
DMA transfer. We'd like to make this the default (in the write* macros)
and there are patches for review on the list.

Without the barrier, the card may transfer garbage since the date
written in step (2) may have not reached the RAM.

>                4,cpu captures the interrupt of reading completion
> form the device.
[...]
>                After some tests, I think the problem comes from the
> dma_alloc_coherent.It looks like ,in the linux-2.6.33-arm1, when the
> memory allocated by dma_alloc_coherent is written,the data entry into
> the ddr much slower than the same process in linux-2.6.28.Therefore,when
> cpu has executed the step 3, the step 2 has not yet completed.So the DMA
> can't get the correct information ,and the step 4 will never be reached.

Correct.

Note that I haven't fixed this issue in the 2.6.33-arm1 kernel. My
opinion for some time was that drivers should take care of memory
ordering and use the correct barriers. But after discussion on LKML, I
eventually changed my mind (and we now have a small drop in performance
for PIO drivers on ARMv6/v7).

Could you use a newer kernel? I can backport the I/O accessors patches
to 2.6.33-arm1 but only after Russell is ok with the latest version (to
avoid additional work on my side).

-- 
Catalin
