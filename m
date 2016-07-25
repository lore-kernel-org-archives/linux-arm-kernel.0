From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 25 Jul 2016 14:36:35 +0100
Subject: [RFC 3/6] dt/bindings: Add bindings for Tegra20/30 NOR bus driver
In-Reply-To: <20160725115923.GF21170@ulmo.ba.sec>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-4-git-send-email-mirza.krak@gmail.com>
 <434561ec-510e-a3bf-c7b6-c961db299bd6@nvidia.com>
 <20160725115923.GF21170@ulmo.ba.sec>
Message-ID: <2b8c0fb7-b3c7-35bb-a237-2397fefbb725@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 25/07/16 12:59, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Thu, Jul 21, 2016 at 10:56:44AM +0100, Jon Hunter wrote:
>>
>> On 19/07/16 14:36, Mirza Krak wrote:
>>> From: Mirza Krak <mirza.krak@gmail.com>
>>>
>>> Document the devicetree bindings for NOR bus driver found on Tegra20 and
>>> Tegra30 SOCs
>>>
>>> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
>>> ---
>>>  .../devicetree/bindings/bus/nvidia,tegra20-nor.txt | 73 ++++++++++++++++++++++
>>>  1 file changed, 73 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt b/Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt
>>> new file mode 100644
>>> index 0000000..9ee4a66
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt
>>> @@ -0,0 +1,73 @@
>>> +Device tree bindings for NVIDIA Tegra20/30 NOR Bus
>>> +
>>> +The NOR controller supports a number of memory types, including synchronous NOR,
>>> +asynchronous NOR, and other flash memories with similar interfaces, such as
>>> +MuxOneNAND. One could also connect high speed devices like FPGAs, DSPs,
>>> +CAN chips, Wi-Fi chips etc.
>>
>> Nit-pick ... the Tegra documentation refers to this controller as the
>> GMI (general memory interface) or SNOR (sync-NOR) controller because it
>> is not just limited to NOR as you mentioned. I see references to GMI in
>> the Tegra pinctrl driver and so may be we should use this name.
>>
>>> +
>>> +The actual devices are instantiated from the child nodes of a NOR node.
>>> +
>>> +Required properties:
>>> +
>>> + - compatible: should be "nvidia,tegra20-nor", "nvidia,tegra30-nor"
>>
>> I see at least one difference at the register level between Tegra20 and
>> Tegra30 and so I think this should be something like ...
>>
>>  - compatible : Should contain one of the following:
>> 	For Tegra20 must contain "nvidia,tegra20-gmi".
>>  	For Tegra30 must contain "nvidia,tegra30-gmi".
>>
>>> + - reg: Should contain NOR controller registers location and length.
>>> + - clocks: Must contain one entry, for the module clock.
>>> +   See ../clocks/clock-bindings.txt for details.
>>> + - resets : Must contain an entry for each entry in reset-names.
>>> +   See ../reset/reset.txt for details.
>>> + - reset-names : Must include the following entries:
>>> +  - nor
>>> + - #address-cells: Must be set to 2 to allow memory address translation
>>> + - #size-cells:	Must be set to 1 to allow CS address passing
>>> + - ranges: Must be set up to reflect the memory layout with four integer
>>> + 		values for each chip-select line in use.
>>> + - nvidia,config: This property represents the SNOR_CONFIG_0 register.
>>
>> There is also a SNOR_MIO_CONFIG for the MIO address space and so I think
>> that this should be nvidia,snor-config to be explicit. It might be nice
>> to also add a "nvidia,mio-config" while you are at it as well, however,
>> that could always be done later. If you do, then the
>> "nvidia,snor-config" becomes optional depending on whether you are using
>> the SNOR or MIO address space.
>>
>> Thierry, Stephen, do prefer all the fields on the config registers are
>> broken out? There are quite a few but I am not sure what we typically
>> recommend here?
> 
> As I said elsewhere, I prefer breaking the fields out into separate
> properties because that makes it a lot easier to write the DT. Rather
> than having to go and manually assemble 32-bit values for this register
> and the timing registers, it must be a lot easier to look at datasheets
> and copy the values into the corresponding DT properties.

That's what I thought :-)

>>> +Note that the NOR controller does not have any internal chip-select address
>>> +decoding and if you want to access multiple devices external chip-select
>>> +decoding must be provided.
>>
>> Although it is true, you do have the MIO address space and so you could
>> support two devices via the SNOR address space and MIO address space
>> (assuming that the MIO can be used for the 2nd device).
> 
> Now I'm even more confused. If the GMI controller itself can't select a
> chip, what is the SNOR_SEL field in the SNOR_CONFIG_0 register for? Does
> that not select a specific chip?

So the GMI has 8 chip-selects and these can be used by either the SNOR
interface for MIO interface. As you mentioned the chip-select used for
the SNOR interface is configured by the field SNOR_SEL in the
SNOR_CONFIG and similarly the chip-select for the MIO interface is
configured by the MIO_SEL field in the MIO_CONFIG register.

Looking at the Tegra20 TRM, the SNOR interface is mapped to the address
range 0xd0000000-0xdfffffff and the MIO interface is mapped to the
address range 0xe0000000-0xefffffff. If chip-select 0 is used for SNOR
and chip-select 1 is used for MIO, you can support two devices at the
same time and they will be accessible via different address ranges.
Whether you can use the MIO interface for the 2nd device is another
question.

If you want to support two 256MB NOR devices on the SNOR interface, then
you would need to reconfigure the SNOR_CONFIG each time you swap between
the two devices.

>> Furthermore, if you do have external logic to support multiple devices
>> this would assume that the devices use the same timing and so are
>> probably the same type. It also assumes both can fit in the 256MB
>> address range. May be worth mentioning.
> 
> Similarly if you switch between different devices, wouldn't you have to
> reprogram the timing registers if they are different?

Yes.

> The way I remember this kind of interface to work (it's been a long time
> since I used one) is that in order to operate on a chip you need to
> acquire the bus first. Typically that would be an API exposed by the bus
> driver or some framework that the bus driver registers with. That API
> arbitrates between multiple devices on the bus and makes sure that the
> proper chip select is asserted and timing is programmed when you're
> granted access. A driver that has acquired the bus can then perform what
> operations they need and release the bus when done.
> 
> SPI uses a mechanism like this, for example.

That would make sense. However, I am not sure how that would work with
the client drivers, such as the CAN driver Mirza is using, that wishes
to read/write directly to the SNOR address space. I am guessing that SPI
works like I2C and buffers up the requests and performs them in sequence.

Jon

-- 
nvpublic
