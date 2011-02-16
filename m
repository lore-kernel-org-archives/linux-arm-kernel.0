From: swetland@google.com (Brian Swetland)
Date: Wed, 16 Feb 2011 15:06:06 -0800
Subject: [RFC] MMC: error handling improvements
In-Reply-To: <AANLkTimQqGVTwUv4ywQnmd4Z1Ur4vWk2sK5+ZLa4mmTs@mail.gmail.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	<8yaoc6c7tan.fsf@huya.qualcomm.com>
	<AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
	<8ya8vxf4w4w.fsf@huya.qualcomm.com>
	<AANLkTimQqGVTwUv4ywQnmd4Z1Ur4vWk2sK5+ZLa4mmTs@mail.gmail.com>
Message-ID: <AANLkTikDxOeW9Nfaew_mZLnVJ6e7pyzQTNs139g_AehW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 1:01 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/2/16 David Brown <davidb@codeaurora.org>:
>>?The driver doesn't directly
>> access the registers of the controller, but all accesses go through a
>> custom DMA engine.
>> (...)
>> The SDCC block is shared between
>> the modem processor and the processor running Linux. ?If the driver
>> doesn't go through the DMA engine, which coordinates this, the registers
>> will be stomped on by the other CPU whenever it decides to access it's
>> parts of the flash device.
>
> That's significant, I agree. That the DMA engine is custom
> instead of using the <linux/dmaengine.h> interface is not
> making things easier, but it's another issue. If it did, I think it
> could quite easily use mmci.c.
>
> At the same time what you're saying sounds very weird:
> the ios handler in mmc_sdcc does not request any DMA
> channel before messing with the hardware, it simply just write
> into registers very much in the style of mmci.c. Wouldn't that
> disturb any simultaneous access to the MMC from another
> CPU?

On MSM7x01,7x2x,8x50,8x55,7x30 the overall design involves both the
baseband cpu (running AMSS) and the apps cpu (running Linux) sharing a
single SDCC to read/write different partitions on NAND.

The way register access for the SDCC is synchronized between these two
cores is by using a locking primitive built into the MSM DMA
controller.  If you don't use this indirect access model (via DMA
transactions to the registers), you end up tripping over the baseband
or the other way 'round.  It's not fun.

Later Qualcomm chipsets move away from this model (yay) and that
should simplify things quite a bit.

Brian

>
> The DMA code path doesn't look one bit different from
> what we currently do for the generic DMA engine in
> mmci.c, it sets up a DMA job from the sglist in the datapath,
> but maybe I'm not looking close enough?
>
>> I suspect the changes to mmci would be fairly drastic.
>
> I don't think so, but the changes to the DMA engine
> (I guess mach-msm/dma.c) would potentially be pretty drastic,
> apart from just moving the thing to drivers/dma.
>
> Actually when I look at the code in msm_sdcc.c it looks
> like some of the code we usually centralize into the
> DMA engine (like the thing iterating over a sglist and
> packing it into some custom struct called "box") is instead
> spread out in the client drivers.
>
> I just wanted to raise the issue because I see that the
> msm_sdcc driver is trying to e.g. synchronize against
> dataend signals and such stuff that we've worked with
> recently in mmci.c, and I really think it would be in the
> MSM platforms best interest to use this driver rather than
> its own.
>
> Yours,
> Linus Walleij
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
