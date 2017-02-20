From: vigneshr@ti.com (Vignesh R)
Date: Mon, 20 Feb 2017 15:17:49 +0530
Subject: [PATCH v2 4/6] spi: davinci: flush caches when performing DMA
In-Reply-To: <f0fcc000-6c07-647a-ada2-04b61f0e2e3b@baylibre.com>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
 <1487327904-28311-5-git-send-email-fisaksen@baylibre.com>
 <5fab0c33-6e1d-c63a-8758-6672236045a7@ti.com>
 <20170217112247.GE21222@n2100.armlinux.org.uk>
 <eaf93c6c-52a7-826b-9c53-2b13c0b280ca@baylibre.com>
 <20170217120749.GF21222@n2100.armlinux.org.uk>
 <0f3607fd-4542-be92-da2e-b2da6f8ac26f@ti.com>
 <f0fcc000-6c07-647a-ada2-04b61f0e2e3b@baylibre.com>
Message-ID: <57721a60-52bb-c9d1-d5a7-ae450e7adcc0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 20 February 2017 02:56 PM, Frode Isaksen wrote:
> 
> 
> On 20/02/2017 07:55, Vignesh R wrote:
>>
>> On Friday 17 February 2017 05:37 PM, Russell King - ARM Linux wrote:
>> [...]
>>> SPI is rather another special case - rather than SPI following the 
>>> established mechanism of passing data references via scatterlists or 
>>> similar, it also passes them via virtual addresses, which means SPI 
>>> can directly access the vmalloc area when performing PIO.  This 
>>> really makes the problem more complex, because it means that if you 
>>> do have a SPI driver that does that, it's going to be
>>> reading/writing direct from vmalloc space.
>>>
>>> That's not a problem as long as the data is only accessed via
>>> vmalloc space, but it will definitely go totally wrong if the data
>>> is subsequently mapped into userspace.
>>>
>>> The other important thing to realise is that the interfaces in 
>>> cachetlb.txt assume that it's the lowmem mapping that will be
>>> accessed, and the IO device will push that data out to physical
>>> memory (either via the DMA API, or flush_kernel_dcache_page()).
>>> That's not true of SPI, as it passes virtual addresses around.
>>>
>>> So... overall, I'm not sure that this problem is properly solvable
>>> given SPIs insistance on passing virtual addresses and the
>>> differences in this area between SPI and block.
>>>
>> I am debugging another issue with UBIFS wherein pages allocated by
>> vmalloc are in highmem region that are not addressable using 32 bit
>> addresses and is backed by LPAE. So, a 32 bit DMA cannot access these
>> buffers at all.
>> When dma_map_sg() is called to map these pages by spi_map_buf() the
>> physical address is just truncated to 32 bit in pfn_to_dma() (as part of
>> dma_map_sg() call). This results in random crashes as DMA starts
>> accessing random memory during SPI read.
>>
>> Given, the above problem and also issue surrounding VIVT caches, I am
>> thinking of may be using pre-allocated fixed size bounce buffer to
>> handle buffers not in lowmem mapping.
>> I have tried using 64KB pre-allocated buffer on TI DRA74 EVM with QSPI
>> running at 76.8MHz and do not see any significant degradation in
>> performance with UBIFS. Mainly because UBIFS seems to use vmalloc'd
>> buffers only during initial preparing and mounting phase and not during
>> file read/write.
> I am seeing a bug caused by VIVT cache in 'read_ltab()' function. In this function, the vmalloc'ed buffer is of size 11. Isn't it better to use kmalloc in this case ?

read_ltab() isn't the only place where vmalloc() is used. A quick grep
for vmalloc on fs/ubifs/ shows about ~19 occurrence. I guess every
vmalloc() call can potentially allocate memory from highmem and might
potentially cause issue for VIVT and such aliasing caches.
Fixing just one such case isn't going to help IMHO.


-- 
Regards
Vignesh
