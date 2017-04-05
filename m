From: robh@kernel.org (Rob Herring)
Date: Wed, 5 Apr 2017 14:11:58 -0500
Subject: [PATCH 2/3] dt-bindings: arm: amlogic: Add SoC information
 bindings
In-Reply-To: <d263ba90-2352-5253-9704-050afcc37761@baylibre.com>
References: <1490950079-10145-1-git-send-email-narmstrong@baylibre.com>
 <1490950079-10145-3-git-send-email-narmstrong@baylibre.com>
 <CAK8P3a199j=7mb=CMgROvaOCVU8=kYda9wkvG3O4rtqweSyC0g@mail.gmail.com>
 <4ab7d4ee-e805-69f1-b76b-b827b46285bd@baylibre.com>
 <20170403163448.e7uuhhebqlaf33bl@rob-hp-laptop>
 <265460a5-9295-f58a-f149-030e5dd750a1@baylibre.com>
 <CAL_JsqKWi=sNgOTTw6+PAxwgFyFQMw6BiUz0uNuG4kWr+ORO_g@mail.gmail.com>
 <d263ba90-2352-5253-9704-050afcc37761@baylibre.com>
Message-ID: <CAL_Jsq+1BTRjDVuLv8REBYE21LExe829pi-GM9rwEBHZ+6pagQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 4, 2017 at 7:49 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 04/04/2017 02:26 PM, Rob Herring wrote:
>> On Tue, Apr 4, 2017 at 3:51 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>> On 04/03/2017 06:34 PM, Rob Herring wrote:
>>>> On Fri, Mar 31, 2017 at 04:10:30PM +0200, Neil Armstrong wrote:
>>>>> On 03/31/2017 03:44 PM, Arnd Bergmann wrote:
>>>>>> On Fri, Mar 31, 2017 at 10:47 AM, Neil Armstrong
>>>>>> <narmstrong@baylibre.com> wrote:
>>>>>>> Add bindings for the SoC information register of the Amlogic SoCs.
>>>>>>>
>>>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>>>> ---
>>>>>>>  Documentation/devicetree/bindings/arm/amlogic.txt | 20 ++++++++++++++++++++
>>>>>>>  1 file changed, 20 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
>>>>>>> index bfd5b55..b850985 100644
>>>>>>> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
>>>>>>> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
>>>>>>> @@ -52,3 +52,23 @@ Board compatible values:
>>>>>>>    - "amlogic,q201" (Meson gxm s912)
>>>>>>>    - "nexbox,a95x" (Meson gxbb or Meson gxl s905x)
>>>>>>>    - "nexbox,a1" (Meson gxm s912)
>>>>>>> +
>>>>>>> +Amlogic Meson GX SoCs Information
>>>>>>> +----------------------------------
>>>>>>> +
>>>>>>> +The Meson SoCs have a Product Register that allows to retrieve SoC type,
>>>>>>> +package and revision information. If present, a device node for this register
>>>>>>> +should be added.
>>>>>>> +
>>>>>>> +Required properties:
>>>>>>> +  - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-socinfo".
>>>>>>> +  - reg: Base address and length of the register block.
>>>>>>> +
>>>>>>> +Examples
>>>>>>> +--------
>>>>>>> +
>>>>>>> +       chipid at 220 {
>>>>>>> +               compatible = "amlogic,meson-gx-socinfo";
>>>>>>> +               reg = <0x0 0x00220 0x0 0x4>;
>>>>>>> +       };
>>>>>>> +
>>>>>>
>>>>>> The register location would hint that this is in the middle of some block of
>>>>>> random registers, i.e. a syscon or some unrelated device.
>>>>>>
>>>>>> Are you sure that "socinfo" is the actual name of the IP block and that
>>>>>> it only has a single 32-bit register?
>>>>>>
>>>>>>      Arnd
>>>>>>
>>>>>
>>>>> Hi Arnd,
>>>>>
>>>>> I'm sorry I did not find any relevant registers in the docs or source code describing
>>>>> it in a specific block of registers, and no close enough register definitions either.
>>>>> They may be used by the secure firmware I imagine.
>>>>>
>>>>> For the register name, Amlogic refers it to "cpu_version" in their code, but it really
>>>>> gives some details on the whole SoC and package, and socinfo seems better.
>>>>
>>>> A register at address 0x220 seems a bit strange (unless there's ranges
>>>> you're not showing), but ROM code at this address would be fairly
>>>> typical. And putting version information into the ROM is also common.
>>>>
>>>> Rob
>>>>
>>>
>>> Hi Rob.
>>>
>>> Indeed it's part of a larger range :
>>>                  aobus: aobus at c8100000 {
>>>                         compatible = "simple-bus";
>>>                         reg = <0x0 0xc8100000 0x0 0x100000>;
>>>                         #address-cells = <2>;
>>>                         #size-cells = <2>;
>>>                         ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
>>>
>>>
>>> While scrubbing on the uboot source, I found a sort of block of registers dedicated to communicate with
>>> the secure firmware :
>>> AO_SEC_REG0                                                     0x140
>>> AO_SEC_REG1                                                     0x144
>>> AO_SEC_REG2                                                     0x148
>>> AO_SEC_TMODE_PWD0                                               0x160
>>> AO_SEC_TMODE_PWD1                                               0x164
>>> AO_SEC_TMODE_PWD2                                               0x168
>>> AO_SEC_TMODE_PWD3                                               0x16C
>>> AO_SEC_SCRATCH                                                  0x17C
>>> AO_SEC_JTAG_PWD0                                                0x180
>>> AO_SEC_JTAG_PWD1                                                0x184
>>> AO_SEC_JTAG_PWD2                                                0x188
>>> AO_SEC_JTAG_PWD3                                                0x18C
>>> AO_SEC_JTAG_SEC_CNTL                                            0x190
>>> AO_SEC_JTAG_PWD_ADDR0                                           0x194
>>> AO_SEC_JTAG_PWD_ADDR1                                           0x198
>>> AO_SEC_JTAG_PWD_ADDR2                                           0x19C
>>> AO_SEC_JTAG_PWD_ADDR3                                           0x1A0
>>> AO_SEC_SHARED_AHB_SRAM_REG0_0                                   0x1C0
>>> AO_SEC_SHARED_AHB_SRAM_REG0_1                                   0x1C4
>>> AO_SEC_SHARED_AHB_SRAM_REG0_2                                   0x1C8
>>> AO_SEC_SHARED_AHB_SRAM_REG1_0                                   0x1CC
>>> AO_SEC_SHARED_AHB_SRAM_REG1_1                                   0x1D0
>>> AO_SEC_SHARED_AHB_SRAM_REG1_2                                   0x1D4
>>> AO_SEC_SHARED_AHB_SRAM_REG2_0                                   0x1D8
>>> AO_SEC_SHARED_AHB_SRAM_REG2_1                                   0x1DC
>>> AO_SEC_SHARED_AHB_SRAM_REG2_2                                   0x1E0
>>> AO_SEC_SHARED_AHB_SRAM_REG3_0                                   0x1E4
>>> AO_SEC_SHARED_AHB_SRAM_REG3_1                                   0x1E8
>>> AO_SEC_SHARED_AHB_SRAM_REG3_2                                   0x1EC
>>> AO_SEC_AO_AHB_SRAM_REG0_0                                       0x1F0
>>> AO_SEC_AO_AHB_SRAM_REG0_1                                       0x1F4
>>> AO_SEC_AO_AHB_SRAM_REG1_0                                       0x1F8
>>> AO_SEC_AO_AHB_SRAM_REG1_1                                       0x1FC
>>> AO_SEC_SD_CFG8                                                  0x220
>>> AO_SEC_SD_CFG9                                                  0x224
>>> AO_SEC_SD_CFG10                                                 0x228
>>> AO_SEC_SD_CFG11                                                 0x22C
>>> AO_SEC_SD_CFG12                                                 0x230
>>> AO_SEC_SD_CFG13                                                 0x234
>>> AO_SEC_SD_CFG14                                                 0x238
>>> AO_SEC_SD_CFG15                                                 0x23C
>>> AO_SEC_GP_CFG0                                                  0x240
>>> AO_SEC_GP_CFG1                                                  0x244
>>> AO_SEC_GP_CFG2                                                  0x248
>>> AO_SEC_GP_CFG3                                                  0x24C
>>> AO_SEC_GP_CFG4                                                  0x250
>>> AO_SEC_GP_CFG5                                                  0x254
>>> AO_SEC_GP_CFG6                                                  0x258
>>> AO_SEC_GP_CFG7                                                  0x25C
>>> AO_SEC_GP_CFG8                                                  0x260
>>> AO_SEC_GP_CFG9                                                  0x264
>>> AO_SEC_GP_CFG10                                                 0x268
>>> AO_SEC_GP_CFG11                                                 0x26C
>>> AO_SEC_GP_CFG12                                                 0x270
>>> AO_SEC_GP_CFG13                                                 0x274
>>> AO_SEC_GP_CFG14                                                 0x278
>>> AO_SEC_GP_CFG15                                                 0x27C
>>>
>>>
>>> As you see, the register we use here is AO_SEC_SD_CFG8...
>>>
>>> Should I define all this block as simple-mfd and refer to it as a regmap ?
>>>
>>> aobus: aobus at c8100000 {
>>>         compatible = "simple-bus";
>>>         reg = <0x0 0xc8100000 0x0 0x100000>;
>>>         #address-cells = <2>;
>>>         #size-cells = <2>;
>>>         ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
>>>
>>>         ao_secure: ao-secure at 140 {
>>>                 compatible = "amlogic,meson-gx-ao-secure", "simple-mfd";
>>>                 reg = <0x0 0x140 0x0 0x140>;
>>>         };
>>> };
>>>
>>> chipid {
>>>         compatible = "amlogic,meson-gx-socinfo";
>>>         ao-secure = <&ao_secure>;
>>>         chip-info-reg = <0xe0>;
>>
>> Why even divide it up further in DT? IMO, describing single
>> registers/address in DT is too fine grained.
>>
>> Rob
>>
>
> Rob, I don't get it.
>
> Maybe something like that ?
>
> aobus: aobus at c8100000 {
>         compatible = "simple-bus";
>         reg = <0x0 0xc8100000 0x0 0x100000>;
>         #address-cells = <2>;
>         #size-cells = <2>;
>         ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
>
>         ao_secure: ao-secure at 140 {
>                 compatible = "amlogic,meson-gx-ao-secure", "simple-mfd", "simple-bus";
>                 reg = <0x0 0x140 0x0 0x140>;
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>
>                 chipid at e0 {
>                         compatible = "amlogic,meson-gx-socinfo";
>                         reg = <0xe0 0x4>;
>                 };
>         };
> };

That's somewhat better, though your addressing is wrong.

>
> Concerning the fine graining, I'm sorry but the actual information comes from a single register here...

Yes, but the only useful information here is really "0xe0". I imagine
you also want "amlogic,meson-gx-socinfo" to instantiate a driver, but
that's not a reason to put a node into DT. You can just easily have
whatever handles "amlogic,meson-gx-ao-secure" provide the version
information out of register 0xe0.

Rob
