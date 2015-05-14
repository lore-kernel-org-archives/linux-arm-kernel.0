From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 14 May 2015 08:32:33 +0100
Subject: [PATCH v8 4/9] mfd: Add binding document for NVIDIA Tegra XUSB
In-Reply-To: <20150514072954.GD20358@x1>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
 <1430761002-9327-5-git-send-email-abrestic@chromium.org>
 <20150513143954.GA3394@x1>
 <CAL1qeaF-7aAx0gqPe-_D4ZaZET0Kejr801KrbvuQ_2w6c8mcnA@mail.gmail.com>
 <20150513165014.GC19543@x1>
 <CAL1qeaE7XHmreQ_b52iop6fOY1osAhjij81c4vVr7_8wO_cYxQ@mail.gmail.com>
 <20150514072954.GD20358@x1>
Message-ID: <55544F91.4060402@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 14/05/15 08:29, Lee Jones wrote:
> On Wed, 13 May 2015, Andrew Bresticker wrote:
> 
>> On Wed, May 13, 2015 at 9:50 AM, Lee Jones <lee.jones@linaro.org> wrote:
>>> On Wed, 13 May 2015, Andrew Bresticker wrote:
>>>
>>>> Lee,
>>>>
>>>> On Wed, May 13, 2015 at 7:39 AM, Lee Jones <lee.jones@linaro.org> wrote:
>>>>> On Mon, 04 May 2015, Andrew Bresticker wrote:
>>>>>
>>>>>> Add a binding document for the XUSB host complex on NVIDIA Tegra124
>>>>>> and later SoCs.  The XUSB host complex includes a mailbox for
>>>>>> communication with the XUSB micro-controller and an xHCI host-controller.
>>>>>>
>>>>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>>>> Cc: Pawel Moll <pawel.moll@arm.com>
>>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>>>>>> Cc: Kumar Gala <galak@codeaurora.org>
>>>>>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>>>>>> Cc: Lee Jones <lee.jones@linaro.org>
>>>>>> ---
>>>>>> Changes from v7:
>>>>>>  - Move non-shared resources into child nodes.
>>>>>> New for v7.
>>>>>> ---
>>>>>>  .../bindings/mfd/nvidia,tegra124-xusb.txt          | 37 ++++++++++++++++++++++
>>>>>>  1 file changed, 37 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..bc50110
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
>>>>>> @@ -0,0 +1,37 @@
>>>>>> +NVIDIA Tegra XUSB host copmlex
>>>>>> +==============================
>>>>>> +
>>>>>> +The XUSB host complex on Tegra124 and later SoCs contains an xHCI host
>>>>>> +controller and a mailbox for communication with the XUSB micro-controller.
>>>>>> +
>>>>>> +Required properties:
>>>>>> +--------------------
>>>>>> + - compatible: For Tegra124, must contain "nvidia,tegra124-xusb".
>>>>>> +   Otherwise, must contain '"nvidia,<chip>-xusb", "nvidia,tegra124-xusb"'
>>>>>> +   where <chip> is tegra132.
>>>>>> + - reg: Must contain the base and length of the XUSB FPCI registers.
>>>>>> + - ranges: Bus address mapping for the XUSB block.  Can be empty since the
>>>>>> +   mapping is 1:1.
>>>>>> + - #address-cells: Must be 2.
>>>>>> + - #size-cells: Must be 2.
>>>>>> +
>>>>>> +Example:
>>>>>> +--------
>>>>>> +     usb at 0,70098000 {
>>>>>> +             compatible = "nvidia,tegra124-xusb";
>>>>>> +             reg = <0x0 0x70098000 0x0 0x1000>;
>>>>>> +             ranges;
>>>>>> +
>>>>>> +             #address-cells = <2>;
>>>>>> +             #size-cells = <2>;
>>>>>> +
>>>>>> +             usb-host at 0,70090000 {
>>>>>> +                     compatible = "nvidia,tegra124-xhci";
>>>>>> +                     ...
>>>>>> +             };
>>>>>> +
>>>>>> +             mailbox {
>>>>>> +                     compatible = "nvidia,tegra124-xusb-mbox";
>>>>>> +                     ...
>>>>>> +             };
>>>>>
>>>>> This doesn't appear to be a proper MFD.  I would have the USB and
>>>>> Mailbox devices probe seperately and use a phandle to point the USB
>>>>> device to its Mailbox.
>>>>>
>>>>> usb at xyz {
>>>>>         mboxes = <&xusb-mailbox, [chan]>;
>>>>> };
>>>>
>>>> Then what will set up the shared regmap?  The point of using an MFD
>>>> here was to share a register set with both the mailbox and xHCI
>>>> drivers and avoid having to map the same register set twice in two
>>>> separate drivers.
>>>
>>> Can you share the mapping please?
>>
>> What do you mean?  That's what the MFD is doing now by setting up an
>> MMIO regmap to be shared between the two devices.
> 
> I mean, can you share the documentation with me. :)

You can download the documentation from here [1]. See chapter 19 USB
complex. However, I will warn you that unfortunately, you need to sign
up for an account :-(

Cheers
Jon

[1] https://developer.nvidia.com/tegra-k1-technical-reference-manual
