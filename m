From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Sep 2015 15:32:11 +0800
Subject: [PATCH v3 1/8] rsb: Add generic Reduced Serial Bus (RSB)
 controller binding documentation
In-Reply-To: <CAL_JsqJA6MEtnF35ThPDgVmEZHyui39-HLsefWPQ1tzzfLAW3w@mail.gmail.com>
References: <1439958009-14056-1-git-send-email-wens@csie.org>
 <1439958009-14056-2-git-send-email-wens@csie.org>
 <CAL_JsqJA6MEtnF35ThPDgVmEZHyui39-HLsefWPQ1tzzfLAW3w@mail.gmail.com>
Message-ID: <CAGb2v65dai3At24HhUY9h-dCs1jEXiwqgOMefziokJXa00Ercw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 6:43 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Aug 18, 2015 at 11:20 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>> Reduced Serial Bus is a proprietary 2-line push-pull serial bus
>> supporting multiple slave devices.
>>
>> It was developed by Allwinner, Inc. and used by Allwinner and X-Powers,
>> Inc. for their line of PMICs and other peripheral ICs.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  Documentation/devicetree/bindings/rsb/rsb.txt | 50 +++++++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rsb/rsb.txt
>>
>> diff --git a/Documentation/devicetree/bindings/rsb/rsb.txt b/Documentation/devicetree/bindings/rsb/rsb.txt
>> new file mode 100644
>> index 000000000000..0b027948ca9c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rsb/rsb.txt
>> @@ -0,0 +1,50 @@
>> +Reduced Serial Bus (RSB) Controller
>> +
>> +This document defines a generic set of bindings for use by RSB controllers.
>> +A controller is modelled in device tree as a node with zero or more child
>> +nodes, each representing a unique slave device on the bus.
>> +
>> +Required properties:
>> +
>> + - #address-cells : must be 2
>> + - #size-cells : must be 0
>> +
>> +Optional properties:
>> +
>> + - clock-frequency : Desired bus clock frequency in Hz. Maximum is 20 MHz.
>> +
>> +Child nodes:
>> +
>> +An RSB controller node can contain zero or more child nodes representing
>> +slave devices on the bus.  Child 'reg' properties are specified as a
>> +runtime address, hardware address pair. The hardware address is hardwired
>> +in the device, which can normally be found in the datasheet. The runtime
>> +address is set by software. No 2 devices on the same bus shall have the
>> +same runtime address.
>> +
>> +Valid runtime addresses - There are only 15 valid runtime addresses:
>> +
>> +    0x17, 0x2d, 0x3a, 0x4e, 0x59, 0x63, 0x74, 0x8b,
>> +    0x9c, 0xa6, 0xb1, 0xc5, 0xd2, 0xe8, 0xff
>> +
>> +It is highly recommended that one choose the same runtime addresses as
>> +vendor BSPs use so that a) the addresses remain the same across different
>> +software systems, and b) addresses of supported and listed slave devices
>> +don't conflict with unsupported or not yet listed devices.
>
> I fail to understand why the run-time address belongs in DT or why
> alignment to vendor BSP matters? I can see the desire to align DTs if
> the vendor OS was dependent on having this information. Having to
> access the vendor OS to determine what address to pick does not seem
> like the right way to write a DTS. It seems to me that the RSB bus
> driver should allocate run-time addresses dynamically.

I agree it seems better that the driver should allocate them dynamically.
However my attempts to reset the runtime addresses all fail, with the
device in question rejecting the request.

I'll run some more tests. Another way would be for the driver to test
if the device was already allocated an address, and just use that. If
not, then just allocate one to it. The implementation is a bit more
complicated, as there's no lookup function.

But if we cannot reliably reset the runtime addresses, I don't see
any alternative to putting the address in the DT. Most of the use cases
we want to support are PMICs, which are initialized by the boot loader.


Regards
ChenYu
