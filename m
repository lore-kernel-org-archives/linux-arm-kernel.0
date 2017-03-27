From: ahs3@redhat.com (Al Stone)
Date: Mon, 27 Mar 2017 12:56:19 -0600
Subject: [PATCH v9 15/15] irqchip: mbigen: Add ACPI support
In-Reply-To: <20170327152702.GB12092@red-moon>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
 <1488890410-15503-16-git-send-email-guohanjun@huawei.com>
 <20170321144521.GA4392@red-moon>
 <12635f14-8cbd-61ba-74fa-495a81f94038@huawei.com>
 <c07135ba-f14f-fa2f-bd1b-e00cc758b3e7@arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E204C0AB7@FRAEML521-MBX.china.huawei.com>
 <20170327152702.GB12092@red-moon>
Message-ID: <6ea7e293-bde4-3c22-a987-cec1843da39b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2017 09:27 AM, Lorenzo Pieralisi wrote:
> [+Al,Darren to comment on _DSD review process]
> 
> On Mon, Mar 27, 2017 at 12:24:45PM +0000, Gabriele Paoloni wrote:
>> Hi Marc Many thanks for your comments
>>
>>> -----Original Message-----
>>> From: linuxarm-bounces at huawei.com [mailto:linuxarm-bounces at huawei.com]
>>> On Behalf Of Marc Zyngier
>>> Sent: 27 March 2017 09:47
>>> To: John Garry; Lorenzo Pieralisi; Guohanjun (Hanjun Guo)
>>> Cc: Rafael J. Wysocki; Yimin (Leo); Greg KH; Linuxarm; linux-
>>> kernel at vger.kernel.org; Sinan Kaya; linux-acpi at vger.kernel.org; Hanjun
>>> Guo; Tomasz Nowicki; Thomas Gleixner; linux-arm-
>>> kernel at lists.infradead.org
>>> Subject: Re: [PATCH v9 15/15] irqchip: mbigen: Add ACPI support
>>>
>>> Hanjun, John,
>>>
>>> On 22/03/17 14:12, John Garry wrote:
>>>> On 21/03/2017 14:45, Lorenzo Pieralisi wrote:
>>>>> On Tue, Mar 07, 2017 at 08:40:10PM +0800, Hanjun Guo wrote:
>>>>>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>>>>>
>>>>>> With the preparation of platform msi support and interrupt producer
>>>>>> in DSDT, we can add mbigen ACPI support now.
>>>>>>
>>>>>> We are using Interrupt resource type in _CRS methd to indicate
>>> number
>>>>>> of irq pins instead of num_pins in DT to avoid _DSD usage in this
>>> case.
>>>>>>
>>>>>> For mbigen,
>>>>>>     Device(MBI0) {
>>>>>>           Name(_HID, "HISI0152")
>>>>>>           Name(_UID, Zero)
>>>>>>           Name(_CRS, ResourceTemplate() {
>>>>>>                   Memory32Fixed(ReadWrite, 0xa0080000, 0x10000)
>>>>>> 		  Interrupt(ResourceProducer,...) {12,14,....}
>>>>>
>>>>> What do these interrupt numbers represent ? This looks wrong to me.
>>>>> An interrupt descriptor is there to describe the interrupts a device
>>>>> can generate; you are using it just to add a "standard" (that is
>>>>> not standard at all) way of counting the number of vectors allocated
>>>>> to this specific chip and that's just wrong.
>>>>>
>>>>
>>>> As I understand, the count of interrupts we are declaring for the
>>> mbigen
>>>> is the same as the sum of interrupts for that mbigen's children.
>>>>
>>>> So at the point we probe the mbigen, can we just deference the
>>> children
>>>> to count their interrupts, and use this as the #msis?
>>>>
>>>>> Can't you use something like Agustin did in the QCOM combiner:
>>>>>
>>>>> drivers/irqchip/qcom-irq-combiner.c
>>>>>
>>>>> to detect the MSI vector length (ie by describing the MBIgen through
>>>>> generic registers and use the bit width to compute the vector
>>>>> lenght) ? I am not sure how feasible it is given that my knowledge
>>>>> of MBIgen is pretty poor.
>>>>>
>>>>> I understand we want to avoid _DSD properties but we should not
>>>>> work around standard bindings to achieve that goal.
>>>>>
>>>>
>>>> We use "num-pins" for dt solution, but it is not so welcome here.
>>>
>>> Well, this device is already completely out of any standard description
>>> on the ACPI side. And given that it bloats both the ACPI tables and the
>>> kernel data structures, I can only suggest that you take advantage of
>>> _DSD here, as misusing the standard properties is not something that we
>>> should condone. It will also make the driver more manageable, as it
>>> will
>>> use similar properties on both firmware implementations.
>>>
>>> I feel like I need to stress the urgency here. We're at -rc4, and still
>>> with unsolved issues. None of us want to miss the next merge window.
>>>
>>
>> As follow up our guys would work on a solution whose ACPI table looks
>> like the following one:
>>
>> For mbigen,
>>     Device(MBI0) {
>>           Name(_HID, "HISI0152")
>>           Name(_UID, Zero)
>>           Name(_CRS, ResourceTemplate() {
>>                   Memory32Fixed(ReadWrite, 0xa0080000, 0x10000)
>>           })
>>
>>     Name(_DSD, Package () {
>>       ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>       Package ()
>>       {
>>         Package () {"num-pins", xxx}
>>       }
>>     })
>>     }

Please fix the indentation here; the ASL parser doesn't care, but I don't
see '}'s as clearly as it does :).  In particular, _DSD usage *must* be for
a device and it does not look like that if one doesn't carefully count all
the parentheses and braces.

>>
>> For devices,
>>    Device(COM0) {
>>           Name(_HID, "ACPIIDxx")
>>           Name(_UID, Zero)
>>           Name(_CRS, ResourceTemplate() {
>>                  Memory32Fixed(ReadWrite, 0xb0030000, 0x10000)
>> 		 Interrupt(ResourceConsumer,..., "\_SB.MBI0") {12}
>>           })
>>     }
>>
>>
>> Marc, Lorenzo if you are ok with the above we will submit v10 based on this...
> 
> I am ok with it. I am not 100% up-to-date on what's the status on _DSD
> bindings/review/guidelines but it would be certainly a good idea to
> kickstart the process for MBIgen which basically means following this
> as far as I know (and post to the relevant mailing list):
> 
> https://github.com/ahs3/dsd/blob/master/documentation/process_rules.txt

So, let's correct this bit: consider that URL deprecated, please, and refer
instead to the text that was agreed upon and in the kernel tree:

	Documentation/acpi/DSD-properties-rules.txt

> Al and Darren may add to that as they have more insights.

Since this use of _DSD is very specific to this device, and this device
only, I don't have any real objections.  I will say that "num-pins" is
not terribly descriptive so it would be really good to either use a much
more descriptive name or add plenty of commentary in the code -- and
preferably both.  I would recommend including the ASL in the code comments,
with a description of how the property is to be used and what it means.

> I would like to send IORT patches to Catalin as soon as possible so
> as Marc pointed out the sooner we sort this out the better.
> 
> Thanks,
> Lorenzo
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
