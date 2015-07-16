From: majun258@huawei.com (majun (F))
Date: Thu, 16 Jul 2015 20:26:33 +0800
Subject: [PATCH v3 1/3] IRQ/Gic-V3: Add mbigen driver to support mbigen
 interrupt controller
In-Reply-To: <55A77999.9000203@arm.com>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
 <1436166548-34920-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1507061248090.3916@nanos> <559CA530.2090508@huawei.com>
 <559D3EB5.4060408@arm.com> <55A76CBE.2030508@huawei.com>
 <55A770E2.2040300@arm.com> <55A777BD.4080504@huawei.com>
 <55A77999.9000203@arm.com>
Message-ID: <55A7A2F9.3000306@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015/7/16 17:30, Marc Zyngier ??:
> On 16/07/15 10:22, majun (F) wrote:
>>
>>
>> ? 2015/7/16 16:52, Marc Zyngier ??:
>>> On 16/07/15 09:35, majun (F) wrote:
>>
>>>>> I'm a bit puzzled.
>>>>
>>>> For interrupts connect to mbigen , the interrupt trigger type, device id and
>>>> event id value are encoded in mbigen chip already.
>>>>
>>>> There are two types of mbigen node within a mbigen chip.
>>>> Type1: event id valud can't be programmed.
>>>> Type2: event id value can be programmed.
>>>>
>>>> For example: An device with 5 interrupts connected to Mbigen node
>>>> type 1.The default event id vlaue encoded in mbigen chip for these 5 interrupt
>>>> is from 0 to 4.
>>>>
>>>> Because the event id value can't be programmed, we need to define all of
>>>> 5 interrupts in dts file so that these 5 interrupt has
>>>
>>> You can define what you want in the device tree, the ITS doesn't care!
>>> Nothing in the ITS code parses this property, and there is absolutely
>>> zero chance that the even the ITS has allocated will actually match what
>>> you expect.
>>>
>>> The ITS *relies* on the principle that the evenID can be programmed,
>>> just like any MSI controller relies on the device to be programmed with
>>> whatever payload has been provided. If all of a sudden we have to
>>> support HW that has its own view of the payload, what you have here will
>>> simply not work.
>>>
>> "If all of a sudden we have to
>>  support HW that has its own view of the payload, what you have here will
>>  simply not work."
>>
>> I am not very unstand this case, would you please explain this more detail?
> 
> It is the ITS driver that allocates the eventID, not the device. If your
> hardware has decided that it will use event 5, while the ITS expect it
> to use event 3, nothing will work. And there is no way for the ITS to
> know which event your device is using (it doesn't parse your device's
> device tree).
> 
Yes, I agree with you that eventID should be allocated by ITS driver.
But I want to explain the case you said above can be avoided.

For example, An device with total 5 interrupts connected to Mbigen node.
In mbigen chip, the default eventID value for each device starts from 0.
So, for these 5 interrupts the default eventID value is from 0 to 4.

Because the default eventID is fixed in mbigen chip, to make these 5 interrupt
work, the only way is define all these 5 interrupts in dts file.

When irq initializing, ITS driver will allocat LPI interrupt number for these
5 interrupts, for example : from 8192 to 8196. and the eventID value is from 0 to 4.
Now, the allocated eventID value same as the eventID value encoded in mbigen chip,
The interrupt can work.

I know this is not a good method,but for current mbigen chip,it's the only solution.
