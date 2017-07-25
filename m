From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 25 Jul 2017 07:19:56 +0200 (CEST)
Subject: No Ethernet on Raspberry Pi 3 in v4.13-rc1
In-Reply-To: <b849a4dc-a095-6bb4-caf1-a1f7470bed91@arm.com>
References: <5650979e-ea55-0337-2edd-d2c3e8ad0e37@suse.de>
 <b849a4dc-a095-6bb4-caf1-a1f7470bed91@arm.com>
Message-ID: <1435162494.87709.1500959996834@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

> Robin Murphy <robin.murphy@arm.com> hat am 24. Juli 2017 um 13:22 geschrieben:
> 
> 
> Hi Andreas,
> 
> On 22/07/17 13:29, Andreas F?rber wrote:
> > Hello,
> > 
> > With arm64 4.13-rc1 I get no eth0 device on Pi3 (openSUSE Tumbleweed).
> > The v4.13-rc1 DT works okay with a 4.12 kernel.
> > 
> > Possibly related:
> > 
> > [   15.916350] OF: /soc/usb at 7e980000: could not get #phy-cells for /phy
> > 
> > [   16.496662] usb 1-1: new high-speed USB device number 2 using dwc2
> > [   16.502988] dwc2 3f980000.usb: Cannot do DMA to address
> > 0x00000000335da400
> 
> This is from SWIOTLB's map_single(), which means whatever device was
> passed into dma_map_single() when mapping the URB had a DMA mask smaller
> than 30 bits (or none at all), which sounds wrong and is almost
> certainly the root of the problem (i.e. it probably wasn't the actual
> HCD device described in DT and set up by of_dma_configure()). 

how can i figure out what's cause this issue (bcm283x or dwc2 specific)?

The dwc2 hcd already check the DMA mask on probe [1] and i never saw a warning in error case.

Regards
Stefan

[1] - http://elixir.free-electrons.com/linux/latest/source/drivers/usb/dwc2/hcd.c#L5096

> However,
> arm64's __swiotlb_map_page() still shouldn't be trying to perform cache
> maintenance on the error value returned, which looks to be where the
> actual splat below hails from - leave that one with me ;)
> 
> Robin.
>
