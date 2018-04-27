From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Apr 2018 15:12:50 +0100
Subject: [PATCH]irqchip/irq-gic-v3:Avoid a waste of LPI resource
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A69EECF90@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A69EECF90@G01JPEXMBKW03>
Message-ID: <ce2c6191-1f74-4cec-9009-0a770d32673a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[fixing up the address of the LAK mailing list]

Hi Lei,

On 27/04/18 14:20, Zhang, Lei wrote:
> I want to talk about the implementation of GIC-ITS driver.
> The current implementation of irq-gic-v3-its driver allocates at 
> least 32 LPIs (interrupt numbers) for each Device ID even if the number of
> requested LPIs is only one.
> I think it is a waste for LPI resource.

It depends what your use case is. The use-case the ITS driver is
designed for is that you have far more LPIs than you have devices, and
each device is going to use far more than a single LPI.

That's pretty much the case of all systems that use PCI, where each
function tends to allocate one queue (and thus one MSI) per CPU.

Another benefit of allocating 32 LPIs in one go is that it guarantees
the right allocation for PCI devices requiring Multi-MSI.

> And if we use many devices over ITS, this implementation may cause a
> shortage of LPI .

How many is many? Are they PCI? Or something else?

> I have a patch to avoid this problem by reducing the number of LPIs from 32 to 2 per chunk.
> The points of this patch are as follows.
> Point1:Each Device ID can still allocate enough LPIs by increasing chunk number.
> Point2:The size of memory for the bitmap (lpi_bitmap) to manage the free chunks becomes 
> larger(256B -> 4KiB).But I think it is not a problem,
> because the max size of lpi_bitmap is 4KiB.

As it is, this patch will break Multi-MSI and some other platforms that
do require a higher allocation granule.

Depending on whether you're using PCI or some other bus, we can probably
come up with a solution that works for everyone. But I need more
information on this.

Thanks,

	M.

> 
> Signed-off-by: Lei Zhang <zhang.lei@jp.fujitsu.com>
> 
> The follow is my patch. the patch is based on kernel 4.16.5
> -------------------------------------
> --- drivers/irqchip/irq-gic-v3-its.c       2018-01-29 06:20:33.000000000 +0900
> +++ drivers/irqchip/irq-gic-v3-its.c    2018-04-25 15:05:26.078956980 +0900
> @@ -1406,12 +1406,12 @@
>   *
>   * The GIC has id_bits bits for interrupt identifiers. From there, we
>   * must subtract 8192 which are reserved for SGIs/PPIs/SPIs. Then, as
> - * we allocate LPIs by chunks of 32, we can shift the whole thing by 5
> + * we allocate LPIs by chunks of 2, we can shift the whole thing by 1
>   * bits to the right.
>   *
>   * This gives us (((1UL << id_bits) - 8192) >> 5) possible allocations.
>   */
> -#define IRQS_PER_CHUNK_SHIFT   5
> +#define IRQS_PER_CHUNK_SHIFT   1
>  #define IRQS_PER_CHUNK         (1 << IRQS_PER_CHUNK_SHIFT)
>  #define ITS_MAX_LPI_NRBITS     16 /* 64K LPIs */
> 
> Regards,
> Lei Zhang
> --
> e-mail: zhang.lei at jp.fujitsu.com 
> 
> 


-- 
Jazz is not dead. It just smells funny...
