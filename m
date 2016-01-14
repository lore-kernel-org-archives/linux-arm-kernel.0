From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 14 Jan 2016 09:37:49 +0530
Subject: [PATCH V2 3/8] dmaengine: bcm2835: use shared interrupt for
 channel 11 to 14.
In-Reply-To: <56965E3B.7060104@martin.sperl.org>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
 <1452187987-2605-4-git-send-email-kernel@martin.sperl.org>
 <20160113122621.GA11130@localhost>
 <56965178.7070700@martin.sperl.org>
 <20160113134338.GH11130@localhost>
 <56965E3B.7060104@martin.sperl.org>
Message-ID: <20160114040749.GJ11130@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 03:24:59PM +0100, Martin Sperl wrote:
> >>But that would be frowned upon, so I had to come up with the approach
> >>taken, which makes the following assumptions:
> >
> >DT was designed to move this info and hardcoding from kernel into
> >DT, so why cant we do that?
> We still need to be backwards-compatible - at least that is what
> everyone tells me, so I need to hard-code fallbacks for those values.

IMO hard code for falling back is okay as that supports old cases and new
platforms use geric DT info and new devices can be supported generically,
please check with DT folks..

> >>* the DT maps only the interrupts that are assigned to the HW block
> >>* the driver knows about the number of DMA channels in HW
> that could be a DT property, yes.
> >>* the driver knows about the mapping of shared interrupts
> >>   (11-14 share irq).
> OK - how would you define that "mapping" in a "sane" manner in the DT
> that allows us to have multiple such mappings in the future?

You are hard coding the flags for each channel, we can pass this for each
channel in the interrupt configi, a flag share/none..? Please run this thru
DT experts and I am not one of them..

> >>It is not optimal, but at least it works with the least amount of
> >>change to the DT - and what about all those assumptions that we
> >>would need to hard-code to be backwards compatible to the DT without?
> >>
> >>I guess we could replace BCM2835_DMA_MAX_CHANNEL_NUMBER with:
> >>   /* we do not support dma channel 15 with this driver */
> >>   #define BCM2835_DMA_MAX_CHANNEL_SUPPORTED 14
> >>   ...
> >>   for (i = 0;
> >>        i <= min_t(int, flv(chans_available),
> >>BCM2835_DMA_MAX_CHANNEL_SUPPORTED);
> >>        i++) {
> >>
> >>So which way would you prefer this to go - I got another few days
> >>before I leave on vacation.
> >
> >I still think DT is the right way to go here, unless I hear some other
> >convincing answer..
> >
> 
> The point is that the way the DT is right now it becomes very hard to
> extend it in a sane manner - It would be bitmaps/lists here,
> bitmaps/lists there...
> 
> Breaking the DT would make all of it go away.
> 
> If I think of it (reading your other comments), then here how the
> "new" DT could look like:
> dma: dma at 7e007f00 {
> 	/* new compatible name to map to new driver */
> 	compatible = "brcm,bcm2835-dma-v2";
> 
> 	/* the status/enable registers */
> 	reg = <0x7e007f00 0x100>;
> 
> 	/* the catch all interrupt */
> 	interrupts = <1 28>;
> 
> 	dma0: dma-channel at 0x7e007000 {
> 		reg = <0x7e007000 0x100>;
> 		interrupts = <1 16>;
> 	};
> 	...
> 	dma7: dma-channel at 0x7e007700 {
> 		reg = <0x7e007700 0x100>;
> 		interrupts = <1 23>;
> 		dma-channel-type = <BCM2835_DMA_LITE>;
> 		dma-max-length = <65532>; /* 64K - 4 */
> 	};
> 	...
> 	dma11: dma-channel at 0x7e007b00 {
> 		reg = <0x7e007b00 0x100>;
> 		interrupts = <1 27>;
> 		shared-interrupt;
> 		dma-channel-type = <BCM2835_DMA_LITE>;
> 	};
> 	...
> 	dma14: dma-channel at 0x7e007e00 {
> 		reg = <0x7e007e00 0x100>;
> 		interrupts = <1 27>;
> 		shared-interrupt;
> 		dma-channel-type = <BCM2835_DMA_LITE>;
> 	};
> 	dma15: dma-channel at 0x7ee05000 {
> 		reg = <0x7ee05000 0x100>;
> 	};
> };

This looks okay to me to start with...

> 
> Adding additional "features" would make it easy like:
> * dma-channel priority on AXI bus
> * setting warn/alert levels for DREQs
> * eventually mapping of drivers to the explicit dma channel
>   e.g: SPI has a limit of 65534 bytes per dma transfer in HW,
>   so the use of a DMA-LITE engine would be sufficient - no need
>   to waste a "normal" DMA-engine with 2D support,...
>   So the spi dt node  could then look like this:
>     dmas = <&dma11 BCM2835_DREQ_SPI_TX>, <&dma12 BCM2835_DREQ_SPI_RX>;
>     dma-names = "tx", "rx";
> 
> Is this the approach I should try to take?
> 
> Or do you want me to continue on the "patchwork" route:
> dma: dma at 7e007000 {
> 	interrupt-names = "dma0", ..., "dma10", "shared", "catch-all";
> 
> 	bcrm,dma-lite-channel-mask = <0x7f80>;
> 	bcrm,dma-max-channels = 14;
> 
> 	bcrm,catch-all-interrupt-name = "catch-all";
> 	bcrm,shared-interrupt-name = "shared";
> 	bcrm,shared-interrupt-channel-mapping = <0x7800>;
> }
> 
> For all of the above we would need to define defaults in the driver
> to make it work in a backwards compatible way.
> 
> That would not support the registers for each dma channel and not lend
> itself towards extending only via the DT - say support DMA channel 15.
> 
> I have another 5 days before I leave on vacation - there is only so
> much I can do...
> 
> Thanks,
> 	Martin

-- 
~Vinod
