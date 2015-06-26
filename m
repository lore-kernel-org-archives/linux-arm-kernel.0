From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 26 Jun 2015 09:45:01 +0100
Subject: [PATCH v2 2/3] IRQ/Gic-V3: Change arm-gic-its to support the
 Mbigen interrupt
In-Reply-To: <alpine.DEB.2.11.1506231125580.4037@nanos>
References: <1434077399-32200-1-git-send-email-majun258@huawei.com>
 <1434077399-32200-3-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1506121230320.3786@nanos> <557E794D.2080705@huawei.com>
 <alpine.DEB.2.11.1506190150000.4107@nanos> <558920FF.8030405@huawei.com>
 <alpine.DEB.2.11.1506231125580.4037@nanos>
Message-ID: <558D110D.7050000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/06/15 10:29, Thomas Gleixner wrote:
> On Tue, 23 Jun 2015, majun (F) wrote:
>> ? 2015/6/19 7:52, Thomas Gleixner ??:
>>> On Mon, 15 Jun 2015, majun (F) wrote:
>>>> ? 2015/6/12 18:48, Thomas Gleixner ??:
>>>>> Can you please provide a proper description of this mbigen chip and
>>>>> explain WHY you think that it needs all this special hackery?
>>>
>>> You carefully avoided to provide a proper description of this mbigen
>>> chip and how it needs to be integrated into the GIC/ITS whatever
>>> scenario.
>>>
>> Mbigen means Message Based Interrupt Generator.
>> Its a kind of interrupt controller collects
>> the interrupts from external devices and generate msi interrupt.
>>
>> Mbigen is applied to reduce the number of wire connected interrupts.
>>
>> As the peripherals increasing, the interrupts lines needed is increasing
>> much, especially on the Arm64 server soc.
>>
>> Therefore, the interrupt pin in gic is not enought for so many perpherals.
>>
>> Mbigen is designed to fix this problem.
>>
>> Mbigen chip locates in ITS or outside of ITS.
>>
>> The working flow of Mbigen shows as below:
>>
>> external devices ------> MBIGEN ------->ITS
>>
>> The devices connect to Mbigen chip through wire connecting way.
>> Mbigen detects and collectes the interrupts from the these devices.
>>
>> Then, Mbigen generats the MBI interrupts by writting the ITS
>> Translator register.
> 
> So it's nothing else than a non PCI based MSI implementation which
> means it can simply use the generic MSI infrastructure and implement a
> interrupt domain/chip which implements the MBI specific parts and has
> the ITS as its parent domain.
> 
> No hackery in ITS and no extra functionality in the core irq code. It
> just can use the existing infrastructure. The only extra you need is a
> proper way to retrieve the pointer to the ITS domain. Everything else
> just falls in place.

I may have a proposal for that. Stay tuned.

	M.
-- 
Jazz is not dead. It just smells funny...
