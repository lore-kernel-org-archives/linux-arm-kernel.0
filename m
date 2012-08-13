From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Aug 2012 10:32:01 +0100
Subject: [PATCH 0/9] ARM perf updates for 3.7
In-Reply-To: <5028C4C9.6020002@gmail.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
 <5028C4C9.6020002@gmail.com>
Message-ID: <20120813093201.GB19113@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 10:11:37AM +0100, Hui Wang wrote:
> Hi Will Deacon,

Hello,

> For SMP platforms, each CPU core has an independent PMU, and each PMU 
> has a dedicated irq (SPI or PPI). Current perf subsystem framework only 
> supports each PMU to have a dedicated SPI irq, and it will support each 
> PMU to have a PPI irq (i have seen someone has sent out the patches), 
> but there is a situation the subsystem doesn't support yet, the 
> situation is multi PMUs share one same SPI irq, e.g. the i.MX6Quad CPU 
> has 4 cortex-a9 cores, each core has a PMU, all PMU irqs are routed 
> (ORed) to one SPI irq, do you know how to support this situation?

That's what I like to call a braindead, broken system. Seriously, CPU PMU
interrupts *can only* be handled on the CPU which raised them -- ORing these
things together means ping-ponging the interrupt affinity around until we
find the right guy. There's also the fun case where multiple PMUs assert
simultaneously and I've even heard about platforms where they OR in the
bloody L2 PMU interrupt as well for good measure!

If you have to support such a device, take a look at the ux500 code
(db8500_pmu_handler), but please take all of your profiling numbers with a
pinch of salt. For a quad-core processor, the numbers will probably be even
less accurate.

Also, please go ahead and inflict sufficient injuries to your hardware guys
that they stop this madness!

Will
