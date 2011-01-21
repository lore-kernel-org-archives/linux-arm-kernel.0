From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 21:51:10 +0000
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <alpine.LFD.2.00.1101211456200.8580@xanadu.home>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
	<alpine.LFD.2.00.1101211456200.8580@xanadu.home>
Message-ID: <20110121215110.GD23151@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 02:59:35PM -0500, Nicolas Pitre wrote:
> On Fri, 21 Jan 2011, Pawel Moll wrote:
> 
> > VE suffers from serious problem with MMC transfers - low performance,
> > errors when other IO peripherals (especially USB) are used at the
> > same time etc.
> > 
> > It all boils down to the MMC controller short FIFO and - in result -
> > timing constrains. The most problematic case - USB driver hogging
> > CPU and MMC FIFO under/overruns in the result - can be mitigated on
> > SMP system by distributing interrupts handling for these peripherals
> > between cores.
> 
> Wouldn't the ultimate solution be to simply use FIQs to service the MMC FIFO?

Could you suggest how to route an arbitary interrupt to the FIQ using
the GIC?

On systems which implement security extensions, the non-secure world can
only use IRQs and not FIQs.  The secure world can use FIQs - in which
case interrupts marked as secure interrupts can go to FIQ.

On systems without security extensions, the GIC only supports IRQ, and
you need a second GIC implemented for FIQs.  I'm not aware of any system
doing that.
