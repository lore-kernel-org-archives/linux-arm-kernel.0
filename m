From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Apr 2012 13:18:55 +0300
Subject: [PATCH 1/8] ARM: OMAP: fix DMA vs memory ordering
In-Reply-To: <20120418101733.GL25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRqN-0004b4-Me@rmk-PC.arm.linux.org.uk>
 <20120418101519.GU13842@arwen.pp.htv.fi>
 <20120418101733.GL25053@n2100.arm.linux.org.uk>
Message-ID: <20120418101854.GV13842@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 11:17:33AM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 18, 2012 at 01:15:20PM +0300, Felipe Balbi wrote:
> > On Wed, Apr 18, 2012 at 11:10:35AM +0100, Russell King wrote:
> > > Using coherent DMA memory with the OMAP DMA engine results in
> > > unpredictable behaviour due to memory ordering issues; as things stand,
> > > there is no guarantee that data written to coherent DMA memory will be
> > > visible to the DMA hardware.
> > > 
> > > This is because the OMAP dma_write() accessor contains no barriers,
> > > necessary on ARMv6 and above.  The effect of this can be seen in comments
> > > in the OMAP serial driver, which incorrectly talks about cache flushing
> > > for the coherent DMA stuff.
> > > 
> > > Rather than adding barriers to the accessors, add it in the DMA support
> > > code just before we enable DMA, and just after we disable DMA.  This
> > > avoids having barriers for every DMA register access.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > cool, should this go to stable too ?
> 
> Has anyone seen a problem (other than me when trying to get DMA engine
> working with omap-serial transmit paths) ?

probably not since omap-serial isn't using DMA anyway. Nevermind

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/1da5c157/attachment.sig>
