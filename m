From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 13 Oct 2015 12:18:32 +0100
Subject: [PATCH v2 1/9] dmaengine: st_fdma: Add STMicroelectronics FDMA
 DT binding documentation
In-Reply-To: <2737791.qJkUc2COQb@wuerfel>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1842713.tkjrhSVazj@wuerfel>
 <20150929134215.GA21591@griffinp-ThinkPad-X1-Carbon-2nd>
 <2737791.qJkUc2COQb@wuerfel>
Message-ID: <20151013111832.GC30342@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, 29 Sep 2015, Arnd Bergmann wrote:

> On Tuesday 29 September 2015 14:42:15 Peter Griffin wrote:
> > On Tue, 29 Sep 2015, Arnd Bergmann wrote:
> > > On Tuesday 29 September 2015 13:11:55 Peter Griffin wrote:
> > > > Does it? I didn't think it did.
> > > > 
> > > > Using the instance number as a DT property defers the decision over what firmware to
> > > > load to the driver, which can choose whatever firmware name it wishes.
> > > > 
> > > > e.g. in v4.3 it could load xyz.elf, in v4.4 it could choose abc.elf. The DT will remain
> > > > unchanged, but the use of that fdma instance has changed.
> > > > 
> > > > We currently only have one firmware for each instance with the "use" compiled into it.
> > > > If in the future we had two firmwares with different "uses" for the same instance some extra
> > > > logic would be required in the driver to make a decision on which firmware to load.
> > > 
> > > Ok, I probably need some more background about what the firmware on this
> > > device does, and what it could do with a different firmware. Could you
> > > elaborate?
> > 
> > So the fdma hw is a dma engine based around a xp70 slim core. It supports: -
> > * block memory move between 2 system locations
> > * paced transfer from system memory to paced peripheral
> > * paced transfer from a paced peripheral to system memory
> > 
> > I believe each firmware for each instance supports those 3 things.
> 
> Ok
> 
> > However the xp70 also has some ancilary HW to facilitate Start Code Detection.
> > It is this feature which I believe would require a different firmware if we wanted to make
> > use of it. Looking at the functional spec each xp70 also
> > has 16 gp output signals which we could also control from the firmware. Whether
> > these are actually connected to anything useful inside the SoC I don't know.
> 
> I still don't understand what Start Code Detection is here.

I believe the "Start Code Detection" feature is referring to the 4 byte start code
found in packetized elementary stream (PES). So it is a A/V optimisation for the
DMA controller.

> 
> > > > > and you correctly describe the problem with
> > > > > using the compatible string for the firmware name if the driver for the FDMA
> > > > > does not actually care what firmware is being used here.
> > > > > 
> > > > > Whatever code makes the decision as to how the FDMA is used should also
> > > > > decide on the name of the firmware file.
> > > > 
> > > > The code which makes this decision currently is the st_fdma.c driver. However it does
> > > > need to know which fdma controller it is operating on to make this decision correctly.
> > > > 
> > > > Apart from passing the fdma instance number in DT, how else can we determine which
> > > > controller we are?
> > > > 
> > > > I guess we could infer it by having a table in the driver containing the base addresses
> > > > of the controllers for a given SoC, and match that against what DT passes us in the
> > > > reg property. But that seems ugly, and is encoding the same information in two
> > > > different places.
> > > > 
> > > > I'm open to suggestions if there is a better way to do this.
> > > 
> > > Using the address would be the same thing, that doesn't change the
> > > fundamental logic. Can you explain why it matters which instance
> > > a firmware is used on for this driver?
> > 
> > The reason we care, is that each instance has its own firmware file.
> > 
> > I just did a hexdump on the 3 different firmwares and compared them. Although the majority
> > of the binary is the same, there are various bytes which change at several different offsets
> > in the firmware file depending on the instance.
> > 
> > I don't have a xp70 toolchain or know enough about the cpu architecture to analyze what exactly
> > the firmware is doing at these locations.
> 
> This sounds like we should indeed treat them as different things: We don't
> know what the difference is, but we know that each of them needs a different
> firmware, and presumably if you get a new SoC variant, it will in turn
> need three new ones.

Yes I believe so.

> 
> In this case, I'd say using the compatible string to identify them is best,
> using whatever the SoC documentation uses to describe them. You can use the
> of_device_id data fields to look up the firmware name then.

Ok, I  will implement like this in the next version.

> 
> If the output signals end up being connected to something we want to
> control through the firmware, that also makes sense for a new compatible
> string, as the driver needs to know about the feature in order to
> communicate with the firmware, and the DT needs to be able to describe
> the pins (e.g. by making the node act as a GPIO controller) in a way that
> requires a different string, too.

Yes I agree, thanks for your review and comments :)

regards,

Peter.
