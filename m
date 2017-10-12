From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Oct 2017 23:24:21 +0100
Subject: [PATCH v3 2/2] drivers/irqchip: gicv3: add workaround for
 Synquacer pre-ITS
In-Reply-To: <CAL_Jsq+5L=gOzb=NzPJ8CSpqAbnwN3=LWvN2f07=AejwFMbOGg@mail.gmail.com>
References: <20171012183247.23679-1-ard.biesheuvel@linaro.org>
 <20171012183247.23679-3-ard.biesheuvel@linaro.org>
 <CAL_Jsq+5L=gOzb=NzPJ8CSpqAbnwN3=LWvN2f07=AejwFMbOGg@mail.gmail.com>
Message-ID: <CAKv+Gu-rZNhMMU4PoD8V0nBtwEEu+HE71wvaAZk2PWshoeTi4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 October 2017 at 22:34, Rob Herring <robh+dt@kernel.org> wrote:
> On Thu, Oct 12, 2017 at 1:32 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> The Socionext Synquacer SoC's implementation of GICv3 has a so-called
>> 'pre-ITS', which maps 32-bit writes targeted at a separate window of
>> size '4 << device_id_bits' onto writes to GITS_TRANSLATER with device
>> ID taken from bits [device_id_bits + 1:2] of the window offset.
>> Writes that target GITS_TRANSLATER directly are reported as originating
>> from device ID #0.
>>
>> So add a workaround for this. Given that this breaks isolation, clear
>> the IRQ_DOMAIN_FLAG_MSI_REMAP flag as well.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt |  4 ++
>>  arch/arm64/Kconfig                                                    |  8 +++
>>  drivers/irqchip/irq-gic-v3-its.c                                      | 63 +++++++++++++++++++-
>>  3 files changed, 72 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> index 4c29cdab0ea5..0798a61bbf99 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> @@ -75,6 +75,10 @@ These nodes must have the following properties:
>>  - reg: Specifies the base physical address and size of the ITS
>>    registers.
>>
>> +Optional:
>> +- socionext,synquacer-pre-its: (u32, u32) tuple describing the host address
>> +  and size of the pre-ITS window, as implemented on the Socionext Synquacer SoC
>
> Sounds like a separate h/w block to me and addresses should be in
> "reg". I would suggest you define a separate node for the pre-its
> block and then use of_find_compatible_node() from the GIC driver to
> retrieve the node and whatever you need from it. Or do an SoC specific
> compatible string for the GIC and let that imply whatever information
> you need. Then the next quirk doesn't need a DT update.
>

For my understanding, you mean either

    gic: interrupt-controller at 30000000 {
        compatible = "arm,gic-v3";
        ...

        its: gic-its at 30020000 {
            compatible = "arm,gic-v3-its";
            reg = <0x0 0x30020000 0x0 0x20000>;
            #msi-cells = <1>;
            msi-controller;
        };
    };

    preits at 58000000 {
        compatible = "socionext,synquacer-pre-its";
        reg = <0x0 0x58000000 0x0 0x200000>;
        msi-slave = <&its>;
    };

or

    gic: interrupt-controller at 30000000 {
        compatible = "arm,gic-v3";
        ...

        its: gic-its at 30020000 {
            compatible = "socionext,synquacer-pre-its", "arm,gic-v3-its";
            reg = <0x0 0x30020000 0x0 0x20000>,
                  <0x0 0x58000000 0x0 0x200000>;
            #msi-cells = <1>;
            msi-controller;
        };
    };

right?

Marc, what do you think? IIRC we did discuss option #2 at some point,
but I don't remember if/why we rejected it.
