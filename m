From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 19 Jan 2017 13:49:25 +0200
Subject: [PATCH V7 1/4] Documentation/devicetree/bindings: b850v3_lvds_dp
In-Reply-To: <20170119092532.GB29457@collabora.com>
References: <74f0-58704480-5-27259840@173563636> <2338437.Vj2otdygnZ@avalon>
 <20170119092532.GB29457@collabora.com>
Message-ID: <6829547.Y11xI2zT5C@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Thursday 19 Jan 2017 10:25:32 Peter Senna Tschudin wrote:
> On Thu, Jan 19, 2017 at 10:17:45AM +0200, Laurent Pinchart wrote:
> > On Thursday 19 Jan 2017 09:12:14 Peter Senna Tschudin wrote:
> >> On Wed, Jan 18, 2017 at 11:10:58PM +0200, Laurent Pinchart wrote:
> >>> On Monday 16 Jan 2017 09:37:11 Peter Senna Tschudin wrote:
> >>>> On Tue, Jan 10, 2017 at 11:04:58PM +0200, Laurent Pinchart wrote:
> >>>>> On Saturday 07 Jan 2017 01:29:52 Peter Senna Tschudin wrote:
> >>>>>> On 04 January, 2017 21:39 CET, Rob Herring wrote:
> >>>>>>> On Tue, Jan 3, 2017 at 5:34 PM, Peter Senna Tschudin wrote:
> >>>>>>>> On 03 January, 2017 23:51 CET, Rob Herring <robh@kernel.org> wrote:
> >>>>>>>>> On Sun, Jan 01, 2017 at 09:24:29PM +0100, Peter Senna Tschudin 
> > wrote:
> >>>>>>>>>> Devicetree bindings documentation for the GE B850v3 LVDS/DP++
> >>>>>>>>>> display bridge.
> >>>>>>>>>> 
> >>>>>>>>>> Cc: Martyn Welch <martyn.welch@collabora.co.uk>
> >>>>>>>>>> Cc: Martin Donnelly <martin.donnelly@ge.com>
> >>>>>>>>>> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> >>>>>>>>>> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>>>>>>>>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> >>>>>>>>>> Cc: Rob Herring <robh@kernel.org>
> >>>>>>>>>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> >>>>>>>>>> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> >>>>>>>>> ---
> >>>>>>>>>> There was an Acked-by from Rob Herring <robh@kernel.org> for
> >>>>>>>>>> V6, but I changed the bindings to use i2c_new_secondary_device()
> >>>>>>>>>> so I removed it from the commit message.
> >> 
> >> [...]
> >> 
> >>>>>>>>>> .../devicetree/bindings/ge/b850v3-lvds-dp.txt      | 39 +++++++++
> >>>>>>>>> 
> >>>>>>>>> Isn't '-lvds-dp' redundant? The part# should be enough.
> >>>>>>>> 
> >>>>>>>> b850v3 is the name of the product, this is why the proposed name.
> >>>>>>>> What about, b850v3-dp2 dp2 indicating the second DP output?
> >>>>>>> 
> >>>>>> Humm, b850v3 is the board name? This node should be the name of
> >>>>>>> the bridge chip.
> >>>>>> 
> >>>>>> From the cover letter:
> >>>>>> 
> >>>>>> -- // --
> >>>>>> There are two physical bridges on the video signal pipeline: a
> >>>>>> STDP4028(LVDS to DP) and a STDP2690(DP to DP++).  The hardware and
> >>>>>> firmware made it complicated for this binding to comprise two
> >>>>>> device tree nodes, as the design goal is to configure both bridges
> >>>>>> based on the LVDS signal, which leave the driver powerless to control
> >>>>>> the video processing pipeline. The two bridges behaves as a single
> >>>>>> bridge, and the driver is only needed for telling the host about EDID
> >>>>>> / HPD, and for giving the host powers to ack interrupts. The video
> >>>>>> signal pipeline
> >>>>>> 
> >>>>>> is as follows:
> >>>>>>   Host -> LVDS|--(STDP4028)--|DP -> DP|--(STDP2690)--|DP++ -> Video
> >>>>>>   output
> >>>>>> 
> >>>>>> -- // --
> >>>>> 
> >>>>> You forgot to prefix your patch series with [HACK] ;-)
> >>>>> 
> >>>>> How about fixing the issues that make the two DT nodes solution
> >>>>> difficult ? What are they ?
> >>>> 
> >>>> The Firmware and the hardware design. Both bridges, with stock
> >>>> firmware, are fully capable of providig EDID information and handling
> >>>> interrupts. But on this specific design, with this specific firmware, I
> >>>> need to read EDID from one bridge, and handle interrupts on the other.
> >>> 
> >>> Which firmware are you talking about ? Firmware running on the
> >>> bridges, or somewhere else ?
> >> 
> >> Each bridge has it's own external flash containing a binary firmware.
> >> The goal of the firmware is to configure the output end based on the
> >> input end. This is part of what makes handling EDID and HPD challenging.
> >> 
> >>>> Back when I was starting the development I could not come up with a
> >>>> proper way to split EDID and interrupts between two bridges in a way
> >>>> that would result in a fully functional connector. Did I miss
> >>>> something?
> >>> 
> >>> You didn't, we did :-) I've been telling for quite some time now that
> >>> we must decouple bridges from connectors, and this is another example of
> >>> why we have such a need. Bridges should expose additional functions
> >>> needed to implement connector operations, and the connector should be
> >>> instantiated by the display driver with the help of bridge operations.
> >>> You could then create a connector that relies on one bridge to read the
> >>> EDID and on the other bridge to handle HPD.
> >> 
> >> Ah thanks. So for now the single DT node approach is acceptable, right?
> >> The problem is that even if the driver is getting better on each
> >> iteration, the single DT node for two chips issue comes back often and I
> >> believe is _the_ issue preventing the driver from getting upstream. V1
> >> was sent ~ 8 months ago...
> >> 
> >> Can I have some blessing on the single DT node approach for now?
> > 
> > With the "DT as an ABI" approach, I'm afraid not. Temporary hacks are
> > acceptable on the driver side, but you need two nodes in DT.
> 
> So can I make two node DT "in the right way" and work around current
> connectors vs. bridge limitations on the driver side? This seems to be
> doable.
> 
> Then I could fix bridge API, with my own driver and update API clients
> affected by the change...

I'm willing to discuss that as long as the DT bindings are correct, yes.

> >> I'm one of the 3 proposed maintainers for the driver, and I'm willing to
> >> maintain the driver on the long run, as is the same with the other two
> >> proposed maintainers. So when the time to split the node in two comes,
> >> we will be around, and willing to do it ourselves.
> > 
> > How about putting that team of 3 maintainers to work on fixing the problem
> > in the bridge API ? :-)
> 
> Guess you would be a good lawyer! My point was not exactly that we could
> work in parallel. Point was that there is redundancy in case one or two
> of us loose interest. But nice try! :-)
> 
> Chances of having resources to fix bridge API and clients were better 6
> months ago, but let me see what I can get.  Last blocking issue was the
> migration to atomic, now this. I'm going to need to answer what the next
> blocking issue is going to be.
> 
> Actually in these ~8 months one bit of the required changes was
> accepted: dc80d7038883, but this was generic and not related to our
> specific use case.

-- 
Regards,

Laurent Pinchart
