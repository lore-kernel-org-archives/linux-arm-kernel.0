From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 13 Nov 2014 11:45:35 +0000
Subject: [PATCH v3 16/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation / PART 2
In-Reply-To: <20141113111808.GN19598@cbox>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-17-git-send-email-andre.przywara@arm.com>
 <20141107143040.GR16132@cbox> <546354E9.3000108@arm.com>
 <20141113111808.GN19598@cbox>
Message-ID: <546499DF.50208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/14 11:18, Christoffer Dall wrote:
> On Wed, Nov 12, 2014 at 12:39:05PM +0000, Andre Przywara wrote:
>> Hej Christoffer,
>>
>> the promised part 2 of the reply:
>>
>> On 07/11/14 14:30, Christoffer Dall wrote:
>>> On Fri, Oct 31, 2014 at 05:26:51PM +0000, Andre Przywara wrote:
>>>> With everything separated and prepared, we implement a model of a
>>>> GICv3 distributor and redistributors by using the existing framework
>>>> to provide handler functions for each register group.
>>
>> [...]
>>
>>>> +
>>>> +static const struct mmio_range vgic_dist_ranges[] = {
>>
>> [...]
>>
>>>> +     /* the next three blocks are RES0 if ARE=1 */
>>>
>>> probably nicer to just have a comment for each register where this
>>> applies.
>>
>> Done.
>>
>>>
>>>> +     {
>>>> +             .base           = GICD_SGIR,
>>>> +             .len            = 4,
>>>> +             .handle_mmio    = handle_mmio_raz_wi,
>>>> +     },
>>>> +     {
>>>> +             .base           = GICD_CPENDSGIR,
>>>> +             .len            = 0x10,
>>>> +             .handle_mmio    = handle_mmio_raz_wi,
>>>> +     },
>>>> +     {
>>>> +             .base           = GICD_SPENDSGIR,
>>>> +             .len            = 0x10,
>>>> +             .handle_mmio    = handle_mmio_raz_wi,
>>>> +     },
>>>> +     {
>>>> +             .base           = GICD_IROUTER,
>>>> +             .len            = 0x2000,
>>>
>>> shouldn't this be 0x1ee0?
>>
>> The limit of 0x7FD8 in the spec seems to come from 1020 - 32 SPIs.
>> However all the other registers always claim 1024 IRQs supported (with
>> non-implemented SPIs being RAZ/WI anyway).
>> So I wonder if this is just a inconsistency in the spec.
>> Marc, can you comment?
> 
> The spec's memory map clearly indicates that the space at 0x6100 +
> 0x1edc an onwards is reserverd, so it feels weird to define IROUTER
> registers here.
> 
> Indeed you guys should check what the true intention is.

Indeed, the spec is very clear about the range 0x7fdc-0xbffc to be
reserved. Andre, can you please update this?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
