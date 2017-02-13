From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 13 Feb 2017 21:26:07 +0000
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
References: <VI1PR0401MB2430DA6BD2F857C30EC86A50917F0@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <HE1PR0401MB263638F320470CA216990BCC86720@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <5414359.8GMja3pNrI@wuerfel>
 <VI1PR0401MB24303C4A5C0042005E17F1A391770@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <CAK8P3a1Gd4bd7GjEp_a9WXc_mTPk0XmP7DH8aPWhbn2K3MMuDQ@mail.gmail.com>
 <1485570872.9266.22.camel@buserror.net>
 <d5ca6bcd-1d1a-2a61-1f5c-9086a67f629a@arm.com>
 <HE1PR0401MB2636FF4D977DDA6888616A26864B0@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <3cc42823-0fc9-ed3e-1738-bf6e314dd569@arm.com>
 <HE1PR0401MB2636B14B4F1637A5A7D5432386400@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <20170206223721.GN27312@n2100.armlinux.org.uk>
 <HE1PR0401MB26362EA8D498B77755DE63A286430@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <e15f6ce7-be92-9200-c6b4-2b2dd83f078f@arm.com>
Message-ID: <VI1PR04MB32169AF848EE1B75A83B542A86590@VI1PR04MB3216.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/7/2017 1:26 PM, Robin Murphy wrote:
> On 07/02/17 16:44, Roy Pledge wrote:
>> On 2/6/2017 5:37 PM, Russell King - ARM Linux wrote:
>>> On Mon, Feb 06, 2017 at 10:26:26PM +0000, Roy Pledge wrote:
>>>> Why don't I simplify this and use dma_sync_single_for_device() to flush
>>>> the cache?
>>> ... which can only be used on direct-mapped memory.
>>>
>> Then I don't see another (or understand) any other option. There is no
>> way I can add a large area of physical memory carved out by
>> of_reserve_mem to a DMA allocator since both ioremap and memremap throw
>> an error if I try to do so. I appreciate the suggestions from people to
>> resolve this but so far there isn't a workable solution to the problem.
>> As far as I can tell other users of dma_declare_coherent_memory() are
>> using it for device backed memory, not DDR.  It sounds like a solution
>> on the surface but when you dig into the details it just doesn't work. 
>> Please let me know if I'm missing something, I really want to close this
>> issue so we can get upstream support for this device on ARM.
> Apologies, having found time to take a proper look, it transpires I was
> somewhat misremembering things. You're right that
> dma_declare_coherent_memory() is for resources owned by the device, and
> a DT reservation doesn't really count as such. What I had mixed up is
> that a reserved-memory node has its own way of getting tied into CMA
> automatically: ensure it has the "shared-dma-pool" compatible, point a
> memory-region property at it from your device's node, then have the
> driver call of_reserved_mem_device_init() - at that point, your DMA
> allocations should be coming out of the given region so you should be
> free to just grab the whole lot in one go.
>
> I've just confirmed that experimentally by bodging a reserved-memory
> node into my Juno DT for the ARM HDLCD - another non-coherent device
> which needs ~8MB contiguous buffers - and it works as expected.
>
> Robin.
This makes sense to me now, but I run into an issue when I try this on
my development system.

I added 'compatible = "shared-dma-pool" into my device tree and the set
the memory-region property for my device and I see this now at boottime:

[    0.000000] Reserved memory: created DMA memory pool at
0x00000009ff000000, size 8 MiB
[    0.000000] OF: reserved mem: initialized node qman-fqd, compatible
id shared-dma-pool

but when I call of_reserved_mem_device_init() during my device probe
routine it fails as follows:

[    0.738814] memremap attempted on ram 0x00000009ff000000 size: 0x800000
[    0.745485] ------------[ cut here ]------------
[    0.750132] WARNING: CPU: 0 PID: 1 at kernel/memremap.c:111
memremap+0x100/0x144

<....cut out a bunch of register dumps....>

[    0.973780] [<ffff00000816a748>] memremap+0x100/0x144
[    0.978859] [<ffff00000853c1d0>] dma_init_coherent_memory+0x60/0x194
[    0.985249] [<ffff00000853c7b0>] rmem_dma_device_init+0x64/0x94
[    0.991202] [<ffff000008775c88>]
of_reserved_mem_device_init_by_idx+0xf8/0x198
[    0.998468] [<ffff00000849b1ac>] fsl_qman_probe+0xdc/0x804
[    1.003983] [<ffff000008526538>] platform_drv_probe+0x50/0xbc
[    1.009760] [<ffff00000852489c>] driver_probe_device+0x220/0x2b8
[    1.015799] [<ffff0000085249d8>] __driver_attach+0xa4/0xa8
[    1.021313] [<ffff000008522908>] bus_for_each_dev+0x58/0x98
[    1.026915] [<ffff0000085241d8>] driver_attach+0x20/0x28
[    1.032254] [<ffff000008523d98>] bus_add_driver+0x1c8/0x22c
[    1.037856] [<ffff0000085252d8>] driver_register+0x60/0xf4
[    1.043371] [<ffff00000852647c>] __platform_driver_register+0x48/0x50
[    1.049849] [<ffff000008d5800c>] fsl_qman_driver_init+0x18/0x20
[    1.055802] [<ffff000008083148>] do_one_initcall+0x38/0x118
[    1.061405] [<ffff000008d20cec>] kernel_init_freeable+0x1a0/0x240
[    1.067533] [<ffff0000088f8298>] kernel_init+0x10/0xfc
[    1.072697] [<ffff000008082ec0>] ret_from_fork+0x10/0x50
[    1.078055] Reserved memory: failed to init DMA memory pool at
0x00000009ff000000, size 8 MiB

Is there another attribute I need to set in the device tree? It seems to
be trying to setup the pool but failing to do the mapping similar to the
issues I faced earlier.

Thanks again

Roy

>
>>
>> Roy
>>
>
