From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 23 Jan 2015 09:56:51 +0100
Subject: [PATCH v3/resend 3/4] drivers: bus: Add Simple Power-Managed Bus
 DT Bindings
In-Reply-To: <7hvbjy30an.fsf@deeprootsystems.com>
References: <1421919253-4784-1-git-send-email-geert+renesas@glider.be>
 <1421919253-4784-4-git-send-email-geert+renesas@glider.be>
 <7hvbjy30an.fsf@deeprootsystems.com>
Message-ID: <CAMuHMdUMcyXdgv+xdd8Zo67rYnfh6JaSWfr1H3c6NrQs=JsNLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thu, Jan 22, 2015 at 11:42 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Geert Uytterhoeven <geert+renesas@glider.be> writes:
>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>> ---
>> v3:
>>   - Add Tested-by,
>>   - Document required properties inherited from "simple-bus",
>>   - Document required "reg" property for "renesas,bsc",
>>   - Move "ranges" before "reg" in the example,
>>
>> v2:
>>   - New.
>> ---
>>  .../devicetree/bindings/bus/simple-pm-bus.txt      | 52 ++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/bus/simple-pm-bus.txt
>>
>> diff --git a/Documentation/devicetree/bindings/bus/simple-pm-bus.txt b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
>> new file mode 100644
>> index 0000000000000000..d03abf7fd8e3997a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
>> @@ -0,0 +1,52 @@
>> +Simple Power-Managed Bus
>> +========================
>> +
>> +A Simple Power-Managed Bus is a transparent bus that doesn't need a real
>> +driver, as it's typically initialized by the boot loader.
>> +
>> +However, its bus controller is part of a PM domain, or under the control of a
>> +functional clock.  Hence, the bus controller's PM domain and/or clock must be
>> +enabled for child devices connected to the bus (either on-SoC or externally)
>> +to function.
>> +
>> +
>> +Generic compatible values and properties
>> +----------------------------------------
>> +
>> +Required properties:
>> +  - compatible: Must be at least one of the vendor-specific compatible values
>> +             from a vendor-specific section below, and "simple-bus" as a
>> +             fallback.
>
> What happened to the idea of using something like "simple-pm-bus"?

I think that's a decision to make by the (successor of the) ePAPR committee.
At least it would be nice to get some feedback from the DT review team
about this.

If we go that road, the vendor-specific compatible value should still be
documented, else checkpatch will complain when encountering it in a DTS.
Then, should it become

    compatible = "renesas,bsc-sh73a0", "renesas,bsc", "simple-pm-bus",
"simple-bus";

or should "simple-bus" just be added to of_default_bus_match_table[], so we
can drop "simple-bus" from the list in the DTS:

    compatible = "renesas,bsc-sh73a0", "renesas,bsc", "simple-pm-bus";

> There's nothing vendor-specific in the driver at all, so the
> vendor-specific binding seem like clutter to me and will result in
> continuing to add vendor-specific compatibles without any
> vendor-specific code.

So far not many users or other interested parties chimed in, so that's
still to be seen. If/when this happens, we can remove the vendor-specific
matching from the driver, and add a quirk, to add a "simple-pm-bus"
compatible value where needed, to platform code, right?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
