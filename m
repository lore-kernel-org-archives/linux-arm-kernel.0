From: robh@kernel.org (Rob Herring)
Date: Tue, 13 Oct 2015 16:56:47 -0500
Subject: [PATCH v3 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <87lhb63a60.fsf@eliezer.anholt.net>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
 <1444426068-15817-2-git-send-email-eric@anholt.net>
 <CAL_JsqKbAm1=70GaDRg1Z47A9d9FShwpWacMOjr+FE8bZuocVg@mail.gmail.com>
 <87lhb63a60.fsf@eliezer.anholt.net>
Message-ID: <CAL_JsqJ3ErrFQxA9pLV7pvG3pCEkPFRfE6sGER5uBeFbmDEnxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 1:17 PM, Eric Anholt <eric@anholt.net> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> On Fri, Oct 9, 2015 at 4:27 PM, Eric Anholt <eric@anholt.net> wrote:
>>> ---
>>>
>>> v2: Extend the commit message, fix several nits from Stephen Warren.
>>> v3: Rename the compatibility strings, clean up node names, drop the
>>>     unnecessary lists of components.  Use compatibility strings for
>>>     choosing CRTC HVS channel numbers.  Document the HDMI clock usage.
>>>
>>>  .../devicetree/bindings/gpu/brcm,bcm-vc4.txt       | 64 ++++++++++++++++++++++
>>
>> Can you put this in bindings/display/ instead? Things are moving there in 4.4.
>
> Sure.
>
>>>  1 file changed, 64 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
>>> new file mode 100644
>>> index 0000000..175bcde
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
>>> @@ -0,0 +1,64 @@
>>> +Broadcom VC4 GPU
>>> +
>>> +The VC4 device present on the Raspberry Pi includes a display system
>>> +with HDMI output and the HVS scaler for compositing display planes.
>>> +
>>> +Required properties for VC4:
>>> +- compatible:  Should be "brcm,bcm2835-vc4"
>>
>> reg property? interrupts? clocks?
>
> This is the subsystem node.  It has no other properties currently.

In the example, it looks like the gpu. You also have a unit address
which implies you need a reg property.

>>> +Required properties for Pixel Valve:
>>> +- compatible:  Should be one of "brcm,bcm2835-pixelvalve0",
>>> +               "brcm,bcm2835-pixelvalve1", or "brcm,bcm2835-pixelvalve2"
>>> +- reg:         Physical base address and length of the PV's registers
>>> +- interrupts:  The interrupt number
>>> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>>> +
>>> +Required properties for HVS:
>>> +- compatible:  Should be "brcm,bcm2835-hvs"
>>> +- reg:         Physical base address and length of the HVS's registers
>>> +- interrupts:  The interrupt number
>>> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>>> +
>>> +Required properties for HDMI
>>
>> Is HDMI the only output possibility? If not, then you should have OF
>> graph nodes describing the connection between HDMI block and HVS (or
>> PV?).
>
> I'm using compatible strings for the different instances of the module:
> brcm,bcm2835-pixelvalve0/1/2.  This lets the connections get wired up
> cleanly and understandably within the driver.  I spent a long time
> trying to come up with an OF graph-based implementation, and I
> eventually gave up.

I missed that before, but sorry, that's not how you should be using
compatible strings. What was your issue with OF graph? It can be
difficult to parse. I'd like to improve that with more common parsing
code.


>>> +- compatible:  Should be "brcm,bcm2835-hdmi"
>>> +- reg:         Physical base address and length of the two register ranges
>>> +                 ("HDMI" and "HD", in that order)
>>> +- interrupts:  The interrupt numbers
>>> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>>> +- ddc:         phandle of the I2C controller used for DDC EDID probing
>>> +- clocks:      a) hdmi: The HDMI state machine clock
>>> +               b) pixel: The pixel clock.
>>> +
>>> +Optional properties for HDMI:
>>> +- hpd-gpio:    The GPIO pin for HDMI hotplug detect (if it doesn't appear
>>
>> *-gpio is deprecated, so "hpd-gpios".
>>
>> Really, I think this and ddc should be in hdmi-connector binding node.
>> What has been done for bindings so far is all over the map though.
>
> You say hpd-gpios is deprectated, but that I should use the
> hdmi-connector binding that uses hpd-gpios.  Which one is it?  If
> hpd-gpios deprecated, what is supposed to be used instead?

No, I said "hpd-gpio" with no "s" is deprecated. In other words,
always use -gpios whether it is 1 or more gpio.

The connector part is a separate issue of the location of these
properties. If you think about it, the gpio line and I2C bus have
nothing to do with the HDMI node. That's different than cases of HDMI
bridges which have a HPD signal and dedicated I2C controller. Most
examples in the kernel have not followed this and do as you have. I
only have a desire to have common binding and code to handle
connectors at this point, but that is the direction I want to go.

Rob
