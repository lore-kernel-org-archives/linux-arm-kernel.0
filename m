From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 17 Feb 2015 13:46:31 -0700
Subject: [PATCH 1/8] i2c: mux-pinctrl: Rework to honor disabled child nodes
In-Reply-To: <1424199129-22099-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1424199129-22099-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <54E3A8A7.8080703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17/2015 11:52 AM, Sebastian Hesselbarth wrote:
> I2C mux pinctrl driver currently determines the number of sub-busses by
> counting available pinctrl-names. Unfortunately, this requires each
> incarnation of the devicetree node with different available sub-busses
> to be rewritten.

Can you be more explicit about the problem here? Why does anything need 
to be re-written if a child node is disabled; presumably there's no need 
for the child bus numbers to be contiguous. In other words, with the 
example in the existing DT binding doc:

         i2cmux {
                 compatible = "i2c-mux-pinctrl";
...
                 pinctrl-names = "ddc", "pta", "idle";
                 pinctrl-0 = <&state_i2cmux_ddc>;
                 pinctrl-1 = <&state_i2cmux_pta>;
                 pinctrl-2 = <&state_i2cmux_idle>;

                 i2c at 0 {
                         reg = <0>;
...
                 i2c at 1 {
                         reg = <1>;
...

That would generate child busses 0 and 1. If I was to disable the i2c at 0 
node, then there would still be definitions for child busses 0 and 1 in 
the DT, it's just that child bus 0 wouldn't actually exist at run-time. 
I don't see what part of DT needs to be re-written to accomodate this?

> This patch reworks i2c-mux-pinctrl driver to count the number of
> available sub-nodes instead. The rework should be compatible to the old
> way of probing for sub-busses and additionally allows to disable unused
> sub-busses with standard DT property status = "disabled".
>
> This also amends the corresponding devicetree binding documentation to
> reflect the new functionality to disable unused sub-nodes. While at it,
> also fix two references to binding documentation files that miss an "i2c-"
> prefix.

> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt

> -For each named state defined in the pinctrl-names property, an I2C child bus
> -will be created. I2C child bus numbers are assigned based on the index into
> -the pinctrl-names property.
> +For each child node that is not disabled by a status != "okay", an I2C
> +child bus will be created. I2C child bus numbers are assigned based on the
> +order of child nodes.

I would have assumed that disabled sub-nodes was a global concept within 
DT, and so wouldn't be mentioned in the binding. It would just be a bug 
in the driver if it didn't ignore disabled sub-nodes.




>
> -The only exception is that no bus will be created for a state named "idle". If
> -such a state is defined, it must be the last entry in pinctrl-names. For
> -example:
> -
> -	pinctrl-names = "ddc", "pta", "idle"  ->  ddc = bus 0, pta = bus 1
> -	pinctrl-names = "ddc", "idle", "pta"  ->  Invalid ("idle" not last)
> -	pinctrl-names = "idle", "ddc", "pta"  ->  Invalid ("idle" not last)
> +There must be a corresponding pinctrl-names entry for each enabled child
> +node at the position of the child node's "reg" property.

The addition there seems fine, but the existing text re: the idle state 
seems clearer in the original text.
>
>   Whenever an access is made to a device on a child bus, the relevant pinctrl
>   state will be programmed into hardware.
>
> -If an idle state is defined, whenever an access is not being made to a device
> -on a child bus, the idle pinctrl state will be programmed into hardware.
> +Also, there can be an idle pinctrl state defined at the end of possible
> +pinctrl states. If an idle state is defined, whenever an access is not being
> +made to a device on a child bus, the idle pinctrl state will be programmed
> +into hardware.
