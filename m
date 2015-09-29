From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Sep 2015 14:30:46 +0200
Subject: [PATCH v2 1/9] dmaengine: st_fdma: Add STMicroelectronics FDMA DT
 binding documentation
In-Reply-To: <20150929121155.GA17986@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <35211759.Jca4RWVLIS@wuerfel>
 <20150929121155.GA17986@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <1842713.tkjrhSVazj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 September 2015 13:11:55 Peter Griffin wrote:
> Hi Arnd,
> 
> On Tue, 29 Sep 2015, Arnd Bergmann wrote:
> 
> > On Tuesday 29 September 2015 11:04:40 Peter Griffin wrote:
> > > 
> > > "The hardware is identical, and different firmware is used to apply
> > >    it in different ways."
> > > 
> > > Which is the case with fdma. By encoding the "way you wish to apply it" into the
> > > compatible string, it causes problems if you want to change for example fdma0
> > > to do some other function other than audio.
> > > 
> > > You then require a DT update, (when the hardware hasn't changed, just the
> > > firmware) which is the same problem as using the filename directly in DT.
> > > 
> > > Therefore I believe it is important that the DT binding does *not* encode the
> > > way the hardware is to be applied into the binding in *any* way, and defers this
> > >  decision to the driver.
> > > That is the rationale / reasoning behind choosing the fdma instance number.
> > > 
> > > Assuming you agree with my arguments above, then the choice becomes between 
> > > having a fdma instance DT property, or having lots of compatibles where the only
> > > difference is the appending of the instance number. I think out of the two I prefer
> > > my original approach.
> > > 
> > > Any thoughts from the DT folks?
> > 
> > To me both approaches sound wrong: basing the firmware name on the instance
> > number requires that each instance is always used in the same way, which
> > is not guaranteed to be the case,
> 
> Does it? I didn't think it did.
> 
> Using the instance number as a DT property defers the decision over what firmware to
> load to the driver, which can choose whatever firmware name it wishes.
> 
> e.g. in v4.3 it could load xyz.elf, in v4.4 it could choose abc.elf. The DT will remain
> unchanged, but the use of that fdma instance has changed.
> 
> We currently only have one firmware for each instance with the "use" compiled into it.
> If in the future we had two firmwares with different "uses" for the same instance some extra
> logic would be required in the driver to make a decision on which firmware to load.

Ok, I probably need some more background about what the firmware on this
device does, and what it could do with a different firmware. Could you
elaborate?

> > and you correctly describe the problem with
> > using the compatible string for the firmware name if the driver for the FDMA
> > does not actually care what firmware is being used here.
> > 
> > Whatever code makes the decision as to how the FDMA is used should also
> > decide on the name of the firmware file.
> 
> The code which makes this decision currently is the st_fdma.c driver. However it does
> need to know which fdma controller it is operating on to make this decision correctly.
> 
> Apart from passing the fdma instance number in DT, how else can we determine which
> controller we are?
> 
> I guess we could infer it by having a table in the driver containing the base addresses
> of the controllers for a given SoC, and match that against what DT passes us in the
> reg property. But that seems ugly, and is encoding the same information in two
> different places.
> 
> I'm open to suggestions if there is a better way to do this.

Using the address would be the same thing, that doesn't change the
fundamental logic. Can you explain why it matters which instance
a firmware is used on for this driver?

	Arnd
