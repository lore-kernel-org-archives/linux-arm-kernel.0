From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Aug 2011 00:36:48 +0100
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <Pine.LNX.4.44L0.1108281233270.3742-100000@netrider.rowland.org>
References: <CACVXFVP8Lr=ggH4FjvMQd6r9poLAT1r+_S3Z-NimP0i08DsQ8g@mail.gmail.com>
	<Pine.LNX.4.44L0.1108281233270.3742-100000@netrider.rowland.org>
Message-ID: <20110828233648.GA14560@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 28, 2011 at 01:00:07PM -0400, Alan Stern wrote:
> It won't do that.  All it will do is guarantee that the CPU writes out 
> dumy->hw_token before it writes out or reads in any values executed 
> after the mb.

You're right from the perspective of how things are defined today.  However,
that isn't how things work on ARM.

With ARMv6 and ARMv7, we have weak memory ordering.  This includes so
called "DMA coherent" memory.  This means that the architecture does not
guarantee the order of writes to DMA coherent memory (which is non-
cacheable normal memory) without an intervening 'data synchronization
barrier' (dsb).  Even that may not be sufficient without also poking
at the L2 cache controller.

We get around some of that by ensuring that our MMIO read/write macros
contain the necessary barriers to ensure that DMA memory is up to date
before the DMA agent is programmed.  However, this doesn't cater for
agents which continue to run in the background.

These agents will need some kind of barrier to ensure that the write
becomes visible - there's no way to get around that.  Maybe we need
yet another new barrier macro...
