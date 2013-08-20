From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 20 Aug 2013 14:30:45 -0700
Subject: [PATCH 2/8] clk: keystone: Add gate control clock driver
In-Reply-To: <5213756A.5090903@ti.com>
References: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
 <1375719147-7578-3-git-send-email-santosh.shilimkar@ti.com>
 <20130813161314.GR27165@e106331-lin.cambridge.arm.com>
 <520A60A2.2030104@ti.com>
 <20130813165344.GU27165@e106331-lin.cambridge.arm.com>
 <20130819204353.4443.48466@quantum> <5213756A.5090903@ti.com>
Message-ID: <20130820213045.4443.89971@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Santosh Shilimkar (2013-08-20 06:55:54)
> On Monday 19 August 2013 04:43 PM, Mike Turquette wrote:
> > Quoting Mark Rutland (2013-08-13 09:53:44)
> >> On Tue, Aug 13, 2013 at 05:36:50PM +0100, Santosh Shilimkar wrote:
> >>> On Tuesday 13 August 2013 12:13 PM, Mark Rutland wrote:
> >>>> [adding dt maintainers]
> >>>>
> >>>> On Mon, Aug 05, 2013 at 05:12:21PM +0100, Santosh Shilimkar wrote:
> >>>>> Add the driver for the clock gate control which uses PSC (Power Sleep
> >>>>> Controller) IP on Keystone 2 based SOCs. It is responsible for enabling and
> >>>>> disabling of the clocks for different IPs present in the SoC.
> >>>>>
> >>>>> Cc: Mike Turquette <mturquette@linaro.org>
> >>>>>
> >>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>>>> ---
> >>>>>  .../devicetree/bindings/clock/keystone-gate.txt    |   30 ++
> >>>>>  drivers/clk/keystone/gate.c                        |  306 ++++++++++++++++++++
> >>>>>  include/linux/clk/keystone.h                       |    1 +
> >>>>>  3 files changed, 337 insertions(+)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/clock/keystone-gate.txt
> >>>>>  create mode 100644 drivers/clk/keystone/gate.c
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/clock/keystone-gate.txt b/Documentation/devicetree/bindings/clock/keystone-gate.txt
> >>>>> new file mode 100644
> >>>>> index 0000000..40afef5
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/clock/keystone-gate.txt
> >>>>> @@ -0,0 +1,30 @@
> >>>>> +Binding for Keystone gate control driver which uses PSC controller IP.
> >>>>> +
> >>>>> +This binding uses the common clock binding[1].
> >>>>> +
> >>>>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> >>>>> +
> >>>>> +Required properties:
> >>>>> +- compatible : shall be "keystone,psc-clk".
> >>>>
> >>>> Similarly to my comments on patch 1, this should probably be something
> >>>> more like "ti,keystone-psc-clock"
> >>>>
> >>>>> +- #clock-cells : from common clock binding; shall be set to 0.
> >>>>> +- clocks : parent clock phandle
> >>>>> +- reg :        psc address address space
> >>>>> +
> >>>>> +Optional properties:
> >>>>> +- clock-output-names : From common clock binding to override the
> >>>>> +                       default output clock name
> >>>>> +- status : "enabled" if clock is always enabled
> >>>>
> >>>> Huh? This is a standard property, for which ePAPR defines "okay",
> >>>> "disabled", "fail", and "fail-sss", and not "enabled". This also doesn't
> >>>> seem to follow the standard meaning judging by the code.
> >>>>
> >>>> It looks like this could be a boolean property
> >>>> ("clock-always-enabled"?), but that assumes it's necessary.
> >>>>
> >>>> Why do you need this?
> >>>>
> >>> I dropped this already. Forgot to update the documentation.
> >>
> >> Ok.
> >>
> >>>
> >>>>> +- lpsc : lpsc module id, if not set defaults to zero
> >>>>
> >>>> What's that needed for? Are there multiple clocks sharing a common
> >>>> register bank?
> >>>>
> >>>>> +- pd : power domain number, if not set defaults to zero (always ON)
> >>>>
> >>>> Please don't use abbreviations unnecessarily. "power-domain-id" or
> >>>> similar would be far better. What exactly does this represent? Does the
> >>>> clock IP itself handle power domains, or is there some external unit
> >>>> that controls power domains?
> >>>>
> >>> pd is commonly used but I can expand it. This represent the power
> >>> domain number.
> >>
> >> Does the the clock IP have some internal logic for handling power
> >> domains only covering its clocks, or is there some external power
> >> controller involved (i.e. do we possibly need to describe an external
> >> unit and a linkage to it?).
> > 
> > Hmm, does the clock own the power domain or does the power domain own
> > the clock? As you well know on OMAP the clock resides within the power
> > domain. So it seems to me that the better way to do this would be for
> > the power domain to have it's own binding and node, and then reference
> > the clock:
> > 
> > power-domain {
> >       ...
> >       clocks = <&chipclk3>, <&chipclk4>;
> >       clock-names = "perclk", "uartclk";
> >       ...
> > };
> > 
> > Now maybe things are different on Keystone, but if not then I don't see
> > why the clock binding should have anything to do with the power domain.
> >
> They are bit different w.r.t OMAP. LPSC itself is the clock control of the
> IP. The LPSC number in the bindings is actually the specific number which
> is used to reach to the address space of the clock control. One can view
> that one as clock control register index.

Thanks for the information. I have a further question about then: are
the LPSC clocks really module clocks that belong to the IP that they are
gating?

If so then they could be defined within the node defining their parent
IP. That might be enough to get rid of the LPSC index value. Again I
might be over-engineering it. Just trying to get an understanding.

> 
> The power domain as such are above the lpsc but the clock enable/disable needs
> to follow a recommended sequence which needs the access to those registers.
> As such there is no major validation done on dynamically switching off PDs
> in current generation devices.
> 
> As I mentioned you to on IRC, the PD was the only odd part I have to keep
> around to address the sequencing need which is kind of interlinked.

Right. Well maybe some day that part can go away but I understand the
need for it now.

Regards,
Mike

>  
> >>
> >>>
> >>>>> +- gpsc : gpsc number, if not set defaults to zero
> >>>>
> >>>> How does that interact with the lpsc property? When are these necessary?
> >>>>
> >>> lpsc is local clock/module control where as gpsc sits on top of it. 
> > 
> > Similar to the above, should the gpsc have it's own binding and node
> > that contains the lpsc which also have their own bindings/nodes, which
> > finally contain the clocks? Maybe that is over engineered but I want to
> > consider this before the binding gets set in stone.
> > 
> Actually GPSC need not be even mentioned since its one per SOC. Let me 
> see if I can drop it to avoid any confusion.
> 
> Regards,
> Santosh
