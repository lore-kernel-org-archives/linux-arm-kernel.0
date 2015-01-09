From: rjui@broadcom.com (Ray Jui)
Date: Fri, 9 Jan 2015 10:26:12 -0800
Subject: [PATCH 1/4] pinctrl: Broadcom Cygnus pinctrl device tree binding
In-Reply-To: <CACRpkdb5pNMbXmWGjrGpAYNLLwv6pWWOJQy0C6BLetNcStFM6A@mail.gmail.com>
References: <rjui@broadcom.com>	<1417131990-17954-1-git-send-email-rjui@broadcom.com>	<1417131990-17954-2-git-send-email-rjui@broadcom.com>
 <CACRpkdb5pNMbXmWGjrGpAYNLLwv6pWWOJQy0C6BLetNcStFM6A@mail.gmail.com>
Message-ID: <54B01D44.5080601@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/9/2015 2:12 AM, Linus Walleij wrote:
> On Fri, Nov 28, 2014 at 12:46 AM, Ray Jui <rjui@broadcom.com> wrote:
> 
>> Device tree binding documentation for Broadcom Cygnus pinctrl driver
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> ---
>>  .../bindings/pinctrl/brcm,cygnus-pinctrl.txt       |   92 ++++++++++++++++++++
>>  1 file changed, 92 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinctrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinctrl.txt
>> new file mode 100644
>> index 0000000..86e4579
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinctrl.txt
>> @@ -0,0 +1,92 @@
>> +Broadcom Cygnus Pin Controller
>> +
>> +The Cygnus pin controller supports setting the alternate functions of groups
>> +of pins. Pinmux configuration on individual pins is not supported by the
>> +Cygnus A0 SoC.
>> +
>> +Required properties:
>> +
>> +- compatible:
>> +    Must be "brcm,cygnus-pinctrl"
>> +
>> +- reg:
>> +    Define the base and range of the I/O address space that contain the Cygnus
>> +pin control registers
> 
> The following is subnodes. Indicate clearly in the binding that these are
> *not* properties of the main node, but individual subnodes.
> 
Right. I'll fix the document.

>> +- brcm,groups:
>> +    This can be strings of one or more group names. This defines the group(s)
>> +that one wants to configure
>> +
>> +- brcm,function:
>> +    This is the alternate function that one wants to configure to. Valid
>> +alternate functions are "alt1", "alt2", "alt3", "alt4"
> 
> NAK. We have standardized bindings for groups and functions,
> and there are pending patches from S?ren Brinkmann adding
> this to the pinctrl DT parsing core.
> 
> Just use "groups" and "function" and refer to
> Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> 
> Then "alt1", "alt2" etc are non-functional names of functions.
> Use the real function names, like "spi0" or so. This
> alt-business seems to be just a shortcut to make it
> simple, don't do that.
> 
> Then you use e.g. "spi0" as a group name. I prefer you
> call that "spi0_grp" or something to say it is a group of
> pins associated with spi0, as spi0 is actually the
> function.
> 
Hmmm, I did this by following brcm,bcm11351-pinctrl.txt:
- function: String. Specifies the pin mux selection. Values must be one
of: "alt1", "alt2", "alt3", "alt4"

But you are right, in the pinctrl binding document it describes the
generic pin multiplexing nodes use "function" and "group".

Let me try to explain how the Cygnus pinctrl controller works and maybe
you can help to comment whether or not it's suitable for what's
described in pinctrl-binding.txt for the usage of "function" and "group".

The Cygnus pinctrl contoller has a limitation that the mux configuration
can only be group based. "group" here is a real configuration in the
Cygnus pinctrl controller registers. One can configure a "group" to
alternate function 1, 2, 3, or 4.

For example, the group "lcd" covers 30 pins. When I configure "lcd" to
alternate function 1, all 30 pins are muxed to LCD function. When
configured to function 2, all pins are muxed to SRAM function. Now, here
comes the issue, when configured to function 3, pins 1-15 and 20-30
become GPIO function, but pins 16-19 becomes SPI5 function. When it's
configured to function 4, all 30 pins become GPIO.

In some other cases, when I configure a group to other functions, there
could be spare pins which become unused (not brought out to the pad).
Or, the spare pins may also become a separate function.

Based on the LCD example, I'd assume I would do the following for the
default LCD function:

lcd_node {
	group = "lcd_grp";
	function = "lcd";
};

And in the case of function 3, I would call the function "spi5" and
assume the rest of pins become either GPIO (or unused)?

spi5_node {
	group = "lcd_grp";
	function = "spi5";
};


> If unsure of the definitions of group and function, refer
> to Documentation/pinctrl.txt
> 
> Yours,
> Linus Walleij
> 
