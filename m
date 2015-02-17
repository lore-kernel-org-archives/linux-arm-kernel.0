From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 17 Feb 2015 22:08:09 +0100
Subject: [PATCH 1/8] i2c: mux-pinctrl: Rework to honor disabled child nodes
In-Reply-To: <54E3A8A7.8080703@wwwdotorg.org>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1424199129-22099-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <54E3A8A7.8080703@wwwdotorg.org>
Message-ID: <54E3ADB9.1040008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.02.2015 21:46, Stephen Warren wrote:
> On 02/17/2015 11:52 AM, Sebastian Hesselbarth wrote:
>> I2C mux pinctrl driver currently determines the number of sub-busses by
>> counting available pinctrl-names. Unfortunately, this requires each
>> incarnation of the devicetree node with different available sub-busses
>> to be rewritten.
>
> Can you be more explicit about the problem here? Why does anything need
> to be re-written if a child node is disabled; presumably there's no need
> for the child bus numbers to be contiguous. In other words, with the
> example in the existing DT binding doc:
>
>          i2cmux {
>                  compatible = "i2c-mux-pinctrl";
> ...
>                  pinctrl-names = "ddc", "pta", "idle";
>                  pinctrl-0 = <&state_i2cmux_ddc>;
>                  pinctrl-1 = <&state_i2cmux_pta>;
>                  pinctrl-2 = <&state_i2cmux_idle>;
>
>                  i2c at 0 {
>                          reg = <0>;
> ...
>                  i2c at 1 {
>                          reg = <1>;
> ...
>
> That would generate child busses 0 and 1. If I was to disable the i2c at 0
> node, then there would still be definitions for child busses 0 and 1 in
> the DT, it's just that child bus 0 wouldn't actually exist at run-time.
> I don't see what part of DT needs to be re-written to accomodate this?

The way the current driver works, to disable i2c at 0 you'd have to remove
the pinctrl-0 state, pinctrl-names string at position 0, and the node
itself.

So, on Dove SoC there is three sub-busses, now consider one board A with
i2c0 and i2c1 enabled but board B with i2c0 and i2c2 enabled:

board-A.dts:

i2cmux {
	pinctrl-names = "i2c0", "i2c1", "idle";
	pinctrl-0 = <&state_for_i2c0>;
	pinctrl-1 = <&state_for_i2c1>;
};

but

board-B.dts:

i2cmux {
	pinctrl-names = "i2c0", "i2c2", "idle";
	pinctrl-0 = <&state_for_i2c0>;
	pinctrl-1 = <&state_for_i2c2>;
	/* Note that this ^^^ is state_for_i2c2 */
};

while the approach with status = "disabled" allows all properties for
both board remain the same - except you'll enable either i2c1 or i2c2
sub-node on board level:

i2cmux {
	pinctrl-names = "i2c0", "i2c1", "i2c2", "idle";
	pinctrl-0 = <&state_for_i2c0>;
	pinctrl-1 = <&state_for_i2c1>;
	pinctrl-2 = <&state_for_i2c2>;
};

board-A.dts:

i2cmux {
	i2c at 0 { status = "okay"; };
	i2c at 1 { status = "okay"; };
};

and

board-B.dts:

i2cmux {
	i2c at 0 { status = "okay"; };
	i2c at 2 { status = "okay"; };
};

In general, it is less about the binding but how the driver is written:
Number of sub-busses is determined by elements in pinctrl-names not
available (enabled) sub-nodes.

>> This patch reworks i2c-mux-pinctrl driver to count the number of
>> available sub-nodes instead. The rework should be compatible to the old
>> way of probing for sub-busses and additionally allows to disable unused
>> sub-busses with standard DT property status = "disabled".
>>
>> This also amends the corresponding devicetree binding documentation to
>> reflect the new functionality to disable unused sub-nodes. While at it,
>> also fix two references to binding documentation files that miss an
>> "i2c-"
>> prefix.
>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
>> b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
>
>> -For each named state defined in the pinctrl-names property, an I2C
>> child bus
>> -will be created. I2C child bus numbers are assigned based on the
>> index into
>> -the pinctrl-names property.
>> +For each child node that is not disabled by a status != "okay", an I2C
>> +child bus will be created. I2C child bus numbers are assigned based
>> on the
>> +order of child nodes.
>
> I would have assumed that disabled sub-nodes was a global concept within
> DT, and so wouldn't be mentioned in the binding. It would just be a bug
> in the driver if it didn't ignore disabled sub-nodes.

Yep, the concept is very global. It is about the current driver and this
binding changes are just to make it a little more clear that the driver
should behave different, i.e. get rid of anything that implies that
pinctrl-names has any effect on the number of sub-busses registered.

>> -The only exception is that no bus will be created for a state named
>> "idle". If
>> -such a state is defined, it must be the last entry in pinctrl-names. For
>> -example:
>> -
>> -    pinctrl-names = "ddc", "pta", "idle"  ->  ddc = bus 0, pta = bus 1
>> -    pinctrl-names = "ddc", "idle", "pta"  ->  Invalid ("idle" not last)
>> -    pinctrl-names = "idle", "ddc", "pta"  ->  Invalid ("idle" not last)
>> +There must be a corresponding pinctrl-names entry for each enabled child
>> +node at the position of the child node's "reg" property.
>
> The addition there seems fine, but the existing text re: the idle state
> seems clearer in the original text.

Ok, I'll have a look at how to preserve this section better.

Do you still have one of the current boards available for testing?

Sebastian
