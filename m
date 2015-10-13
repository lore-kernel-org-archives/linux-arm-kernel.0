From: eric@anholt.net (Eric Anholt)
Date: Tue, 13 Oct 2015 11:17:43 -0700
Subject: [PATCH v3 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <CAL_JsqKbAm1=70GaDRg1Z47A9d9FShwpWacMOjr+FE8bZuocVg@mail.gmail.com>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
 <1444426068-15817-2-git-send-email-eric@anholt.net>
 <CAL_JsqKbAm1=70GaDRg1Z47A9d9FShwpWacMOjr+FE8bZuocVg@mail.gmail.com>
Message-ID: <87lhb63a60.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> On Fri, Oct 9, 2015 at 4:27 PM, Eric Anholt <eric@anholt.net> wrote:
>> ---
>>
>> v2: Extend the commit message, fix several nits from Stephen Warren.
>> v3: Rename the compatibility strings, clean up node names, drop the
>>     unnecessary lists of components.  Use compatibility strings for
>>     choosing CRTC HVS channel numbers.  Document the HDMI clock usage.
>>
>>  .../devicetree/bindings/gpu/brcm,bcm-vc4.txt       | 64 ++++++++++++++++++++++
>
> Can you put this in bindings/display/ instead? Things are moving there in 4.4.

Sure.

>>  1 file changed, 64 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
>>
>> diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
>> new file mode 100644
>> index 0000000..175bcde
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
>> @@ -0,0 +1,64 @@
>> +Broadcom VC4 GPU
>> +
>> +The VC4 device present on the Raspberry Pi includes a display system
>> +with HDMI output and the HVS scaler for compositing display planes.
>> +
>> +Required properties for VC4:
>> +- compatible:  Should be "brcm,bcm2835-vc4"
>
> reg property? interrupts? clocks?

This is the subsystem node.  It has no other properties currently.

>> +Required properties for Pixel Valve:
>> +- compatible:  Should be one of "brcm,bcm2835-pixelvalve0",
>> +               "brcm,bcm2835-pixelvalve1", or "brcm,bcm2835-pixelvalve2"
>> +- reg:         Physical base address and length of the PV's registers
>> +- interrupts:  The interrupt number
>> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>> +
>> +Required properties for HVS:
>> +- compatible:  Should be "brcm,bcm2835-hvs"
>> +- reg:         Physical base address and length of the HVS's registers
>> +- interrupts:  The interrupt number
>> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>> +
>> +Required properties for HDMI
>
> Is HDMI the only output possibility? If not, then you should have OF
> graph nodes describing the connection between HDMI block and HVS (or
> PV?).

I'm using compatible strings for the different instances of the module:
brcm,bcm2835-pixelvalve0/1/2.  This lets the connections get wired up
cleanly and understandably within the driver.  I spent a long time
trying to come up with an OF graph-based implementation, and I
eventually gave up.

>> +- compatible:  Should be "brcm,bcm2835-hdmi"
>> +- reg:         Physical base address and length of the two register ranges
>> +                 ("HDMI" and "HD", in that order)
>> +- interrupts:  The interrupt numbers
>> +                 See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
>> +- ddc:         phandle of the I2C controller used for DDC EDID probing
>> +- clocks:      a) hdmi: The HDMI state machine clock
>> +               b) pixel: The pixel clock.
>> +
>> +Optional properties for HDMI:
>> +- hpd-gpio:    The GPIO pin for HDMI hotplug detect (if it doesn't appear
>
> *-gpio is deprecated, so "hpd-gpios".
>
> Really, I think this and ddc should be in hdmi-connector binding node.
> What has been done for bindings so far is all over the map though.

You say hpd-gpios is deprectated, but that I should use the
hdmi-connector binding that uses hpd-gpios.  Which one is it?  If
hpd-gpios deprecated, what is supposed to be used instead?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151013/bf1c5efe/attachment-0001.sig>
