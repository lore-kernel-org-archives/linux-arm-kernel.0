From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 27 Nov 2014 14:57:13 +0100
Subject: [PATCH v4 5/6] ARM: zynq: Add OCM controller driver
In-Reply-To: <CACRpkdbZ8Pwy=04dhJq5ONZ1B-SQK1f=eLZjjCDmV7UQ0aHduA@mail.gmail.com>
References: <cover.1415962281.git.michal.simek@xilinx.com>
 <6741d995fbec801d795c5db481e39425bd912f8a.1415962281.git.michal.simek@xilinx.com>
 <CACRpkdbZ8Pwy=04dhJq5ONZ1B-SQK1f=eLZjjCDmV7UQ0aHduA@mail.gmail.com>
Message-ID: <857cab03bd6445c59cc345349a00f67c@BL2FFO11FD010.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2014 02:20 PM, Linus Walleij wrote:
> On Fri, Nov 14, 2014 at 11:52 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> 
>> The driver provide memory allocator which can
>> be used by others drivers to allocate memory inside OCM.
>> All location for 64kB blocks are supported
> 
> Allocation?
> 
>> and driver is trying to allocate the largest continuous
>> block of memory.
> 
> Isn't all genalloc allocations continuous?

I hope it is but blocks can be at different locations.

Two locations 0 or 0xfffc0000.
it means for every 64k block can be at low or high address location
first block 0x0 or 0xfffc0000
second block 0x10000 or 0xfffd0000
third block 0x20000 or 0xfffe0000
four block 0x30000 or 0xffff0000

it is worth to allocate to biggest continuous memory.
For example 2 blocks low and then 2 blocks high.

2 blocks with 128kB is better then 4 blocks with 64kB

> 
> (...)
>> +       zynq_ocmc->pool = devm_gen_pool_create(&pdev->dev,
>> +                                              ilog2(ZYNQ_OCMC_GRANULARITY),
>> +                                              -1);
> 
> Do this:
> 
> #include <linux/sizes.h>
> 
> zynq_ocmc->pool = devm_gen_pool_create(&pdev->dev,
>                                        ilog2(SZ_64K),
>                                        -1);
> 
> And get rid of the #define for ZYNQ_OCMC_GRANULARITY

ilog2 from 32 is different to ilog2 from ilog2 from 0x10000.
But I will look at gen pool internals.

Do you have any opinion regarding calling zynq_slcr_get_ocm_config()?

Is it better to expose slcr this interface to drivers?
Or use regmap and read this value directly?

Also I do read for CONFIG_SMP case jump trampoline size - maybe
you can have better idea how this can be done.

Thanks for your input,
Michal
