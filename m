From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 15 Aug 2014 18:41:40 +0200
Subject: [PATCHv10 2/2] arm: dts: Add Altera SDRAM EDAC bindings &
 devicetree entries.
In-Reply-To: <alpine.DEB.2.02.1408151035110.21645@atx-linux-37>
References: <1407770293-27190-1-git-send-email-tthayer@opensource.altera.com>
 <1407770293-27190-3-git-send-email-tthayer@opensource.altera.com>
 <73vbputf04.fsf@dude.hi.pengutronix.de>
 <alpine.DEB.2.02.1408151035110.21645@atx-linux-37>
Message-ID: <20140815164140.GA19071@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 11:07:31AM -0500, atull wrote:
> On Fri, 15 Aug 2014, Steffen Trumtrar wrote:
> 
> > 
> > Hi!
> 
> Hello
> 
> Thanks for the feedback...
> 
> > 
> > tthayer at opensource.altera.com writes:
> > 
> > > From: Thor Thayer <tthayer@opensource.altera.com>
> > >
> > > Add the Altera SDRAM EDAC bindings and device tree changes to the Altera SoC project.
> > >
> > > Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> > > ---
> > > v2: Changes to SoC SDRAM EDAC code.
> > >
> > > v3: Implement code suggestions for SDRAM EDAC code.
> > >
> > > v4: Remove syscon from SDRAM controller bindings.
> > >
> > > v5: No Change, bump version for consistency.
> > >
> > > v6: Only map the ctrlcfg register as syscon.
> > >
> > > v7: No change. Bump for consistency.
> > >
> > > v8: No change. Bump for consistency.
> > >
> > > v9: Changes to support a MFD SDRAM controller with nested EDAC.
> > >
> > > v10: Revert to using syscon based on feedback.
> > > ---
> > >  .../bindings/arm/altera/socfpga-sdram-edac.txt     |   15 +++++++++++++++
> > >  arch/arm/boot/dts/socfpga.dtsi                     |   11 +++++++++++
> > >  2 files changed, 26 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> > > new file mode 100644
> > > index 0000000..d0ce01d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> > > @@ -0,0 +1,15 @@
> > > +Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
> > > +The EDAC accesses a range of registers in the SDRAM controller.
> > > +
> > > +Required properties:
> > > +- compatible : should contain "altr,sdram-edac";
> > > +- altr,sdr-syscon : phandle of the sdr module
> > > +- interrupts : Should contain the SDRAM ECC IRQ in the
> > > +	appropriate format for the IRQ controller.
> > > +
> > > +Example:
> > > +	sdramedac {
> > > +		compatible = "altr,sdram-edac";
> > > +		altr,sdr-syscon = <&sdr>;
> > > +		interrupts = <0 39 4>;
> > > +	};
> > > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > > index 4676f25..45b361e 100644
> > > --- a/arch/arm/boot/dts/socfpga.dtsi
> > > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > > @@ -603,6 +603,17 @@
> > >  			};
> > >  		};
> > >  
> > > +		sdr: sdr at ffc25000 {
> > > +			compatible = "syscon";
> > > +			reg = <0xffc25000 0x1000>;
> > > +		};
> > > +
> > > +		sdramedac {
> > > +			compatible = "altr,sdram-edac";
> > > +			altr,sdr-syscon = <&sdr>;
> > > +			interrupts = <0 39 4>;
> > > +		};
> > > +
> > >  		L2: l2-cache at fffef000 {
> > >  			compatible = "arm,pl310-cache";
> > >  			reg = <0xfffef000 0x1000>;
> > 
> > Sorry, but I personally still don't like this approach.
> 
> This is a normal use of syscon.  Syscon is great for this case 
> where multiple drivers need access to an ip block's register
> range but there is otherwise no need to write a MFD from scratch
> to allow that.  I think that's the purpose of syscon in the first
> place.
> 

I talked with a co-worker about this. And we came to the conclusion,
that syscon is wrong and has issues, but we sadly had no better idea.

I'd rather have the whole range be a syscon than some bad MFD implementation.

> > 
> > If we do it like this however, shouldn't the different regions of the
> > SDR (EDAC, FPGAPORTRST, ...) at least be child nodes of the syscon?
> > That seems to match the syscon binding and describes the actual hardware
> > better IMHO.
> 
> I like that; it would be clean and clear, but I don't think syscon is 
> written such that that would actually work.  I haven't seen anybody else
> do it that way.

Don't actually know. The documentation says this is possible.

> 
> > Oh, and "reg = <...>" for the sdram-edac, maybe ?
> 
> How would that work?  Syscon is already mapping the whole register range
> for the sdr block.  Are you proposing a device tree binding that this
> Linux driver would ignore, but some other driver in some other OS might
> find useful in the future?  I'd rather not put duplicate information
> in two places, too easy for it to get out of sync.
> 

Yes. I think you are actually right. This won't work.

> > How would I know where the start address of the EDAC is, if I would use
> > this DT on another OS where I don't have the same driver?
> 
> The start address of the EDAC is an offset into the range mapped by 
> syscon here.  The driver knows what the register offsets are.
> 
> If we are talking about this device tree being used by some other OS
> that is not aware of syscon, then that OS won't know what's going on and
> some modification of the DT will be needed.  I have been advised that
> u-boot will need a significantly different DT, though I don't know
> what the issues are there.
> 

That is one issue I personally have with syscon. We are always told to
only describe the hardware and don't mix Linux specifics in the bindings.
How is syscon not a Linux specific thing? Maybe I see this wrong though.

Then u-boot has a problem that should be fixed.
For barebox we try to stay as close to the "official" DT bindings as possible.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
