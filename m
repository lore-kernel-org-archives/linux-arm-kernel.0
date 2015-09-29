From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Sep 2015 18:10:54 +0100
Subject: [PATCH v4 1/2] ARM: dma-mapping: Don't use outer_flush_range
 when the L2C is coherent
In-Reply-To: <1443545458-14807-2-git-send-email-gregory.clement@free-electrons.com>
References: <1443545458-14807-1-git-send-email-gregory.clement@free-electrons.com>
 <1443545458-14807-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150929171054.GN21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 06:50:57PM +0200, Gregory CLEMENT wrote:
> When a L2 cache controller is used in a system that provides hardware

You're talking about L2 cache here, but you're also masking out the L1
cache maintanence (dmac_*) too.  It's my understanding that we don't
yet support coherency to L1 yet.

> In the current kernel implementation, the outer cache flush range
> operation is triggered by the dma_alloc function.
> This operation can be take place during runtime and in some
> circumstances may lead to the PCIe/PL310 deadlock on Armada 375/38x
> SoCs.

I wonder if that's what's causing the sporadic lockups I'm seeing on
38x with a SATA PCIe card - it happens at a very specific point during
boot while initialising the SATA card, right down to the kernel message
character that it stops at.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
