From: roy.pledge@nxp.com (Roy Pledge)
Date: Fri, 23 Jun 2017 18:58:17 +0000
Subject: [GIT PULL v3] updates to qbman (soc drivers) to support arm/arm64
References: <HE1PR0401MB17071A7853695DB6546FE28C8FC50@HE1PR0401MB1707.eurprd04.prod.outlook.com>
 <CAK8P3a2EvCvs57hE_X9J5jg6jW8jPh6gxaTOUYntbnHdb_cMZA@mail.gmail.com>
 <20170623152227.GA21989@leverpostej>
Message-ID: <DB6PR04MB2999E8FFBE0FE708A003637986D80@DB6PR04MB2999.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/23/2017 11:23 AM, Mark Rutland wrote:
> On Fri, Jun 23, 2017 at 04:56:10PM +0200, Arnd Bergmann wrote:
>> On Tue, Jun 20, 2017 at 7:27 PM, Leo Li <leoyang.li@nxp.com> wrote:
>>> v2: Removed the patches for MAINTAINERS file as they are already picked
>>> up by powerpc tree.
>>>
>>> v3: Added signed tag to the pull request.
>>>
>>> Hi arm-soc maintainers,
>>>
>>> As Scott has left NXP, he agreed to transfer the maintainership of
>>> drivers/soc/fsl to me.  Previously most of the soc drivers were going
>>> through the powerpc tree as they were only used/tested on Power-based
>>> SoCs.  Going forward new changes will be mostly related to arm/arm64
>>> SoCs, and I would prefer them to go through the arm-soc tree.
>>>
>>> This pull request includes updates to the QMAN/BMAN drivers to make
>>> them work on the arm/arm64 architectures in addition to the power
>>> architecture.
>>>
>>> DPAA (Data Path Acceleration Architecture) is a set of hardware
>>> components used on some FSL/NXP QorIQ Networking SoCs, it provides the
>>> infrastructure to support simplified sharing of networking interfaces
>>> and accelerators by multiple CPU cores, and the accelerators
>>> themselves.  The QMan(Queue Manager) and BMan(Buffer Manager) are
>>> infrastructural components within the DPAA framework.  They are used to
>>> manage queues and buffers for various I/O interfaces, hardware
>>> accelerators.
>>>
>>> More information can be found via link:
>>> http://www.nxp.com/products/microcontrollers-and-processors/power-architecture-processors/qoriq-platforms/data-path-acceleration:QORIQ_DPAA
>> Hi Leo,
>>
>> sorry for taking you through yet another revision, but I have two
>> more points here:
>>
>> 1. Please add a tag description whenever you create a signed tag. The
>> description is what ends up in the git history, and if there is none, I have
>> to think of something myself. In this case, the text above seems
>> roughly appropriate, so I first copied it into the commit log, but then
>> noticed the second issue:
>>
>> 2. I know we have discussed the unusual way this driver accesses MMIO
>> registers in the past, using ioremap_wc() to map them and the manually
>> flushing the caches to store the cache contents into the MMIO registers.
>> What I don't know is whether there was any conclusion on this topic whether
>> this is actually allowed by the architecture or at least the chip, based on
>> implementation-specific features that make it work even when the architecture
>> doesn't guarantee it.
> From prior discussions, my understanding was that the region in question
> was memory reserved for the device, rather than MMIO registers.
>
> The prior discussion on that front were largely to do with teh
> shareability of that memory, which is an orthogonal concern.
>
> If these are actually MMIO registers, a Device memory type must be used,
> rather than a Normal memory type. There are a number of things that
> could go wrong due to relaxations permitted for Normal memory, such as
> speculative reads, the potential set of access sizes, memory
> transactions that the endpoint might not understand, etc.
The memory for this device (what we refer to as Software Portals) has 2
regions. One region is MMIO registers and we access it using
readl()/writel() APIs.

The second region is what we refer to as the cacheable area.  This is
memory implemented as part of the QBMan device and the device accepts
cacheline sized transactions from the interconnect. This is needed
because the descriptors read and written by SW are fairly large (larger
that 64 bits/less than a cacheline) and in order to meet the data rates
of our high speed ethernet ports and other accelerators we need the CPU
to be able to form the descriptor in a CPU cache and flush it safely
when the device is read to consume it.  Myself and the system architect
have had many discussions with our design counterparts in ARM to ensure
that our interaction with the core/interconnect/device are safe for the
set of CPU cores and interconnects we integrate into our products.

I understand there are concerns regarding our shareablity proposal
(which is not enabled in this patch set). We have been collecting some
information and talking to ARM and I do intend to address these concerns
but I was delaying confusing things more until this basic support gets
accepted and merged.
>> Can I have an Ack from the architecture maintainers (Russell, Catalin,
>> Will) on the use of these architecture specific interfaces?
>>
>> static inline void dpaa_flush(void *p)
>> {
>> #ifdef CONFIG_PPC
>>         flush_dcache_range((unsigned long)p, (unsigned long)p+64);
>> #elif defined(CONFIG_ARM32)
>>         __cpuc_flush_dcache_area(p, 64);
>> #elif defined(CONFIG_ARM64)
>>         __flush_dcache_area(p, 64);
>> #endif
>> }
> Assuming this is memory, why can't the driver use the DMA APIs to handle
> this without reaching into arch-internal APIs?
I agree this isn't pretty - I think we could use
dma_sync_single_for_device() here but I am concerned it will be
expensive and hurt performance significantly. The DMA APIs have a lot of
branches. At some point we were doing 'dc cvac' here and even switching
to the above calls caused a measurable drop in throughput at high frame
rates.
>
> Thanks,
> Mark.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
