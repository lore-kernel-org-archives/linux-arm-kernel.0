From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 2 Apr 2013 10:14:10 +0200
Subject: [RFC] dmaengine: omap-dma: Start DMA without delay
In-Reply-To: <20130329173100.GV30923@n2100.arm.linux.org.uk>
References: <1364566323-24144-1-git-send-email-peter.ujfalusi@ti.com>
 <20130329173100.GV30923@n2100.arm.linux.org.uk>
Message-ID: <515A9352.5060702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 03/29/2013 06:31 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 29, 2013 at 03:12:03PM +0100, Peter Ujfalusi wrote:
>> Remove the use of a tasklet to start the DMA channel when issue_pending is
>> called.
>> The use of tasklet delays the DMA start which can cause issues at drivers,
>> for example the audio drivers expect that the DMA is started right away.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi Russell,
>>
>> I know you are against removing the tasklet since you have planed to move the
>> omap-dma to use runtime/dynamic DMA channel use.
>> I have looked at the amba-pl08x.c driver which is doing that exactly (as you
>> pointed out that to me). AMBA did not use tasklet either and I'm sure we can
>> change the omap-dma driver to do the same in a same way as we could have done it
>> with the tasklet use.
> 
> It's rather sad that you're ignoring what I'm saying, and going by what
> another DMA engine driver - which is self contained - is doing, rather
> than listening to my arguments against that approach.

The reason I send this as RFC to start a discussion to find out how we should
handle this. I were to ignore what you were saying I would have just sent a
PATCH instead.

I don't think that the tasklet is the solution for the runtime DMA channel
selection. We can do it in a same way as AMBA has been doing. In this way we
can handle all cases with the same code.
The pre-allocating of channels and starting the DMA right away is different issue.

What need to be done anyway is to convert the remaining drivers to use dmaengine:
drivers/usb/musb/tusb6010_omap.c
drivers/usb/gadget/omap_udc.c
drivers/mtd/onenand/omap2.c
drivers/media/platform/omap3isp/isphist.c
drivers/media/platform/soc_camera/omap1_camera.c
drivers/media/platform/omap/omap_vout_vrfb.c

When that is done we can remove the arch/arm/plat-omap/dma.c and migrate the
code under dmaengine to restructure it and finally we can have runtime channel
allocation.

-- 
P?ter
