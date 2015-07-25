From: majun258@huawei.com (majun (F))
Date: Sat, 25 Jul 2015 11:03:16 +0800
Subject: [PATCH v3 3/3] dt-binding:Documents the mbigen bindings
In-Reply-To: <20150720163825.GF19239@leverpostej>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
 <1436166548-34920-4-git-send-email-majun258@huawei.com>
 <20150708134019.GE7025@leverpostej> <55A76CDB.1020905@huawei.com>
 <20150720163825.GF19239@leverpostej>
Message-ID: <55B2FC74.6080201@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark:

? 2015/7/21 0:38, Mark Rutland ??:
>>>> +The mbigen and devices connect to mbigen have the following properties:
>> The mbigen chip structrue likes below:
>>
>> 			mbigen_chip(domain)
>> 	|------------|------------------|
>> mbigen_node0	mbigen_node1		mbigen_node2
>> |	|	|	|		|	|
>> dev1	dev2	dev3	dev4		dev5	dev6
>>
>> For each mbigen chip, it contains several mbigen nodes.
>> For each mbigen node, it can collect interrupts from different devices.
>>
>> For example, dev1 and dev2 both connect to mbigen node0.Because dev1 and dev2 are
>> differnt device, they have different device id.
>>
>> The device id is encoded in mbigen chip and can not be changed.
> 
> Thanks for the diagram, that clears up some of my confusion regarding
> nodes.
> 
> Ok, so each device has it's own device ID. That's good. If a device has
> multiple interrupt lines to the mbigen, do these always share the same
> device ID?
> 
yes, for the interrupt lines within a device, they always share the same
device ID.
>>>> +  The 2nd cell is the totall interrupt number of this device?
>>>
>>> I don't follow. What is a "total interrupt number"?
>>>
>> It's the wired interrupt number connected to a device.
>> For the devices connected to mbigen node, the interrupt number  varied from
>> 1 to 100+ .So I have to specifies this value in dts.
>>
>>>> +  The 3rd cell is the hardware pin number of the interrupt.
>>>> +  This value depends on the Soc design.
>>>
>>> This property seems sane.
>>>
>>>> +  The 4th cell is the mbigen node number. This value should refer to the
>>>> +  vendor soc specification.
>>>
>>> What is this, and why do you think you need it?
>>>
>>> Surely the address of the mbigen node is a sufficient unique identifier?
>>>
>> 		mbigen_chip(domain)
>> 	|------------|------------------|
>> mbigen_node0	mbigen_node1		mbigen_node2
>> |	|	|	|		|	|
>> dev1	dev2	dev3	dev4		dev5	dev6
>>
>> To avoid the duplicat hardware irq number problem, the Mbigen node number is defined here.
>> For example:
>> dev1 has 3 interrupts with pin number from 0 to 2
>> dev3 has 5 interrupts with pin number from 0 to 4
>> For dev3 the interrupt from 0 to 2 would be has same hardware irq number
>> as dev1 if we only use pin number.
>>
>> Because these two devices located in same irq domain(mbigen chip),using same
>> hwirq number is a mistake.
>>
>> In mbigen driver, I will use this value and  the 3rd cell(pin number) to compose
>> a new hardware irq( (nid<<8) | pin number) for mbigen using.
> 
> Ok. I now see why you need node and pin.
> 
> However, I don't see why you also need the 'total' interrupt number. Why
> isn't node and pin sufficient to uniquely identify an interrupt?
> 
The ITS driver alloc a ITT table for each device.
The table size depends on interrupt number of the device.
So I need to specify the total interrupt number .



> Thanks,
> Mark.
> 
> .
> 
