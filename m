From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Wed, 2 Apr 2014 11:33:22 +0000
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140402104644.GI7528@n2100.arm.linux.org.uk>
References: <201403242121.58705.marex@denx.de>
 <OF5A7B7FA4.2FEB0248-ON87257CA5.007AE2AE-87257CA5.007C44DB@grpleg.it>
 <20140324234443.GS7528@n2100.arm.linux.org.uk>
 <20140326001135.GV7528@n2100.arm.linux.org.uk>
 <20140401092638.GA10224@n2100.arm.linux.org.uk>
 <OF15BAA4F9.E675BBEF-ON87257CAD.006812E9-87257CAD.006BE81E@grpleg.it>
 <20140401225149.GC7528@n2100.arm.linux.org.uk>
 <b974be3a995f41029b54cfcc10c732ef@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402085914.GG7528@n2100.arm.linux.org.uk>
 <deb03b2af59a4fe7a46bc66278335826@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402104644.GI7528@n2100.arm.linux.org.uk>
Message-ID: <ebffe60db89d45ce883b1b9aff121152@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Data: Wednesday, April 02, 2014 6:47 PM

>To: Duan Fugang-B38611
>Cc: robert.daniels at vantagecontrols.com; Marek Vasut; Detlev Zundel; Troy Kisky;
>Grant Likely; Bernd Faust; Fabio Estevam; linux-arm-kernel at lists.infradead.org
>Subject: Re: FEC ethernet issues [Was: PL310 errata workarounds]
>
>On Wed, Apr 02, 2014 at 09:40:53AM +0000, fugang.duan at freescale.com wrote:
>> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
>> Data: Wednesday, April 02, 2014 4:59 PM
>> >I wonder whether you understand what is going on here, and why it is
>required.
>> >I doubt it somehow from your comments.  Maybe if you were to read
>> >about the operation of the store buffer in the PL310, it may open
>> >your eyes to why it would be necessary for reliable operation.
>>
>> In kernel 3.0.35 internal BSP,  BD memory is non-cacheable,
>> non-bufferable (we add new api to support it:
>> dma_alloc_noncacheable()),
>
>As is the memory you get from dma_alloc_coherent().  So, why did you invent a
>new API which does something which the mainline kernel APIs already do?
>
>Maybe yours is doing something different but you haven't explained it in
>correct terminology.

In kernel 3.0.35, there have no CMA memory allocate mechanism.
Below Kernel configs are enabled:
CONFIG_ARM_DMA_MEM_BUFFERABLE
CONFIG_SMP

If use dma_alloc_coherent() allocate memory, it must be non-cacheable, but bufferable.
The new invented api "dma_alloc_noncacheable()" allocate memory is non-cacheable, non-bufferable, the memory type is Strongly ordered.

>
>> So wmb() is not necessary.
>
>Even on non-cacheable normal memory, the wmb() is required.  Please read up in
>the ARM architecture reference manual about memory types and their various
>attributes, followed by the memory ordering chapters.
>
>> Yes, it don't impact imx6q since cpu loading is not bottleneck due
>> rx/tx bandwidth is slow and multi-cores.  But for imx6sx, enet rx can
>> reach at 940Mbps, tx can reach at 900Mbps, imx6sx is sigle core.
>
>What netdev features do you support to achieve that?
>
Imx6sx enet accleration feature support crc checksum, interrupt coalescing.
So we enable the two features.

>> Enet IP don't support TSO feaure, cpu loading is the bottleneck. Wmb()
>> is very expensive which cause tx performance drop much.
>
>wmb() is very expensive because of the L2 cache code using a sledge hammer with
>it - particularly the spinlock, which has a large overhead if lockdep or
>spinlock debugging is enabled.
>
Yes, if add wmb() to xmit(), imx6sx enet performance will drop more than 100Mbps.

[...]

Thanks,
Andy
