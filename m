From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Apr 2012 15:19:24 +0100
Subject: [PATCH 1/8] ARM: OMAP: fix DMA vs memory ordering
In-Reply-To: <20120420222230.GH21106@atomide.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRqN-0004b4-Me@rmk-PC.arm.linux.org.uk>
 <20120420222230.GH21106@atomide.com>
Message-ID: <20120423141924.GB24299@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 03:22:33PM -0700, Tony Lindgren wrote:
> * Russell King <rmk+kernel@arm.linux.org.uk> [120418 03:14]:
> > Using coherent DMA memory with the OMAP DMA engine results in
> > unpredictable behaviour due to memory ordering issues; as things stand,
> > there is no guarantee that data written to coherent DMA memory will be
> > visible to the DMA hardware.
> > 
> > This is because the OMAP dma_write() accessor contains no barriers,
> > necessary on ARMv6 and above.  The effect of this can be seen in comments
> > in the OMAP serial driver, which incorrectly talks about cache flushing
> > for the coherent DMA stuff.
> > 
> > Rather than adding barriers to the accessors, add it in the DMA support
> > code just before we enable DMA, and just after we disable DMA.  This
> > avoids having barriers for every DMA register access.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Would you like me to push this upstream on my next -rc push (with a
stable tag?)
