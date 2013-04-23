From: tony@atomide.com (Tony Lindgren)
Date: Tue, 23 Apr 2013 11:17:54 -0700
Subject: Query on pinctrl usage for DT nodes
In-Reply-To: <51763B7B.707@ti.com>
References: <CA+V-a8uiPwsAD--OHFAE=i2ed+-wbXm4p2deZXr92+Zv6GDS1w@mail.gmail.com>
 <515C5C76.3080009@wwwdotorg.org>
 <CA+V-a8t3wtP77DdeUoQHKMjAuWmV+ude+1J3UjJmMTqobgStjA@mail.gmail.com>
 <5162FD4A.1030909@wwwdotorg.org>
 <CA+V-a8vwdCkyMqiynj5BodXbjwJ=e4qNb-29FhLweqbjc7DBQA@mail.gmail.com>
 <5165A22B.4070200@wwwdotorg.org>
 <20130410203408.GP10155@atomide.com> <516BB99F.2080502@ti.com>
 <20130416213232.GU10155@atomide.com> <51763B7B.707@ti.com>
Message-ID: <20130423181753.GK10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130423 00:47]:
> On 04/16/2013 11:32 PM, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [130415 01:30]:
> >> On 04/10/2013 10:34 PM, Tony Lindgren wrote:
> >>> Yeah how about just change the pintctrl-single,bits register
> >>> naming to be register + bit?  Something like 0xdeadbeef.0 and
> >>> 0xdeadbeef.1 and so on.
> >>
> >> Something like this might work I think. It is going to be a bit tricky IMHO
> >> since we might need span out new 'register' every time a device requests for a
> >> new pinctrl-single,bits for already used register in the
> >> pinctrl-single,bit-per-mux area. In this way we still can make sure that
> >> certain bit are only used by a single driver.
> > 
> > OK. If it's one bit per mux type register we should be able to create
> > the right amount of entries based on the submask in pinctrs-single,bit?
> 
> Right now it seams to be true that we have one bit per mux (in DEVCONF0 on
> OMAP3 for example). So that would work fine, but There could be different
> registers around with more than one bit per mux.

Yes you are right, we should cover that case too. But maybe we
can wait until we have such an example :)
 
> Another way to deal with this is to:
> in case of pinctrl-single,bit-per-mux we assume one bit per mux and create
> entries based on the pinctrl-single,function-mask's bits.
> 
> In case we have more than one bit for the mux in the register we could have
> optional property stating the number of different muxes handled by the register.

Yes that's doable.
 
> One bit per mux type:
> 
> control_devconf0: pinmux at 48002274 {
>         compatible = "pinctrl-single";
>         reg = <0x48002274 4>;   /* Single register */
>         #address-cells = <1>;
>         #size-cells = <0>;
>         pinctrl-single,bit-per-mux;
>         pinctrl-single,register-width = <32>;
>         pinctrl-single,function-mask = <0x5F>;
> };
> 
> Results six entries.

Yup, I think this is the way to go for now, see below..
 
> control_devconf0: pinmux at 48002274 {
>         compatible = "pinctrl-single";
>         reg = <0x48002274 4>;   /* Single register */
>         #address-cells = <1>;
>         #size-cells = <0>;
>         pinctrl-single,bit-per-mux;
>         pinctrl-single,functions-in-register = <3>;
>         pinctrl-single,register-width = <32>;
>         pinctrl-single,function-mask = <0x5F>;
> };
> 
> Will results three entries.

..but let's not add this. The reason why I'd like to postpone adding
pinctrl-single,functions-in-register is because we may be able to
do it automatically.

If it was just the naming is the issue, we could use the submask
for the naming the bits with something like 0x0x48002274-3-1 and
0x0x48002274-1-1.

But I think currently the pinctrl framework expects a static pin
table, so we can't create these entries dynamically when the
consumer driver starts using the bits. So the right fix there
would be to improve the pinctrl framework to allow adding pins
dynamically, see some of the REVISIT comments in pinctrl-single.c.

> In both cases we still need to test overlaps in the handled bits.

Yes that's missing too.

So how about we do the following for now:

1. Fix the pinctrl-single,bits naming to use 0x0x48002274-1-1 to
   represent the bit range

2. Automatically create entries for each bit and don't yet support
   bit ranges except in the naming for future use

3. Add something to check the overlaps in the submasks

4. Assume we have one-bit-per-mux until we have a real example,
   then improve the pinctrl framework to allow adding pins 
   dynamically as the consumer driver probes. Or if there are
   other issues, add the pinctrl-single,functions-in-register
   property at that point.

Regards,

Tony
