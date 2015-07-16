From: majun258@huawei.com (majun (F))
Date: Thu, 16 Jul 2015 16:35:39 +0800
Subject: [PATCH v3 3/3] dt-binding:Documents the mbigen bindings
In-Reply-To: <20150708134019.GE7025@leverpostej>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
 <1436166548-34920-4-git-send-email-majun258@huawei.com>
 <20150708134019.GE7025@leverpostej>
Message-ID: <55A76CDB.1020905@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015/7/8 21:40, Mark Rutland ??:
> On Mon, Jul 06, 2015 at 08:09:08AM +0100, Ma Jun wrote:
[...]
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
sorry, it's my mistake
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
The mbigen chip structrue likes below:

			mbigen_chip(domain)
	|------------|------------------|
mbigen_node0	mbigen_node1		mbigen_node2
|	|	|	|		|	|
dev1	dev2	dev3	dev4		dev5	dev6

For each mbigen chip, it contains several mbigen nodes.
For each mbigen node, it can collect interrupts from different devices.

For example, dev1 and dev2 both connect to mbigen node0.Because dev1 and dev2 are
differnt device, they have different device id.

The device id is encoded in mbigen chip and can not be changed.

>> +  The 2nd cell is the totall interrupt number of this device?
> 
> I don't follow. What is a "total interrupt number"?
> 
It's the wired interrupt number connected to a device.
For the devices connected to mbigen node, the interrupt number  varied from
1 to 100+ .So I have to specifies this value in dts.


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
		mbigen_chip(domain)
	|------------|------------------|
mbigen_node0	mbigen_node1		mbigen_node2
|	|	|	|		|	|
dev1	dev2	dev3	dev4		dev5	dev6

To avoid the duplicat hardware irq number problem, the Mbigen node number is defined here.
For example:
dev1 has 3 interrupts with pin number from 0 to 2
dev3 has 5 interrupts with pin number from 0 to 4
For dev3 the interrupt from 0 to 2 would be has same hardware irq number
as dev1 if we only use pin number.

Because these two devices located in same irq domain(mbigen chip),using same
hwirq number is a mistake.

In mbigen driver, I will use this value and  the 3rd cell(pin number) to compose
a new hardware irq( (nid<<8) | pin number) for mbigen using.

>> +  The 5th cell is the interrupt trigger type, encoded as follows:
>> +		1 = edge triggered
>> +		4 = level triggered
> 
> Hmm. How are level-triggered interrupts expected to be handled by the
> mbigen?
> 
For each interrupt, there is state machine in mbigen chip.
inactive-->pending--> active(pending & active)

The level triggered interrupt process flow list as below:
device---->mbigen---->ITS---->GIC--->CPU

[1]: device triggered interrupt A and line level changes to high
[2]: Mbigen receive interrupt A and changes the status of A to pending in mbigen(mbigen.state = pending)
[3]: Mbigen send interrupt A to ITS , the A status in mbigen will be changed to pending
	& active (mbigen.state = pending & active)
[4]: ITS receive the interrupt A and send A to gic (A status in gic is pending. gic.state=pending)
[5]: CPU ack the interrupt A ( gic.state = active)
[6]: Enter interrupt handler. The interrupt line level is cleared in device irq handler.
[7]: When detects the low level on interrupt A line, mbigen change the interrupt A status
	from pending & active to inactive (mbigen.state = inactive).
[8]: Send EOI . a): write register to clear the status in mbigen .
	b):clear the status in gic. (gic.state = inactive)
>> +
>> +- reg: Specifies the base physical address and size of the ITS
>> +  registers.
> 
> NAK. You should not describe ITS properties here given this is not the
> ITS.
> 
> Perhaps you mean "the mbigen registers"?
> 
yes, it should be 'mbigen'
