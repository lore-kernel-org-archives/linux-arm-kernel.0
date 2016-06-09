From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 9 Jun 2016 12:41:07 +0100
Subject: [PATCH v3 20/20] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
In-Reply-To: <20160608205152.GA5511@rob-hp-laptop>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-21-lee.jones@linaro.org>
 <20160608205152.GA5511@rob-hp-laptop>
Message-ID: <20160609114107.GB1388@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 08 Jun 2016, Rob Herring wrote:

> On Wed, Jun 08, 2016 at 10:21:35AM +0100, Lee Jones wrote:
> > We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
> > be more inline with the naming conventions of the subsystem.  Where
> > we used to treat each line as a channel, the PWM convention is to
> > describe them as devices.
> 
> That's all linux implementation details and you are breaking 
> compatibility.

Normally I'd agree with you, but I happen to know that a) this IP is
currently unused and b) up until this point (and probably beyond), ST
always ship the DTB with the kernel, so there will be no breakage.

> > The second documentation adaption entails adding support for PWM
> > capture devices.  A new clock is required as well as an IRQ line.
> > We're also adding a new property similar to the one described
> > above, but for capture channels.  Typically, there will be less
> > capture channels than PWM-out, since all channels have the latter
> > capability, but only some have capture support.
> 
> Humm, sounds like all of this should be implied from compatible strings.

You mean have a bunch of of_machine_is_compatibles() scattered around?

> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-st.txt | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-st.txt b/Documentation/devicetree/bindings/pwm/pwm-st.txt
> > index 84d2fb8..b09f3a4 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-st.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-st.txt
> > @@ -13,13 +13,14 @@ Required parameters:
> >  - pinctrl-0: 		List of phandles pointing to pin configuration nodes
> >  			for PWM module.
> >  			For Pinctrl properties, please refer to [1].
> > -- clock-names: 		Set to "pwm".
> > +- clock-names: 		Valid entries are "pwm" and/or "capture".
> >  - clocks: 		phandle of the clock used by the PWM module.
> >  			For Clk properties, please refer to [2].
> > +- interrupts:		IRQ for the Capture device
> >  
> >  Optional properties:
> > -- st,pwm-num-chan:	Number of available channels. If not passed, the driver
> > -			will consider single channel by default.
> > +- st,pwm-num-devs:	Number of available PWM channels.  Default is 0.
> > +- st,capture-num-devs:	Number of available Capture channels.  Default is 0.
> >  
> >  [1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> >  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > @@ -37,5 +38,6 @@ pwm1: pwm at fe510000 {
> >  		     &pinctrl_pwm1_chan3_default>;
> >  	clocks = <&clk_sysin>;
> >  	clock-names = "pwm";
> > -	st,pwm-num-chan = <4>;
> > +	st,pwm-num-devs = <4>;
> > +	st,capture-num-devs = <2>;
> >  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
