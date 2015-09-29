From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Sep 2015 19:30:31 +0200
Subject: [PATCH v4 1/2] ARM: dma-mapping: Don't use outer_flush_range
 when the L2C is coherent
In-Reply-To: <20150929171054.GN21513@n2100.arm.linux.org.uk>
References: <1443545458-14807-1-git-send-email-gregory.clement@free-electrons.com>
 <1443545458-14807-2-git-send-email-gregory.clement@free-electrons.com>
 <20150929171054.GN21513@n2100.arm.linux.org.uk>
Message-ID: <20150929193031.72bbebe8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Tue, 29 Sep 2015 18:10:54 +0100, Russell King - ARM Linux wrote:

> > In the current kernel implementation, the outer cache flush range
> > operation is triggered by the dma_alloc function.
> > This operation can be take place during runtime and in some
> > circumstances may lead to the PCIe/PL310 deadlock on Armada 375/38x
> > SoCs.
> 
> I wonder if that's what's causing the sporadic lockups I'm seeing on
> 38x with a SATA PCIe card - it happens at a very specific point during
> boot while initialising the SATA card, right down to the kernel message
> character that it stops at.

It might very well be the case. If there's enough PCIe traffic and a
PL310 cache maintenance operation happening at the same time, the
system will lockup. I'm a bit surprised that just the initialization of
the PCIe card generates enough traffic to trigger the deadlock, but
maybe I'm underestimating the problem.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
