From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Feb 2010 15:24:02 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <1266937966.3123.121.camel@e102109-lin.cambridge.arm.com>
References: <20100223110105.11048.8143.stgit@e102109-lin.cambridge.arm.com>
	<20100223111036.GA10501@n2100.arm.linux.org.uk>
	<1266927403.3123.56.camel@e102109-lin.cambridge.arm.com>
	<20100223123040.GC10501@n2100.arm.linux.org.uk>
	<1266937966.3123.121.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100223152402.GF10501@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 03:12:46PM +0000, Catalin Marinas wrote:
> The scenario I have in mind is when using mb() in relation with DMA
> coherent mappings. We only use Normal Uncached for this case on ARMv7.
> Earlier architectures, including ARMv6 SMP, we use strongly ordered
> which would be fine without any barrier.
> 
> Since mb() isn't meant for SMP use, does it still make sense to have it
> defined in the ARMv6 SMP case? Would people not use the smp_* variants?

Part of the reason for that is that smp_mb() are, afaik, supposed to be
as strong as mb() in the SMP case, or reduce to compiler barriers in the
UP case.

I'm not entirely convinced by the part of your patch which changes the
SMP barriers yet.  For instance, some drivers contain:

                /* We need for force the visibility of tp->intr_mask
                 * for other CPUs, as we can loose an MSI interrupt
                 * and potentially wait for a retransmit timeout if we don't.
                 * The posted write to IntrMask is safe, as it will
                 * eventually make it to the chip and we won't loose anything
                 * until it does.
                 */
                tp->intr_mask = 0xffff;
                smp_wmb();
                RTL_W16(IntrMask, tp->intr_event);

The second write is a write to hardware, and thus would be to a device
region.  The first is a write to a memory structure.

It seems to me given your description in the patch, that having smp_wmb()
be a dmb(), rather than a wmb() would be insufficient here.
