From: ahs3@redhat.com (Al Stone)
Date: Wed, 12 Jul 2017 17:28:24 -0600
Subject: APM smmu implementation
In-Reply-To: <CAL85gmCM-=iTbK3mcsFOtJrxbYFE99FWn7Aj9w-JLhMu03wWqQ@mail.gmail.com>
References: <CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g@mail.gmail.com>
 <d9e40de8-82e2-0f19-5b99-d756ded21e80@arm.com>
 <20170109120300.GC21398@arm.com>
 <9d083b5e-0fe4-b649-c4f4-e1005feb9ec1@arm.com>
 <CAL85gmCM-=iTbK3mcsFOtJrxbYFE99FWn7Aj9w-JLhMu03wWqQ@mail.gmail.com>
Message-ID: <f8cefa15-9d1b-ae92-b673-3010875ac16b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2017 03:07 PM, Feng Kan wrote:
> On Mon, Jan 9, 2017 at 9:55 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 09/01/17 12:03, Will Deacon wrote:
>>> On Mon, Jan 09, 2017 at 11:34:42AM +0000, Robin Murphy wrote:
>>>> On 06/01/17 23:21, Feng Kan wrote:
>>>>> The APM IOMMU implementation is mostly just the ARM SMMU 500 variant.
>>>>
>>>> "Mostly"? Have APM actually modified it (which I strongly doubt) or do
>>>> you mean it's simply been integrated with the upper address lines tied
>>>> off? MMU-500 reports a 48-bit IAS because MMU-500 has 48-bit-wide slave
>>>> interfaces; that's all there is to it. Whether or not you use all of
>>>> those bits is up to you as a system integrator.
>>>
>>> That's a good point; MMU-500 doesn't appear to let you change the IAS
>>> anyway. That should also mean that UBS and OAS are unchanged.
>>>
>>>>> However, our internal bus is only 42 bits wide. Our IAS field is coded
>>>>> as 48 bits, which cause IPA to truncated to 42 bits on the physical
>>>>> bus. In order for our system to work with the arm-smmu.c, there needs
>>>>> to be a way to force the ipa_size to 42. The current internal solution
>>>>> is to use the cpuid, but that is quite ugly. I was thinking of using
>>>>> the model
>>>>> as indication to right the ipa_size, but I am not too sure of the ACPI
>>>>> side. Would it be okay to add an APM MMU500 variant? I would also
>>>>> appreciated it if you guys have any alternate solutions.
>>>>
>>>> This is something we've been axpecting to run into for a while now - the
>>>> appropriate solution is to use a "dma-ranges" property on the master
>>>> device(s) to describe that they have 42 bits of address wired up, from
>>>> which they will then inherit the appropriate DMA mask. The outstanding
>>>> issue which remains is that we're still missing some way of preventing
>>>> drivers simply clobbering that with a 64-bit mask later, but that's a
>>>> more general problem[1].
>>>
>>> I wonder if the driver is actually using IAS, OAS and UBS incorrectly.
>>> We're using them to parameterise the DMA aperture, which is then used
>>> to size the IOVA domain, but that's wrong because the IAS, OAS and UBS
>>> are upper bounds and we can still end up allocating unusable/unreachable
>>> addresses.
>>
>> It's not incorrect, it's simply all we know at that point. From inside
>> the SMMU, we can't tell how many of the bits we have are actually wired
>> up externally, which is why we always take the intersection of the DMA
>> aperture and the given device's DMA mask at the point of IOVA allocation.
>>
>> You can reproduce much the same thing on your Juno if you fancy - just
>> make the HDLCD or PL330 driver set a DMA mask larger than the default 32
>> bits and the top 8 bits of the MMU-401's 40-bit input being tied off to
>> 0 will become apparent (the only difference being there's not actually
>> anything at the master end they could be wired to either).
>>
>>> So I do think that this should be fixed on the SMMU firmware node, rather
>>> than restricting the range of each master device.
>>
>> In general, it's a per-master thing which "dma-ranges" is exactly the
>> correct tool to describe - a property on the SMMU would just be a weird
>> nonstandard shorthand for a very particular case (it breaks as soon as
>> you have some *more* limited, e.g. 32-bit, device in the same system).
>> The fact that every master in this case apparently has the same
>> capability is just happenstance.
> I know this thread is pretty old, so sorry about that. Given that
> using dma-range is
> not an option in our system since it uses ACPI tables. There doesn't seem to be
> any more activity on this. I see that the IORT table has added support
> for CAVIUM_SMMUV2,
> would it be possible to add APM_SMMUV2 and key the ipa_size to less or equal
> to 42 bits. This way, we can fix the problem in the SMMUv2 driver and not worry
> about the greater DMA layer changes that could affect everyone.

Adding Charles to the To: list -- he's the one you'll need to contact
about modifying IORT content since he controls the document.  I would
guess it's possible to add an entry for APM but I don't get to decide
that, Charles does.  Contacting him directly would be your best bet,
though.

>>
>> Robin.
>>
>>>
>>> Will
>>>
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
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
