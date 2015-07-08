From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 08 Jul 2015 15:01:02 +0100
Subject: [PATCH v3 3/3] dt-binding:Documents the mbigen bindings
In-Reply-To: <20150708134019.GE7025@leverpostej>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
 <1436166548-34920-4-git-send-email-majun258@huawei.com>
 <20150708134019.GE7025@leverpostej>
Message-ID: <559D2D1E.1020107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/15 14:40, Mark Rutland wrote:
> On Mon, Jul 06, 2015 at 08:09:08AM +0100, Ma Jun wrote:
>> Add the mbigen msi interrupt controller bindings document
>>
>> Change in v3:
>> ---Change the compatible string
>> ---Change the interrupt cells definition.
>>
>> Signed-off-by: Ma Jun <majun258@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/arm/mbigen.txt |   65 ++++++++++++++++++++++
>>  1 files changed, 65 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/mbigen.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mbigen.txt b/Documentation/devicetree/bindings/arm/mbigen.txt
>> new file mode 100644
>> index 0000000..cf92ef8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/mbigen.txt
>> @@ -0,0 +1,65 @@
>> +Hisilicon mbigen device tree bindings.
>> +=======================================
>> +
>> +Mbigen means: message based interrupt generator.
>> +
>> +MBI is kind of msi interrupt only used on Non-PCI devices.
>> +
>> +To reduce the wired interrupt number connected to GIC,
>> +Hisilicon designed mbigen to collect and generate interrupt.
>> +
>> +
>> +Non-pci devices can connect to mbigen and gnerate the inteerrupt
>> +by wirtting ITS register.
> 
> Please run this through a spell checker to get rid of typos.
> 
>> +
>> +The mbigen and devices connect to mbigen have the following properties:
>> +
>> +
>> +Mbigen required properties:
>> +-------------------------------------------
>> +-compatible: Should be "hisilicon,mbigen-v2"
>> +-msi-parent: should specified the ITS mbigen connected
>> +-interrupt controller: Identifies the node as an interrupt controller
>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>> +  interrupt source. The value is 5 now.
>> +
>> +  The 1st cell is the device id.
> 
> Does a given mbigen block generate interrupts with different ITS device
> IDs? Or does a given mbigen block have a single device ID shared by all
> interrupts it generates?
> 
>> +  The 2nd cell is the totall interrupt number of this device?
> 
> I don't follow. What is a "total interrupt number"?
> 
>> +  The 3rd cell is the hardware pin number of the interrupt.
>> +  This value depends on the Soc design.
> 
> This property seems sane.
> 
>> +  The 4th cell is the mbigen node number. This value should refer to the
>> +  vendor soc specification.
> 
> What is this, and why do you think you need it?
> 
> Surely the address of the mbigen node is a sufficient unique identifier?
> 
>> +  The 5th cell is the interrupt trigger type, encoded as follows:
>> +		1 = edge triggered
>> +		4 = level triggered
> 
> Hmm. How are level-triggered interrupts expected to be handled by the
> mbigen?
> 
>> +
>> +- reg: Specifies the base physical address and size of the ITS
>> +  registers.
> 
> NAK. You should not describe ITS properties here given this is not the
> ITS.
> 
> Perhaps you mean "the mbigen registers"?

Also, as we all seems to be looking at different aspects of the same
problem, it would make sense to follow (and hopefully contribute) to the
topology discussion that is taking place on this thread:

http://iommu.linux-foundation.narkive.com/GZ4NREWm/master-aware-devices-and-sideband-id-data

I'd definitely expect the MBIGEN subsystem to express the DeviceID it
presents to the ITS using a common format - the ITS code itself should
be able to parse it in isolation and still do the right thing.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
