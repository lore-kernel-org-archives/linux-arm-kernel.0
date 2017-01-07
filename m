From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 7 Jan 2017 14:26:47 -0500
Subject: [PATCH 07/22] dt-bindings: power: supply: add AXP20X/AXP22X AC
 power supply
In-Reply-To: <CAGb2v67V6oGEyYGsBWfp3rVVm_VWQta0szeBiNSKUQR7awm5ng@mail.gmail.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-8-quentin.schulz@free-electrons.com>
 <20170104131410.mni7opxnouzagypu@rob-hp-laptop>
 <CAGb2v67V6oGEyYGsBWfp3rVVm_VWQta0szeBiNSKUQR7awm5ng@mail.gmail.com>
Message-ID: <eb5972af-93c1-0818-7640-58f32e97629b@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/17 01:17, Chen-Yu Tsai wrote:
> Hi Quentin,
> 
> On Wed, Jan 4, 2017 at 9:14 PM, Rob Herring <robh@kernel.org> wrote:
>> On Mon, Jan 02, 2017 at 05:37:07PM +0100, Quentin Schulz wrote:
>>> The X-Powers AXP20X and AXP22X PMICs have an AC entry to supply power to
>>> the board. They have a few registers dedicated to the status of the AC
>>> power supply.
>>>
>>> This adds the DT binding documentation for the AC power supply for
>>> AXP20X and AXP22X PMICs.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>> ---
>>>  .../bindings/power/supply/axp20x_ac_power.txt      | 28 ++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
>>> new file mode 100644
>>> index 0000000..16d0de4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
>>> @@ -0,0 +1,28 @@
>>> +AXP20X and AXP22X PMICs' AC power supply
>>> +
>>> +Required Properties:
>>> + - compatible: One of:
>>> +                     "x-powers,axp202-ac-power-supply"
>>> +                     "x-powers,axp221-ac-power-supply"
>>> +
>>> +More Required Properties for AXP20X PMICs:
>>> + - io-channels: phandles to ACIN voltage and current ADC channels
>>> + - io-channel-names = "acin_v", "acin_i";
>>> +
>>> +This node is a subnode of the axp20x PMIC.
>>> +
>>> +The AXP20X can read the current current and voltage supplied by AC by
>>> +reading ADC channels from the AXP20X ADC.
>>> +
>>> +The AXP22X is only able to tell if an AC power supply is present and
>>> +usable.
>>> +
>>> +Example:
>>> +
>>> +&axp209 {
>>> +     ac_power_supply: ac_power_supply {
>>
>> power-supply {
>>
>>> +             compatible = "x-powers,axp202-ac-power-supply";
>>> +             io-channels = <&axp209_adc 0>, <&axp209_adc 1>;
>>
>> Is this assignment fixed? If so, then it doesn't need to be in DT.
> 
> Is there any case that we actually need to use the IIO channels
> from the device tree? Seems to me its limited to the other AXP
> sub-devices.
> 
> If so you could use struct iio_map to map the channels to other
> devices by name. See axp288_adc for an example.
Agreed. When we are within a device (so it's not flexible) that
is the way to go.
> 
> Regards
> ChenYu
> 
>>> +             io-channel-names = "acin_v", "acin_i";
>>> +     };
>>> +};
>>> --
>>> 2.9.3
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
