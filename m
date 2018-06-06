From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 6 Jun 2018 21:42:59 +0200
Subject: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
In-Reply-To: <CAL_JsqJCkP_c_wKGRc7Qzkiw8sZLRf6MGz-WgVsLjnQfqK8r6Q@mail.gmail.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com>
 <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <bbbd287c-437e-d7bd-d40f-6bb914d96860@gmail.com>
 <CAL_JsqJCkP_c_wKGRc7Qzkiw8sZLRf6MGz-WgVsLjnQfqK8r6Q@mail.gmail.com>
Message-ID: <CAMuHMdXv2UXTx_ttCqytH2TePoJ-Pw4gJ-PaSOmUL969ac1BMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Jun 6, 2018 at 9:35 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Wed, Jun 6, 2018 at 2:30 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> On 06/05/18 23:36, Michel Pollet wrote:
>>> On 05 June 2018 18:34, Frank wrote:
>>>> On 06/05/18 04:28, Michel Pollet wrote:
>>>>> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time,
>>>>> it requires a special enable method to get it started.
>>>>>
>>>>> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

>>>>> --- /dev/null
>>>>> +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c

>>>>> +/*
>>>>> + * The second CPU is parked in ROM at boot time. It requires waking
>>>>> +it after
>>>>> + * writing an address into the BOOTADDR register of sysctrl.
>>>>> + *
>>>>> + * So the default value of the "cpu-release-addr" corresponds to
>>>> BOOTADDR...
>>>>> + *
>>>>> + * *However* the BOOTADDR register is not available when the kernel
>>>>> + * starts in NONSEC mode.
>>>>> + *
>>>>> + * So for NONSEC mode, the bootloader re-parks the second CPU into a
>>>>> +pen
>>>>> + * in SRAM, and changes the "cpu-release-addr" of linux's DT to a
>>>>> +SRAM address,
>>>>> + * which is not restricted.
>>>>
>>>> The binding document for cpu-release-addr does not have a definition for 32
>>>> bit arm.  The existing definition is only 64 bit arm.  Please add the definition
>>>> for 32 bit arm to patch 1.
>>>
>>> Hmmm I do find a definition in
>>> Documentation/devicetree/bindings/arm/cpus.txt -- just under where I
>>> added my 'enable-method' -- And it is already used as 32 bits in at least
>>> arch/arm/boot/dts/stih407-family.dtsi.
>>
>> From cpus.txt:
>>
>>         - cpu-release-addr
>>                 Usage: required for systems that have an "enable-method"
>>                        property value of "spin-table".
>>                 Value type: <prop-encoded-array>
>>                 Definition:
>>                         # On ARM v8 64-bit systems must be a two cell
>>                           property identifying a 64-bit zero-initialised
>>                           memory location.
>>
>> The definition specifies a two cell property for 64-bit systems.
>>
>> Please add to the definition that cpu-release-addr is a one cell property
>> for 32-bit systems.
>
> Actually, this is all already documented in the DT spec and it is
> always 2 cells[1]. We should perhaps just remove whatever is
> duplicated from the spec.
>
> Rob
>
> [1]
>    ``cpu-release-addr``   | SD  | ``<u64>``        The
> cpu-release-addr property is required for
>                                                    cpu nodes that have
> an enable-method property
>                                                    value of
> ``"spin-table"``. The value specifies the
>                                                    physical address of
> a spin table entry that
>                                                    releases a
> secondary CPU from its spin loop.

Interesting. But why is this <u64>, and not just following #address-cells?
Due to the ePAPR-spec being 64-bit Power System-centric?

There's also "initial-mapped-area", which must use 64-bit values for effective
and physical addresses, according to ePAPR.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
