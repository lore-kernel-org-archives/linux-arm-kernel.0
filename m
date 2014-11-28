From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 28 Nov 2014 15:40:12 +0000
Subject: [PATCH v4 17/19] arm64: KVM: add SGI generation register emulation
In-Reply-To: <20141125110339.GD31297@cbox>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-18-git-send-email-andre.przywara@arm.com>
 <20141123150852.GD3401@cbox> <54735EE6.70904@arm.com>
 <20141125110339.GD31297@cbox>
Message-ID: <5478975C.5070107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hej Christoffer,

On 25/11/14 11:03, Christoffer Dall wrote:
> Hi Andre,
> 
> On Mon, Nov 24, 2014 at 04:37:58PM +0000, Andre Przywara wrote:
>> Hi,
>>
>> On 23/11/14 15:08, Christoffer Dall wrote:
>>> On Fri, Nov 14, 2014 at 10:08:01AM +0000, Andre Przywara wrote:
>>>> While the generation of a (virtual) inter-processor interrupt (SGI)
>>>> on a GICv2 works by writing to a MMIO register, GICv3 uses the system
>>>> register ICC_SGI1R_EL1 to trigger them.
>>>> Trap that register on ARM64 hosts and handle it in a new handler
>>>> function in the GICv3 emulation code.
>>>
>>> Did you reorder something or does my previous comment still apply that
>>> you're not enabling trapping yet, you're just adding the handler - those
>>> are two different things.
>>
>> Yes, I can fix the wording.
>>
>>> You sort of left my question about access_gic_sgi() not checking if the
>>> gicv3 is presetn hanging from the last thread, but I think I'm
>>> understanding properly now, that as long as you're not setting the
>>> ICC_SRE_EL2.Enable = 1, then we'll never get here, right?
>>
>> Right, that is the idea. Just to make sure that I got this right from
>> the discussion the other day: We will not trap to EL2 as long as
>> ICC_SRE_EL2.Enable is 0 - which it should still be at this point, right?
> 
> No, when ICC_SRE_EL2.Enable is 0, then Non-secure EL1 access to
> ICC_SRE_EL1 trap to EL2 (See Section 5.7.39 in the spec), which means
> that accesses to the ICC_SGIx registers will cause an undefined
> exception in the guest because we set ICC_SRE_EL1.SRE to 0 for the
> guest and the guest cannot change this.
> 
> Now, when we set ICC_SRE_EL2.Enable to 1, then the guest can set
> ICC_SRE_EL1.SRE to 1 (and we also happen to reset it to 1), and we will
> indeed trap on guest access to the ICC_SGIx registers, because all
> virtual accesses to these registers trap.
> 
> (Going back and checking where 'virtual accesses' is defined in the spec
> left me somewhere without any results, but I am guessing that because we
> set the ICH_HCR_EL2.En to 1, all accesses will be deemed virtual
> accesses, maybe the spec should be clarfied on this matter?).
> 
> Anyhow, to get back to my original question, getting here requires
> a situation where the guest copy of the ICC_SRE_EL1.SRE is 1, which we
> only allow when we have properly initialized the GICv3 data structures.

So to summarize (and check) this: There is no real issue at this point?
And the code is totally fine after 19/19?

Would this kind of problem actually matter _inside_ a patch series? To
trigger an issue, we would need a bogus guest and bogus userland
(because at this point neither of them would see/inject a GICv3 FDT
node). I'd assume that running a kernel at this point is just for
debugging/bisecting? Where you wouldn't care about every corner case of
execution?

Please tell me if I should give my email reading a seventh pass ;-)

Regards,
Andre.

>> (I am asking because I struggle to find this in the spec).
>>
>> So actually your ICC_SRE_EL1 trap patch solved that problem ;-)
>>
> 
> So I think this is a different thing, not related that closely to my
> question above.
> 
> That patch was about when ICC_SRE_EL2.Enable is 0, then we would trap
> guest accesses to ICC_SRE_EL1 which did not have any sysreg handler
> installed, and ended up with an undefined exception in the guest instead
> of handling the trap as RAZ/WI.
> 
