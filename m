From: ddaney.cavm@gmail.com (David Daney)
Date: Fri, 22 Apr 2016 09:00:28 -0700
Subject: [PATCH V6 08/13] PCI: generic, thunder: update to use generic
 ECAM API
In-Reply-To: <571A3587.2020704@redhat.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <3830999.dF71UWYsBP@wuerfel> <57189D2F.9070802@semihalf.com>
 <8950494.UV8UrWiFbx@wuerfel> <5718A6AE.4080203@semihalf.com>
 <571A3587.2020704@redhat.com>
Message-ID: <571A4A9C.7000201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2016 07:30 AM, Jon Masters wrote:
> On 04/21/2016 06:08 AM, Tomasz Nowicki wrote:
>> On 21.04.2016 11:36, Arnd Bergmann wrote:
>>> On Thursday 21 April 2016 11:28:15 Tomasz Nowicki wrote:
>>>> On 19.04.2016 15:06, Arnd Bergmann wrote:
>>>>> On Monday 18 April 2016 21:31:54 Tomasz Nowicki wrote:
>>>>>>
>>>>>> Basically the whole content of pci-thunder-ecam.c and
>>>>>> pci-thunder-pem.c.
>>>>>>
>>>>>> pci-thunder-ecam.c contains config space accessors. Similar for
>>>>>> pci-thunder-pem.c but it also has extra init call (it is now called
>>>>>> thunder_pem_init) which finds and maps related registers.
>>>>>
>>>>> They seem to do much more than just override the accessors, they
>>>>> actually
>>>>> change the contents of the config space as well. Is that really
>>>>> necessary
>>>>> on ACPI based systems as well?
>>>>
>>>> Yes, the pci-thunder-ecam.c accessors are meant to emulate config space
>>>> capabilities. They are necessary to synthesize EA capabilities (fixed
>>>> PCI BARs), it wont work without this, for ACPI boot as well.
>>>
>>> Why is that? I thought the BARs never get reassigned when using ACPI,
>>> so I'm surprised it's actually needed. Maybe I misunderstood what
>>> you mean by fixed PCI BARs.
>>
>> Yes, I meant something else. ThunderX has non-programmable PCI BAR
>> addresses. So it uses PCI EA (Extended allocation) capabilities to get
>> know PCI BARs addresses. But the early implementation (pass1.x) misses
>> EA capabilities hence we need to emulate it in config space accessors.
>
> Aside: In case it's helpful, at least one enterprise vendor I know of is
> only supporting later silicon as a result of this. So IMO there's no
> need to worry about this issue on the early preproduction chips.
>

There are two separate issues that make fixing up the ECAM space necessary:

1) As Jon mentioned, preproduction silicon lacks EA capabilities.

2) On 2-node NUMA systems, the EA capabilities of some devices may be 
incorrect even in production silicon.

In general, the strategy we use for dealing with both of these is to 
hook into the ECAM access methods, and supply corrected config space 
data.  For the case of device-tree provisioned ECAM access, the fix ups 
are done in pci-thunder-ecam.c.  This code is already present and seems 
to be working well.

As we consider ACPI support, supporting case #2 above will be desirable. 
  If we reuse the code in pci-thunder-ecam.c for this, we will probably 
get support for #1 for free.

David Daney
