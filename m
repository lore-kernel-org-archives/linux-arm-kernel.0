From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 4 Apr 2014 11:10:24 +0530
Subject: [PATCH 63/75] ARM: l2c: zynq: remove cache size override
In-Reply-To: <20140403191341.GX7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYZQ-0007H7-L6@rmk-PC.arm.linux.org.uk> <533BC56D.4010600@monstr.eu>
 <533BF694.7030805@ti.com> <20140403191341.GX7528@n2100.arm.linux.org.uk>
Message-ID: <533E45C8.8060305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 April 2014 12:43 AM, Russell King - ARM Linux wrote:
> On Wed, Apr 02, 2014 at 05:07:56PM +0530, Sekhar Nori wrote:
>> So reading the original commit text from Catalin
>> (1a8e41cd672f894bbd74874eac601e6cedf838fb):
>>
>>     ARM: 6395/1: VExpress: Set bit 22 in the PL310 (cache controller)
>> AuxCtlr register
>>
>>     Clearing bit 22 in the PL310 Auxiliary Control register (shared
>>     attribute override enable) has the side effect of transforming Normal
>>     Shared Non-cacheable reads into Cacheable no-allocate reads.
>>
>>     Coherent DMA buffers in Linux always have a Cacheable alias via the
>>     kernel linear mapping and the processor can speculatively load cache
>>     lines into the PL310 controller. With bit 22 cleared, Non-cacheable
>>     reads would unexpectedly hit such cache lines leading to buffer
>>     corruption.
>>
>>     Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
>>     Cc: <stable@kernel.org>
>>     Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>>
>> It looks like all Linux systems will have to use Sharable override to
>> avoid corruption? I see OMAP4 had a similar commit to enable bit 22 of
>> aux control register.
>>
>> If yes, how about doing it by default in cache-l2x0.c rather than
>> leaving it to each platform?
> 
> The comments in the commit are no longer true with CMA, which finally
> fixes the multiple mapping problem.  The sharable override bit should
> not need to be set for systems using CMA as their backing store for
> DMA coherent memory.

Thanks for the explanation. Note to myself: some platforms are using
arm_memblock_steal() or memblock_remove() for reserving coherent memory
which should also be safe as the memory is not mapped in kernel page tables.

Thanks,
Sekhar
