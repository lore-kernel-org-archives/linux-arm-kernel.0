From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 04 Mar 2015 10:10:50 +0100
Subject: [PATCH v2 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <54F4C185.9080808@wwwdotorg.org>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425039885-5137-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <54F4C185.9080808@wwwdotorg.org>
Message-ID: <54F6CC1A.3030102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.03.2015 21:01, Stephen Warren wrote:
> On 02/27/2015 05:24 AM, Sebastian Hesselbarth wrote:
>> I2C mux pinctrl driver currently determines the number of sub-busses by
>> counting available pinctrl-names. Unfortunately, this requires each
>> incarnation of the devicetree node with different available sub-busses
>> to be rewritten.
>>
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
>> +For each enabled child node an I2C child bus will be created. I2C
>> child bus
>> +numbers are assigned based on the order of child nodes.
>
> I think that I2C bus numbers are an internal concept for the OS. As
> such, we should probably remove any mention re: the bus numbers from the
> binding.

Stephen,

yeah as you can see I am struggling to find a good documentation. I
agree that we should get rid of the bus number thing above.

>> -The only exception is that no bus will be created for a state named
>> "idle". If
>> -such a state is defined, it must be the last entry in pinctrl-names. For
>> -example:
>> +There must be a corresponding pinctrl-names entry for each enabled child
>> +node at the position of the child node's "reg" property. Also, there
>> can be
>> +an idle pinctrl state defined at the end of possible pinctrl states.
>> If such
>> +a state is defined, it must be the last entry in pinctrl-names. For
>> example:
>
> What about gaps in the numbering sequence? IIRC, in a situation with 5
> nodes with reg 0, 1, 2, 3, 4 but where only the nodes with reg of 1, 3
> enabled, we only want 2 entries in pinctrl-names? If so, "at the
> position of the child node's "reg" property" isn't correct, since "at
> the position" implies there must be gaps in pinctrl-names. "In the same
> order as the reg property values for enabled subnodes" might be a better
> description.

Good point. The idea was to _have_ gaps in pinctrl-names to allow to
configure the current mux layout by status properties only. The existing
implementation (and docu) suggested you have to amend pinctrl-names to
achieve a specific setup.

> Perhaps I'm misremembering and you explicitly didn't want to remove
> entries from pinctrl-names if child nodes were disabled? If so, then
> surely then in the text above, "for each enabled child" should be
> replaced with "for each child"?

True.

>> @@ -68,6 +68,7 @@ Example:
>>           pinctrl-1 = <&state_i2cmux_pta>;
>>           pinctrl-2 = <&state_i2cmux_idle>;
>>
>> +        /* Enabled child bus 0 */
>>           i2c at 0 {
>>               reg = <0>;
>>               #address-cells = <1>;
>> @@ -79,10 +80,12 @@ Example:
>>               };
>>           };
>>
>> +        /* Disabled child bus 1 */
>>           i2c at 1 {
>>               reg = <1>;
>>               #address-cells = <1>;
>>               #size-cells = <0>;
>> +            status = "disabled";
>
> To make the example cover more cases, perhaps make child node i2c at 0
> disabled and i2c at 1 enabled. Then, the example would show what happens to
> pinctrl-names when there are gaps in the reg property numbering space of
> enabled children?

The idea was to make nothing happen to pinctrl-names if you enable/
disable any of the children. But I can move the disabled status to
i2c at 0 to make it more clear that there should still be a pinctrl-names
cell for it.

Sebastian
