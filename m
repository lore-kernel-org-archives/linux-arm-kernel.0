From: fisaksen@baylibre.com (Frode Isaksen)
Date: Mon, 20 Feb 2017 16:49:05 +0100
Subject: [PATCH v2 4/6] spi: davinci: flush caches when performing DMA
In-Reply-To: <954333da-4d15-ce77-4021-268530365edc@ti.com>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
 <1487327904-28311-5-git-send-email-fisaksen@baylibre.com>
 <5fab0c33-6e1d-c63a-8758-6672236045a7@ti.com>
 <20170217112247.GE21222@n2100.armlinux.org.uk>
 <eaf93c6c-52a7-826b-9c53-2b13c0b280ca@baylibre.com>
 <20170217120749.GF21222@n2100.armlinux.org.uk>
 <0f3607fd-4542-be92-da2e-b2da6f8ac26f@ti.com>
 <f0fcc000-6c07-647a-ada2-04b61f0e2e3b@baylibre.com>
 <57721a60-52bb-c9d1-d5a7-ae450e7adcc0@ti.com>
 <2a1954a3-edbd-7ac4-6fde-9b6d046a6560@baylibre.com>
 <954333da-4d15-ce77-4021-268530365edc@ti.com>
Message-ID: <69d41f8a-371b-abd9-7e78-f8701652877f@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/02/2017 12:27, Vignesh R wrote:
>
> On Monday 20 February 2017 04:04 PM, Frode Isaksen wrote:
>>
>> On 20/02/2017 10:47, Vignesh R wrote:
>>> On Monday 20 February 2017 02:56 PM, Frode Isaksen wrote:
>>>> On 20/02/2017 07:55, Vignesh R wrote:
>>>>> On Friday 17 February 2017 05:37 PM, Russell King - ARM Linux wrote:
> [...]
>>>>> I am debugging another issue with UBIFS wherein pages allocated by
>>>>> vmalloc are in highmem region that are not addressable using 32 bit
>>>>> addresses and is backed by LPAE. So, a 32 bit DMA cannot access these
>>>>> buffers at all.
>>>>> When dma_map_sg() is called to map these pages by spi_map_buf() the
>>>>> physical address is just truncated to 32 bit in pfn_to_dma() (as part of
>>>>> dma_map_sg() call). This results in random crashes as DMA starts
>>>>> accessing random memory during SPI read.
>>>>>
>>>>> Given, the above problem and also issue surrounding VIVT caches, I am
>>>>> thinking of may be using pre-allocated fixed size bounce buffer to
>>>>> handle buffers not in lowmem mapping.
>>>>> I have tried using 64KB pre-allocated buffer on TI DRA74 EVM with QSPI
>>>>> running at 76.8MHz and do not see any significant degradation in
>>>>> performance with UBIFS. Mainly because UBIFS seems to use vmalloc'd
>>>>> buffers only during initial preparing and mounting phase and not during
>>>>> file read/write.
>>>> I am seeing a bug caused by VIVT cache in 'read_ltab()' function. In this function, the vmalloc'ed buffer is of size 11. Isn't it better to use kmalloc in this case ?
>>> read_ltab() isn't the only place where vmalloc() is used. A quick grep
>>> for vmalloc on fs/ubifs/ shows about ~19 occurrence. I guess every
>>> vmalloc() call can potentially allocate memory from highmem and might
>>> potentially cause issue for VIVT and such aliasing caches.
>>> Fixing just one such case isn't going to help IMHO.
>> Of course fixing it only in one place is of course not going to help..
>> For the moment there are 3 solutions to the UBIFS DMA problem:
>> 1) Always use bounce buffer for vmalloc'ed buffers - impacts everyone.
>> 2) Remove use of vmalloc'ed buffers in UBIFS - is it possible ?
> Maybe. But what about mtdblock with JFFS2 on top of it, mtdblock still
> uses vmalloc'd buffers?
That's why I put the cache flush in the SPI driver in the first try..
FYI, I replaced the use of vmalloc with kmalloc in a few places in the UBIFS layer and it seems to work. The size of the buffers allocated varies from 11 (?) to 65408 bytes.
Maybe the best place to handle this is in the SPI flash drivers(s). These drivers knows that they may handle vmalloc'ed buffers and the should assume that the underlying SPI driver may use DMA.

Thanks,
Frode
>
>
