From: lee.essen@nowonline.co.uk (Lee Essen)
Date: Tue, 15 Apr 2014 20:22:55 +0400
Subject: dma_alloc_coherent and cache?
In-Reply-To: <4292964.mUEmdLVWYx@wuerfel>
References: <45E047AA-4C3B-4645-A590-5B75A1729ADA@nowonline.co.uk>
 <4356499.vN3lxjGqPZ@wuerfel>
 <E94CEA02-A987-4212-A0CA-D0CDC80E7250@nowonline.co.uk>
 <4292964.mUEmdLVWYx@wuerfel>
Message-ID: <30E320E3-FE79-4E2B-89D3-07E0D6EE975C@nowonline.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 15 Apr 2014, at 14:49, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 15 April 2014 14:01:39 Lee Essen wrote:
>>> On 15 Apr 2014, at 12:43, Arnd Bergmann <arnd@arndb.de> wrote:
>>> 
>>> dma_alloc_coherent() is a wrapper around a device-specific allocator,
>>> based on the dma_map_ops implementation. The default allocator
>>> from arm_dma_ops gives you uncached, buffered memory. It is expected
>>> that the driver uses a barrier (which is implied by readl/writel
>>> but not __raw_readl/__raw_writel or readl_relaxed/writel_relaxed)
>>> to ensure the write buffers are flushed.
>>> 
>>> If the machine sets arm_coherent_dma_ops rather than arm_dma_ops,
>>> the memory will be cacheable, as it's assumed that the hardware
>>> is set up for cache-coherent DMAs.
>> 
>> Hi,
>> 
>> The driver writes to the descriptor and then uses wmb() before enabling DMA. The descriptor is in dma_alloc_coherent() space, but the enable is a writel().
> 
> Ok
> 
>>> 
>>> Can you post a link to the source code?
>>> 
>>>  Arnd
>> 
>> The code is available here:
>> 
>> http://www.nowonline.co.uk/scratch/le_netdev.c
>> 
>> It hangs consistently when it executes the txq_enable() on line 1280. Occasionally I see a corrupt packet on the wire, but mostly it's just a hang. If I uncomment all the printk's then it generally gets 20 or 30 packets out before it freezes.
>> 
> 
> 
> Unfortunately I don't see an obvious mistake with the DMA handling there,
> I would try looking somewhere other than the dma code first. What
> kind of freeze do you see? Does the entire machine hang, or is it
> just the network interface that stops sending packets?
> 

Hi Arnd,

Thanks for having a look ? on the hangs it?s a complete machine hang, I?m connected via serial and it just stops dead.

I?m starting to look at other differences compared to the GPL code, but unfortunately there are many things. One very big difference is that the GPL code (used with 2.6.22) uses a patched version of proc-arm926.S that caters for a couple of Feroceon specifics.

The proc-feroceon.S version, which is used in the newer kernel, doesn?t seem to have some of these ? one section of note is:

ENTRY(cpu_arm926_do_idle)
#ifdef CONFIG_ARCH_FEROCEON
        /* Implement workaround for FEr# CPU-C16: Wait for interrupt command */
        /* is not processed properly, the workaround is not to use this command */
        /* the erratum is relevant for 5281 devices with revision less than C0 */

        ldr     r0, support_wait_for_interrupt_address /* this variable set in core.c*/
        ldr     r0, [r0]
        cmp     r0, #1    /* check if the device doesn't support wait for interrupt*/
        bne     1f        /* if yes, then go out*/
        /* workaround ends here*/
#endif
    mov r0, #0
    mrc p15, 0, r1, c1, c0, 0       @ Read control register
    mcr p15, 0, r0, c7, c10, 4      @ Drain write buffer
    bic r2, r1, #1 << 12
    mcr p15, 0, r2, c1, c0, 0       @ Disable I cache
    mcr p15, 0, r0, c7, c0, 4       @ Wait for interrupt
    mcr p15, 0, r1, c1, c0, 0       @ Restore ICache enable
#ifdef CONFIG_ARCH_FEROCEON
1:
#endif
    mov pc, lr

? but there are many others. I?ll continue to look@these and see if I can experiment ? but I?m am definitely way out of my depth.

Regards,

Lee.
