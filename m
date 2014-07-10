From: delicious.quinoa@gmail.com (Alan Tull)
Date: Thu, 10 Jul 2014 16:02:14 -0500
Subject: [PATCH 1/3] dts: socfpga: Add bindings for Altera SoC SDRAM
 controller
In-Reply-To: <CAL_JsqJRweynpCA7LMFU4wfa71XzjGC3b8H9XKJpogf5H93h_A@mail.gmail.com>
References: <1396907649-20212-1-git-send-email-tthayer@altera.com>
 <1396907649-20212-2-git-send-email-tthayer@altera.com>
 <20140408133818.GB16054@pengutronix.de>
 <1396967390.23349.15.camel@dinh-ubuntu>
 <20140408143327.GC16054@pengutronix.de>
 <CANk1AXR0bDENDV673M-AVXNWHmGuee5SGc+ZnPqdBdEBwJXQXQ@mail.gmail.com>
 <CAL_JsqJRweynpCA7LMFU4wfa71XzjGC3b8H9XKJpogf5H93h_A@mail.gmail.com>
Message-ID: <CANk1AXSi0UrU+yHMz+B_gN-k9=DuTDHPaERQfwU+NHvWsaWDpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 8, 2014 at 1:52 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Apr 8, 2014 at 11:02 AM, delicious quinoa
> <delicious.quinoa@gmail.com> wrote:
>> On Tue, Apr 8, 2014 at 9:33 AM, Steffen Trumtrar
>> <s.trumtrar@pengutronix.de> wrote:
>>> On Tue, Apr 08, 2014 at 09:29:50AM -0500, Thor Thayer wrote:
>>>> On Tue, 2014-04-08 at 15:38 +0200, Steffen Trumtrar wrote:
>>>> > Hi!
>>>> >
>>>> > On Mon, Apr 07, 2014 at 04:54:07PM -0500, tthayer at altera.com wrote:
>>>> > > From: Thor Thayer <tthayer@altera.com>
>>>> > >
>>>> > > Addition of the Altera SDRAM controller bindings and device
>>>> > > tree changes to the Altera SoC project.
>>>> > >
>>>> [snip]
>>>> > > +
>>>> > > +Required properties:
>>>> > > +- compatible : "altr,sdr-ctl", "syscon";
>>>> > > +                Note that syscon is invoked for this device to support the FPGA
>>>> > > +         bridge driver, EDAC driver and other devices that share the
>>>> > > +         registers.
>>>> > > +- reg : Should contain 1 register ranges(address and length)
>>>> >
>>>> > I haven't really thought this through, but why would the FPGA bridge driver
>>>> > access the sdram controller? For releasing the resets in fpgaportrst ? Or is
>>>> > there more?
>>>>
>>>> Hi Steffan. No, not for resets. We need to enable the FPGA to SDRAM
>>>> path. Our SDRAM controller allows FPGA master access to the SDRAM.
>>>>
>>>
>>> Yes. But what you have to do to enable the path is let the FPGA port you use
>>> out of reset. And that is it as far as I can see. The rest happens in the
>>> bitstream. Or is there more to enable the path?
>>> The FPGA2SDRAM bridge is the one I didn't use as of yet, so if I miss something
>>> please elaborate.
>>
>> Hi Steffen,
>>
>> The sdram controller is used by two drivers.  That's why we want to
>> specify "syscon" here.  The other driver is the FPGA bridge driver.
>> Its functionality is very separate from what this driver is doing (we
>> are not enabling the bridge in this driver; we are enabling the
>> monitoring and resetting the interrupt bit of the EDAC).  We wanted to
>> specify "syscon" her so that we don't have to have to change it for
>> the other driver.
>
> But are there actually overlapping registers which are accessed by
> both drivers and need the protection of regmap?

No overlapping registers here.  Just various registers that are used
by: edac driver, fpga bridge, low power modes.  So no special
protection needed.

>
> Perhaps MFD is more appropriate than syscon?
>
> Rob

A syscon will do fine here.  If we did a MFD, all it would be doing
would be providing register access for this range of registers to a
few drivers, so syscon does that without any trouble.

Alan Tull
aka
delicious quinoa
