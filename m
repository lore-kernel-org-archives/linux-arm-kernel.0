From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Tue, 18 Sep 2012 17:53:02 -0400
Subject: [PATCH 01/15] ARM: add mem_type prot_pte accessor
In-Reply-To: <20120918210442.GA12245@n2100.arm.linux.org.uk>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153436.21241.95691.stgit@ubuntu>
 <20120918210442.GA12245@n2100.arm.linux.org.uk>
Message-ID: <CANM98qL-CZT23T+MNg=EA_ieY+TJF6=F_6XpixWmfEqPN4-A7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 5:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Sep 15, 2012 at 11:34:36AM -0400, Christoffer Dall wrote:
>> From: Marc Zyngier <marc.zyngier@arm.com>
>>
>> The KVM hypervisor mmu code requires access to the mem_type prot_pte
>> field when setting up page tables pointing to a device. Unfortunately,
>> the mem_type structure is opaque.
>>
>> Add an accessor (get_mem_type_prot_pte()) to retrieve the prot_pte
>> value.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>
> Is there a reason why we need this to be exposed, along with all the
> page table manipulation in patch 7?
>
> Is there a reason why we can't have new MT_ types for PAGE_HYP and
> the HYP MT_DEVICE type (which is the same as MT_DEVICE but with
> PTE_USER set) and have the standard ARM/generic kernel code build
> those mappings?

For hyp mode we can do this, but we cannot do this for the cpu
interfaces that need to be mapped into each VM as they have each their
own pgd. We can move the Hyp mode mappings, and I was playing with the
though of having a PAGE_KVM_DEVICE set in pgtable.h and a
pgprot_guest_device setup in build_mem_type_table.

What do you think?

>
> That would (it seems) also avoid the need to export the pXd_clear_bad()
> acessors too...

for hyp mode mappings this would be true, then.
