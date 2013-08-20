From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 20 Aug 2013 14:23:27 -0700
Subject: [PATCH 1/8] clk: keystone: add Keystone PLL clock driver
In-Reply-To: <52137201.6010806@ti.com>
References: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
 <1375719147-7578-2-git-send-email-santosh.shilimkar@ti.com>
 <20130813154842.GQ27165@e106331-lin.cambridge.arm.com>
 <520A5877.7050608@ti.com>
 <20130813164730.GT27165@e106331-lin.cambridge.arm.com>
 <520A659C.3030809@ti.com> <521258FB.2070002@ti.com>
 <20130819203359.4443.72378@quantum> <52137201.6010806@ti.com>
Message-ID: <20130820212327.4443.11235@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Santosh Shilimkar (2013-08-20 06:41:21)
> On Monday 19 August 2013 04:33 PM, Mike Turquette wrote:
> > Quoting Santosh Shilimkar (2013-08-19 10:42:19)
> >> Mark,
> >>
> >> On Tuesday 13 August 2013 12:58 PM, Santosh Shilimkar wrote:
> >>> On Tuesday 13 August 2013 12:47 PM, Mark Rutland wrote:
> >>>> On Tue, Aug 13, 2013 at 05:01:59PM +0100, Santosh Shilimkar wrote:
> >>>>> On Tuesday 13 August 2013 11:48 AM, Mark Rutland wrote:
> >>>>>> [Adding dt maintainers]
> >>>>>>
> >>>>>> On Mon, Aug 05, 2013 at 05:12:20PM +0100, Santosh Shilimkar wrote:
> >>>>>>> Add the driver for the PLL IPs found on Keystone 2 devices. The main PLL
> >>>>>>> IP typically has a multiplier, and a divider. The addtional PLL IPs like
> >>>>>>> ARMPLL, DDRPLL and PAPLL are controlled by the memory mapped register where
> >>>>>>> as the Main PLL is controlled by a PLL controller and memory map registers.
> >>>>>>> This difference is handle using 'has_pll_cntrl' property.
> >>>>>>>
> >>>>>>> Cc: Mike Turquette <mturquette@linaro.org>
> >>>>>>>
> >>>>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>>>>>> ---
> >>>>>
> >>>>> Thanks for review Mark.
> >>>>>
> >>>>>>>  .../devicetree/bindings/clock/keystone-pll.txt     |   36 ++++
> >>>>>>>  drivers/clk/keystone/pll.c                         |  197 ++++++++++++++++++++
> >>>>>>>  include/linux/clk/keystone.h                       |   18 ++
> >>>>>>>  3 files changed, 251 insertions(+)
> >>>>>>>  create mode 100644 Documentation/devicetree/bindings/clock/keystone-pll.txt
> >>>>>>>  create mode 100644 drivers/clk/keystone/pll.c
> >>>>>>>  create mode 100644 include/linux/clk/keystone.h
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/clock/keystone-pll.txt b/Documentation/devicetree/bindings/clock/keystone-pll.txt
> >>>>>>> new file mode 100644
> >>>>>>> index 0000000..58f6470
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/Documentation/devicetree/bindings/clock/keystone-pll.txt
> >>>>>>> @@ -0,0 +1,36 @@
> >>>>>>> +Binding for keystone PLLs. The main PLL IP typically has a multiplier,
> >>>>>>> +a divider and a post divider. The additional PLL IPs like ARMPLL, DDRPLL
> >>>>>>> +and PAPLL are controlled by the memory mapped register where as the Main
> >>>>>>> +PLL is controlled by a PLL controller. This difference is handle using
> >>>>>>> +'pll_has_pllctrl' property.
> >>>>>>> +
> >>>>>>> +This binding uses the common clock binding[1].
> >>>>>>> +
> >>>>>>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> >>>>>>> +
> >>>>>>> +Required properties:
> >>>>>>> +- compatible : shall be "keystone,pll-clk".
> >>>>>>
> >>>>>> Keystone isn't a vendor, and generally, bindings have used "clock"
> >>>>>> rather than "clk".
> >>>>>>
> >>>>>> Perhaps "ti,keystone-pll-clock" ?
> >>>>>>
> >>>>> Agree.
> >>>>>
> >>>>>>> +- #clock-cells : from common clock binding; shall be set to 0.
> >>>>>>> +- clocks : parent clock phandle
> >>>>>>> +- reg - index 0 -  PLLCTRL PLLM register address
> >>>>>>> +-        index 1 -  MAINPLL_CTL0 register address
> >>>>>>
> >>>>>> Perhaps a reg-names would be useful?
> >>>>>>
> >>>>>>> +- pll_has_pllctrl - PLL is controlled by controller or memory mapped register
> >>>>>>
> >>>>>> Huh? I don't understand what that description means. What does the
> >>>>>> property tell you? Is having one of the registers optional? If so that
> >>>>>> should be described by a reg-names property associated with the reg, and
> >>>>>> should be noted in the binding.
> >>>>>>
> >>>>> After re-reading it, yes I agree it not clear. The point is there
> >>>>> are two different types of IPs and pogramming model changes quite
> >>>>> a bit. Its not just 1 register optional.
> >>>>
> >>>> If that's the case, then having different compatible strings would make
> >>>> sense.
> >>>>
> >>>>>
> >>>>>>> +- pllm_lower_mask - pllm lower bit mask
> >>>>>>> +- pllm_upper_mask - pllm upper bit mask
> >>>>>>> +- plld_mask - plld mask
> >>>>>>> +- fixed_postdiv - fixed post divider value
> >>>>>>
> >>>>>> Please use '-' rather than '_' in property names, it's a standard
> >>>>>> convention for dt and going against it just makes things unnecessarily
> >>>>>> complicated.
> >>>>>>
> >>>>>> Why are these necessary? Are clocks sharing common registers, are there
> >>>>>> some sets of "keystone,pll-clk"s that have the same masks, or does this
> >>>>>> just vary wildly?
> >>>>>>
> >>>>> This is mainly to take care of the programming model which varies between
> >>>>> IPs. Will try to make that bit more clear.
> >>>>
> >>>> Are there more than the two IPs mentioned above? If they had separate
> >>>> compatible strings, would that give enough information implicitly,
> >>>> without the precise masks needing to be in the dt?
> >>>>
> >>> I will explore the separate compatible option. Thanks for suggestion.
> >>>
> >> I looked at further into separate compatible option or reg-names
> >> to check if it can help to reduce some additional dt information.
> >> Actually it doesn't help much. The base programming model is shared
> >> between both types of PLL IPs. The PLLs which has PLL controller along
> >> with MMRs, has to take into account additional bit-fields for the
> >> multiplier and divider along with the base model multiplier and divider
> >> registers.
> > 
> > It is common for the base programming model to be similar or shared
> > between two different compatible strings. You can use the same clk_ops
> > for clk_prepare, clk_enable, etc.
> >
> > The point is to use the different compatible strings to encode the
> > differences in *data* between the two clock types. That way you have
> > fewer properties to list in the binding since two separate setup
> > functions can implicitly handle the differences in initializing the
> > per-clock data.
> > 
> Thats the point I came back. Both PLL share the properties and
> the main PLL brings in couple of properties to extend the divider
> field and that was handled through the flag. As mentioned below,
> some properties like plld_mask, pllm_upper_shift etc can be
> dropped since they are static values.
> 
> >>
> >> Having said that, there are few parameters which are fixed like
> >> plld_mask, pllm_upper_shift etc need not come from DT. I am going
> >> to remove them from dt bindings and also make the reg index consistent
> >> as it should have been in first place.
> > 
> > This is nice. Note that these things may change in future Keystone
> > versions because hardware people hate you and want to make your life
> > hard. So the compatible string might benefit from including the first
> > keystone part number that uses this binding (e.g.
> > ti,keystone-2420-pll-clock, which I just made up).
> > 
> > In the future when the register layout, offsets and masks change for
> > absolutely no reason (but the programming model is the same) then you
> > can just write a new binding that setups up your private clk_pll_data
> > struct without having to jam all of those details into DT (e.g.
> > ti,keystone-3430-pll-clock, which I also just made up).
> > 
> So thats the good part so far with the keystone where the compatibility
> is maintained pretty well. I know background of your comments ;-)
> I will keep the bindings without any direct device association for
> now considering I don't foresee any thing changing in that aspect.

Sure. It's just a suggestion. Once the ABI is set it isn't supposed to
change so I'm just trying to think ahead.

Also there has been discussion on marking bindings as "unstable". I
don't know if you are interested in that but maybe putting a line at the
top of the binding stating something like:

Status: Unstable - ABI compatibility may be broken in the future

Regards,
Mike

> 
> Regards,
> Santosh
