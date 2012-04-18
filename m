From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Apr 2012 21:24:47 +0100
Subject: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
In-Reply-To: <20120418200214.GP21106@atomide.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk>
 <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com>
 <20120418152956.GP25053@n2100.arm.linux.org.uk>
 <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com>
 <20120418194224.GS25053@n2100.arm.linux.org.uk>
 <20120418200214.GP21106@atomide.com>
Message-ID: <20120418202447.GT25053@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 01:02:15PM -0700, Tony Lindgren wrote:
> The scatterlist entries are separate DMA requests on omap1, there's no
> chaining support in the DMA hardware on omap1. So yes, it's for every
> scatterlist entry on omap1.

There's no direct scatterlist support on OMAP2 either (omap_hsmmc _used_
to do each scatterlist entry separately too).  The DMA engine driver
does the same, but will walk the scatterlist internally rather than the
driver having to do it.

I'd like to have the same thing happen on OMAP1 as well (it's actually
quite simple to do) and it means that this DMA engine implementation
detail is (correctly) hidden from the drivers - provided there's no
dependencies on each individual scatterlist entry back to the peripheral
driver.
