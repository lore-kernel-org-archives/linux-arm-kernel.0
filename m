From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Sep 2013 10:59:58 -0600
Subject: [PATCH] clk: si570: Add a driver for SI570 oscillators
In-Reply-To: <20130916164927.GB21352@roeck-us.net>
References: <1379033737-30015-1-git-send-email-soren.brinkmann@xilinx.com>
 <1379033737-30015-2-git-send-email-soren.brinkmann@xilinx.com>
 <52373314.5070806@wwwdotorg.org> <20130916164927.GB21352@roeck-us.net>
Message-ID: <5237390E.5070203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2013 10:49 AM, Guenter Roeck wrote:
> On Mon, Sep 16, 2013 at 10:34:28AM -0600, Stephen Warren wrote:
>> On 09/12/2013 06:55 PM, Soren Brinkmann wrote:
>>> Add a driver for SILabs 570, 571, 598, 599 programmable oscillators.
>>> The devices generate low-jitter clock signals and are reprogrammable via
>>> an I2C interface.
>>
>>> diff --git a/Documentation/devicetree/bindings/clock/silabs,si570.txt b/Documentation/devicetree/bindings/clock/silabs,si570.txt
>>
>>> +Required properties:
>>> + - compatible: Shall be one of "silabs,si57x", "silabs,si59x".
>>> + - reg: I2C device address.
>>> + - #clock-cells: From common clock bindings: Shall be 0.
>>> + - factory-fout: Factory set default frequency
>>
>> So, there's no way to query this from the device at all? Looking at the
>> data-sheet, all the frequency generation parameters are in registers,
>> and the device supports I2C read commands. As such, I'm not convinced
>> this property is necessary.
>
> Unfortunately, the chip does not report the factory setting for fout,
> so the property is needed. The chip can not be programmed without it.

So fout is not the default overall output frequency, but rather
something internal that that feeds into the frequency generation
process, and the registers in the device only describe that frequency
generation process, not the frequency that feeds into it?

If so, it might be worth enhancing the binding documentation to briefly
describe that. Presumably the details are all in the HW documentation,
but it'd be nice if the binding doc was obviously correct without having
to fully understand the entire HW documentation.

>>> +Optional properties:
>>> + - initial-fout: Initial output frequency to set during probe
>>
>> "probe" is a Linux-specific concept. This property should be removed. If
>> the driver is asked to set a specific frequency, it should do so, but I
>> don't think it should program something pro-actively just because it
>> starts up.
>>
>> If this property is acceptable, it'd be better to describe it more along
>> the lines of the following:
>>
>> initial-fout: The frequency at which the system requires the clock to
>> operate.
>
> It should probably be something like "clock-frequency". In many use cases
> the programmed frequency is set to a constant frequency at system startup
> and never changed, similar to other clocks.

I was going to suggest that too, but re-considered since I think
clock-frequency is more appropriate for fixed-frequency clocks, rather
than to specify the value at which a programmable clock generator should
operate?

I don't think we have a good story yet for how to represent
how-we-want-the-clock-tree-configured, as opposed to representing the HW
itself (which is what DT should be more about).
