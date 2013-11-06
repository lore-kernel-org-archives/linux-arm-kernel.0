From: syin@broadcom.com (Sherman Yin)
Date: Tue, 5 Nov 2013 18:02:01 -0800
Subject: [PATCH 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <527835FE.2030102@wwwdotorg.org>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <051069C10411E24D9749790C498526FA1BE0B7D7@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdYSLxp2M4HghcUdjEYGh-UQ+DaiCGp6yee+Qds6DR9poA@mail.gmail.com>
 <201311050026.56321.heiko@sntech.de> <527835FE.2030102@wwwdotorg.org>
Message-ID: <5279A319.5060701@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-11-04 04:04 PM, Stephen Warren wrote:
> On 11/04/2013 04:26 PM, Heiko St?bner wrote:
>
>> I remember we had a discussion about how things like bias-disable explicitly
>> shouldn't have a value, when they are represented in the list-format:
>>
>> 		pcfg_pull_none: pcfg_pull_none {
>> 			bias-disable;
>> 		};
>>
>> so a bias-disable = <1> was explicitly "forbidden" [for a lack of a better
>> word]. And it was similar for other options, the parameter not meant to be
>> indicating if they are active but really only setting the "strength" or so.
>
> Pure Boolean values should be represented as a valueless property. If
> the property is present, the value is true, otherwise false.
>
> However, pinctrl bindings often don't represent Boolean values, but
> rather tri-states, with the following values:
>
> * Don't touch this configuration option at all (missing)
> * Enable the option (<1>)
> * Disable the option (<0>)
>
> The reason for using tri-states being that you might want to write:
>
> xxx1 {
>      pins = <PINA>, <PINB>, <PINC>;
>      function = <...>;
>      // this node doesn't affect pullup
> }
> xxx2 {
>      pins = <PINA>, <PINB>;
>      // this node doesn't affect function
>      pull-up = <1>; // change, and enable
> }
> xxx3 {
>      pins = <PINAC>;
>      // this node doesn't affect function
>      pull-up = <0>; // change, and disable
> }

If I understand correctly, in Stephen's example, if a certain driver 
wants to configure PINA PINB and PINC, the pin configuration nodes 
"xxx1", "xxx2", and "xxx3" will all have to be selected for the 
particular pin state.  This works fine.  However, I'm just thinking that 
it would have been easier if we could specify just one node:

xxx {
	pins = <PINA>, <PINB>, <PINC>;
	function = <...>;
	pull-up = <1 1 0>;
}

This "feature" seems a bit more concise to me and is what I did for my 
original pinctrl driver.  The only downside is that with this method, 
one cannot specify "don't touch this option for this pin" if the same 
property must provide values for other pins.

When Linus asked me to try using generic pinconf instead, I ran into 
problems with this feature due to how the generic pinconf properties are 
defined differently than my properties - perhaps this feature just 
doesn't work for generic pinconf-based drivers with the (Unless we are 
ok with using 1/0 for boolean properties, but it has already been 
pointed out that these should be valueless.).

While I'd love to be able define my pin config nodes this way, if I have 
to use generic pinconf for the driver to be upstreamed, then I'm fine 
with it.

Going back to some questions regarding generic pinconf properties - 
could I get some help with these?

 >"input disable"
 >This setting disconnects the input (DIN) to the internal logic from 
 >the pin pad. However, the output (DOUT) can still drive the pad.  It
 >seems to match PIN_CONFIG_OUTPUT, but the current generic option is
 >either "output-low" or "output-high" - are these referring to a static
 >output of 0 and 1?

What's the best property to use in this case?

 >"mode"
 >This controls several aspect of the pin (slew rate, pull up strength,
 >etc) to meet I2C specs for Standard/Fast mode vs High Speed mode.  I
 >think the best way is to map this to slew rate, which would require
 >some explanation because the meaning of slew rate differs depending on
 >what pin function is selected:
 >- When I2C (*_SCL or *_SDA) function is selected for the pin: 0:
 >  Standard (100kbps)
 >  & Fast mode (400kbps), 1: High Speed mode (3.4Mbps)
 >- When IC_DM or IC_DP function is selected, 0: normal slew rate, 1:
 >  fast slew rate
 >- Else: 0: fast slew rate, 1: normal slew rate

Do we agree that the "slew rate" is the best property to use for "mode"?

Thanks,
Sherman
