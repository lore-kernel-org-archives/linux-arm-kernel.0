From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 23 Apr 2012 18:02:52 +0530
Subject: [RFC 0/8] DMA engine conversion
In-Reply-To: <20120423114615.GB25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <20120423114615.GB25053@n2100.arm.linux.org.uk>
Message-ID: <CAMQu2gyQ3928VQ9Q9Y0mNiacB+br2oGezGCvhLXikbOTi-JR3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 5:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Here's a patch which converts the SPI driver to use dma engine support.
> It's more or less a mechanical replacement in this driver. ?Tested on
> OMAP4430SDP ethernet (which basically means that udhcpc works.)
>
> One thing to note: the old DMA code programmed the DMA hardware for an
> element count of N and frame size of 1, with element sync. ?The DMA
> engine code will program the DMA hardware for an element count of 1 and
> a frame size of N, with frame sync. ?This appears to work - but at the
> moment I've not looked to see if there's any implications of this.
>
> You can enable/disable the DMA engine code for the TX or RX side by
> tweaking the two definitions at the top of the file if you want to do
> comparisons.
>
> Comments? ?If none, I'll see about committing this into the patch set,
> adding the removal of the private DMA code, and sending it out more
> "officially" with the next round of RFC for this set.
>
Element sync vs Frame sync change seems to be fine thought it's
bit puzzling that why it was not that way first place.

> Modulo the element vs frame sync issue, I think folk can see that the
> conversion process is fairly straight forward - it's more or less:
> 1. add struct dma_chan * pointer to the private structure.
> 2. add allocation/freeing functions for the DMA engine channels.
> 3. convert the callbacks to match the DMA engine callback prototype.
> 4. add code to set the DMA engine channel configuration appropriately
> ? (avoiding any unnecessary calls) via dmaengine_slave_config().
> 5. add code to queue the transfer via dmaengine_prep_slave_sg() and
> ? dmaengine_submit().
> 6. omap_start_dma() becomes dma_async_issue_pending().
>
> ?drivers/spi/spi-omap2-mcspi.c | ?186 +++++++++++++++++++++++++++++++++-------
> ?1 files changed, 153 insertions(+), 33 deletions(-)

The patch seems to be fine to me.

Am looping Shubro in case he has any comment on "why element sync was used ?"
and also to test the patch with more peripherals connected over SPI.

Regards
Santosh
