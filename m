From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Sep 2015 18:48:35 +0100
Subject: [PATCH v4 1/2] ARM: dma-mapping: Don't use outer_flush_range
 when the L2C is coherent
In-Reply-To: <20150929193031.72bbebe8@free-electrons.com>
References: <1443545458-14807-1-git-send-email-gregory.clement@free-electrons.com>
 <1443545458-14807-2-git-send-email-gregory.clement@free-electrons.com>
 <20150929171054.GN21513@n2100.arm.linux.org.uk>
 <20150929193031.72bbebe8@free-electrons.com>
Message-ID: <20150929174835.GO21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 07:30:31PM +0200, Thomas Petazzoni wrote:
> Hello Russell,
> 
> On Tue, 29 Sep 2015 18:10:54 +0100, Russell King - ARM Linux wrote:
> 
> > > In the current kernel implementation, the outer cache flush range
> > > operation is triggered by the dma_alloc function.
> > > This operation can be take place during runtime and in some
> > > circumstances may lead to the PCIe/PL310 deadlock on Armada 375/38x
> > > SoCs.
> > 
> > I wonder if that's what's causing the sporadic lockups I'm seeing on
> > 38x with a SATA PCIe card - it happens at a very specific point during
> > boot while initialising the SATA card, right down to the kernel message
> > character that it stops at.
> 
> It might very well be the case. If there's enough PCIe traffic and a
> PL310 cache maintenance operation happening at the same time, the
> system will lockup. I'm a bit surprised that just the initialization of
> the PCIe card generates enough traffic to trigger the deadlock, but
> maybe I'm underestimating the problem.

It isn't every boot - the board has booted around 240 kernels so far and
maybe 5% of them have needed the reset button pressed because of this.
It only happens when I have the SATA card connected.  I don't have any
drives on the SATA card at the moment though.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
