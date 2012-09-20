From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Sep 2012 11:01:59 +0100
Subject: [PATCH 01/15] ARM: add mem_type prot_pte accessor
In-Reply-To: <CANM98qL-CZT23T+MNg=EA_ieY+TJF6=F_6XpixWmfEqPN4-A7g@mail.gmail.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153436.21241.95691.stgit@ubuntu>
 <20120918210442.GA12245@n2100.arm.linux.org.uk>
 <CANM98qL-CZT23T+MNg=EA_ieY+TJF6=F_6XpixWmfEqPN4-A7g@mail.gmail.com>
Message-ID: <505AE997.5030303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/09/12 22:53, Christoffer Dall wrote:
> On Tue, Sep 18, 2012 at 5:04 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Sat, Sep 15, 2012 at 11:34:36AM -0400, Christoffer Dall wrote:
>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>
>>> The KVM hypervisor mmu code requires access to the mem_type prot_pte
>>> field when setting up page tables pointing to a device. Unfortunately,
>>> the mem_type structure is opaque.
>>>
>>> Add an accessor (get_mem_type_prot_pte()) to retrieve the prot_pte
>>> value.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>>
>> Is there a reason why we need this to be exposed, along with all the
>> page table manipulation in patch 7?
>>
>> Is there a reason why we can't have new MT_ types for PAGE_HYP and
>> the HYP MT_DEVICE type (which is the same as MT_DEVICE but with
>> PTE_USER set) and have the standard ARM/generic kernel code build
>> those mappings?
> 
> For hyp mode we can do this, but we cannot do this for the cpu
> interfaces that need to be mapped into each VM as they have each their
> own pgd. 

Isn't that the same problem? The HYP mode has its own pgd too. I think
this is the main issue with the generic code. If we can come up with an
interface that allows the generic code to work on alternative pgds, we
could pretty much do what Russell suggests here.

	M.
-- 
Jazz is not dead. It just smells funny...
