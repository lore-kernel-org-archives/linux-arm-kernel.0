From: robh@kernel.org (Rob Herring)
Date: Wed, 21 Oct 2015 17:08:15 -0500
Subject: [PATCH v3 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <87a8rcegz2.fsf@eliezer.anholt.net>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
 <1444426068-15817-2-git-send-email-eric@anholt.net>
 <CAL_JsqKbAm1=70GaDRg1Z47A9d9FShwpWacMOjr+FE8bZuocVg@mail.gmail.com>
 <87lhb63a60.fsf@eliezer.anholt.net>
 <CAL_JsqJ3ErrFQxA9pLV7pvG3pCEkPFRfE6sGER5uBeFbmDEnxA@mail.gmail.com>
 <87a8rcegz2.fsf@eliezer.anholt.net>
Message-ID: <CAL_JsqK+2k6e3QYFkr9JfeoRZ_EnQUhKcEpxTinwRNd4AAwUnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 3:57 AM, Eric Anholt <eric@anholt.net> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> On Tue, Oct 13, 2015 at 1:17 PM, Eric Anholt <eric@anholt.net> wrote:
>>> Rob Herring <robh@kernel.org> writes:
>>>
>>>> On Fri, Oct 9, 2015 at 4:27 PM, Eric Anholt <eric@anholt.net> wrote:

[...]

>>>>> +Required properties for Pixel Valve:
>>>>> +- compatible:  Should be one of "brcm,bcm2835-pixelvalve0",
>>>>> +               "brcm,bcm2835-pixelvalve1", or "brcm,bcm2835-pixelvalve2"
>>>>> +- reg:         Physical base address and length of the PV's registers
>>>>> +- interrupts:  The interrupt number
>>>>> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>>>>> +
>>>>> +Required properties for HVS:
>>>>> +- compatible:  Should be "brcm,bcm2835-hvs"
>>>>> +- reg:         Physical base address and length of the HVS's registers
>>>>> +- interrupts:  The interrupt number
>>>>> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>>>>> +
>>>>> +Required properties for HDMI
>>>>
>>>> Is HDMI the only output possibility? If not, then you should have OF
>>>> graph nodes describing the connection between HDMI block and HVS (or
>>>> PV?).
>>>
>>> I'm using compatible strings for the different instances of the module:
>>> brcm,bcm2835-pixelvalve0/1/2.  This lets the connections get wired up
>>> cleanly and understandably within the driver.  I spent a long time
>>> trying to come up with an OF graph-based implementation, and I
>>> eventually gave up.
>>
>> I missed that before, but sorry, that's not how you should be using
>> compatible strings. What was your issue with OF graph? It can be
>> difficult to parse. I'd like to improve that with more common parsing
>> code.
>
> pv2 is definitely different hardware than pv0/1 (some different source
> files, not just connections at hw module instantiation).  This seems to
> be an obvious case for compatible strings.  I haven't looked enough into
> pv0/1 to tell if they're different at a hardware level, since I haven't
> added any support for the encoders using them yet.

If you can come up with something more descriptive that would be good.
Certain features or capabilities for example. If not, I guess this is
okay. I worry that the numbering could be different in a future part,
but the IP otherwise unchanged. Then you would not be able to use
these compatible strings.

> OF graph: Doesn't appear to solve any problems that the driver has.  The
> pv needs to know what kind of encoder is downstream to make choices
> about its programming.  The bits in its documentation refer to encoders
> by name.  I could write up a ton of DT bindings trying to generate an
> abstraction so that the driver could map back to what it has today, but
> it would just make the driver more obfuscated and error prone.  It's
> much cleaner to let the two driver submodules talk to each other and
> sort it out.

Okay.

>>>>> +- compatible:  Should be "brcm,bcm2835-hdmi"
>>>>> +- reg:         Physical base address and length of the two register ranges
>>>>> +                 ("HDMI" and "HD", in that order)
>>>>> +- interrupts:  The interrupt numbers
>>>>> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>>>>> +- ddc:         phandle of the I2C controller used for DDC EDID probing
>>>>> +- clocks:      a) hdmi: The HDMI state machine clock
>>>>> +               b) pixel: The pixel clock.
>>>>> +
>>>>> +Optional properties for HDMI:
>>>>> +- hpd-gpio:    The GPIO pin for HDMI hotplug detect (if it doesn't appear
>>>>
>>>> *-gpio is deprecated, so "hpd-gpios".
>>>>
>>>> Really, I think this and ddc should be in hdmi-connector binding node.
>>>> What has been done for bindings so far is all over the map though.
>>>
>>> You say hpd-gpios is deprectated, but that I should use the
>>> hdmi-connector binding that uses hpd-gpios.  Which one is it?  If
>>> hpd-gpios deprecated, what is supposed to be used instead?
>>
>> No, I said "hpd-gpio" with no "s" is deprecated. In other words,
>> always use -gpios whether it is 1 or more gpio.
>
> Fixed.
>
>> The connector part is a separate issue of the location of these
>> properties. If you think about it, the gpio line and I2C bus have
>> nothing to do with the HDMI node. That's different than cases of HDMI
>> bridges which have a HPD signal and dedicated I2C controller. Most
>> examples in the kernel have not followed this and do as you have. I
>> only have a desire to have common binding and code to handle
>> connectors at this point, but that is the direction I want to go.
>
> If you come up with common code that makes driver development easier
> instead of harder, I'll be interested to see.

The start is common bindings. :)

Rob
