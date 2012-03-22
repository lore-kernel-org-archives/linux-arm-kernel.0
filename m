From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 22 Mar 2012 09:37:50 +0200
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020696D48AB1@AUSP01VMBX24.collaborationhost.net>
References: <4F683B36.8090101@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F0020696D488E3@AUSP01VMBX24.collaborationhost.net>
 <20120321193231.GA3740@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48AB1@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20120322073750.GA637@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 07:47:52PM -0500, H Hartley Sweeten wrote:

> I think you misunderstood my comment above.
> 
> With this patch applied I get the "unknown interrupt!" storm. These messages
> keep getting spewed until I power off the board.

Ah, right you are. Sorry.

With my Sim.One board, I don't see any interrupt storms at all and I also have
mmc_spi with DMA enabled.

> Without this patch I get the "got interrupt while active list is empty" messages
> but only occasionally. Other than the messages the mmc_spi driver seems to
> be working ok with dma.
> 
> I hacked in a dump of the DMA Global Interrupt register when I get the
> "got interrupt while active list is empty" messages and get this:
> 
> dma dma1chan1: got interrupt while active list is empty (00000000)

In addition to these messages my board hangs almost every boot.

> So, according to the DMAGlInt register, there are no channels with an
> active interrupt.
> 
> Are we missing a write to the INTERRUPT registers somewhere to clear the
> current interrupt?

In the current code we only enable DONE interrupt and we always clear that at
the beginning of the ISR.

The VIC code was changed in 3.3. Its behaviour is different now as it tries to
handle as many IRQs as possible in one go whereas before it only handled one
IRQ at a time. Could it be that the VIC in ep93xx doesn't cope with that?
