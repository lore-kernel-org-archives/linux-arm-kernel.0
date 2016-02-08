From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 8 Feb 2016 17:59:25 +0000
Subject: [RESEND2 PATCH 0/3] Fix kernel panic in dma-coherent
In-Reply-To: <20160208175054.GD15443@leverpostej>
References: <cover.1454950917.git.brian.starkey@arm.com>
 <20160208175054.GD15443@leverpostej>
Message-ID: <56B8D77D.3050305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 08/02/16 17:50, Mark Rutland wrote:
> On Mon, Feb 08, 2016 at 05:30:49PM +0000, Brian Starkey wrote:
>> Hi,
>>
>> I'm resending these again to try and garner some interest. Without
>> this series, dma-coherent cannot be used on arm64 platforms.
>
> I think you need to characterize that a bit better. I see plenty of
> instances of 'dma-coherent' in dts files, assuming you mean the DT
> dma-coehrent property.
>
> If not, feel free to stop reading now.

Terminology overload: the dma-coherent DT property is about devices 
having cache-coherent access to system memory within the linear map. The 
dma-coherent thing here is pretty much the precise opposite of that - 
namely creating CPU mappings for memory which belongs to the device 
itself and may be behind an I/O bus (e.g. a framebuffer on a video card).

> Currently dma-coherent isn't well-defined,

True dat.

Robin.

> but it's de-facto semantics
> are that a device makes accesses which are coherent with data accesses
> made by CPUs with Normal, Inner Shareable, Inner Write-Back Cacheable,
> Outer Write-Back Cacheable attributes.
>
>> The decision to add MEMREMAP_WC came out of a previous discussion with
>> Dan Williams and Catalin Marinas about the same problem[1].
>
> As pgprot_writecombine is Normal Non-Cacheable, this is a completely
> different idea of coherency to that described by the DT dma-coherent
> property.
>
> We should not overload that to mean different things.
>
> Thanks,
> Mark.
>
>> These patches implement a MEMREMAP_WC flag for memremap(), which can
>> be used to obtain writecombine mappings. This is then used for setting
>> up dma_coherent_mem regions which use the DMA_MEMORY_MAP flag.
>> They apply cleanly on 4.5-rc3.
>>
>> Patch 3 makes sure that the appropriate memset function is used
>> when zeroing coherent allocations, which fixes an alignment fault on
>> arm64.
>>
>> Best Regards,
>> Brian
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390857.html
>>
>> Brian Starkey (3):
>>    memremap: add MEMREMAP_WC flag
>>    drivers: dma-coherent: use MEMREMAP_WC for DMA_MEMORY_MAP
>>    drivers: dma-coherent: use memset_io for DMA_MEMORY_IO
>>
>>   drivers/base/dma-coherent.c |   25 ++++++++++++++++++++-----
>>   include/linux/io.h          |    1 +
>>   kernel/memremap.c           |   15 +++++++++++++--
>>   3 files changed, 34 insertions(+), 7 deletions(-)
>>
>> --
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
