From: labbott@redhat.com (Laura Abbott)
Date: Wed, 22 Jul 2015 09:21:56 -0700
Subject: Having Linux handle different "types" of memory
In-Reply-To: <55AFB47B.301@free.fr>
References: <55AFB47B.301@free.fr>
Message-ID: <55AFC324.9010401@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2015 08:19 AM, Mason wrote:
> Hello everyone,
>
> I'm using an ARMv7 platform (Cortex A9) on Linux 3.14
>
> The system supports two memory modules.
>
> For performance reasons, memory is "transparently" interleaved
> (with a 128-byte grain). That is, when the CPU accesses addresses
> 0-127, it hits DRAM0; addresses 128-255, it hits DRAM1, and so on.
>
> The problem is that other devices in the system, mainly the
> Ethernet controller, didn't get the "transparent interleaving"
> treatment. They just see DRAM0 and DRAM1. And I'm guessing this
> will generate all kinds of "interesting" problems when I try to
> DMA from the Ethernet controller's memory to DRAM...
>
> Is there a way to tell Linux:
>
> 1) this 1GB memory chunk here is for you and your private allocations,
> but don't use it for talking to devices/peripherals.
>
> 2) this 1GB memory chunk there is for talking to devices/peripherals,
> but it has lower performance, so try not to use it for your own
> private memory pools, but you can if memory is /really/ tight.
>
> Is there something like this?
>
> Maybe one of the NUMA policies?
> https://www.kernel.org/doc/Documentation/vm/numa_memory_policy.txt
> (I don't see any arch/arm/mm/numa.c however)
>
> Maybe I can pretend that there is some kind of IOMMU?
> https://www.kernel.org/doc/Documentation/DMA-API-HOWTO.txt
> arch/arm/include/asm/dma-iommu.h
>
> Or maybe there is an obvious solution that I'm missing?
>

I don't think there is an easy solution right now. This is still
an open problem as far as I know. You might look into whether
marking one of the regions as a CMA region would allow you the
control you need.

Thanks,
Laura
