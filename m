From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 18 Aug 2014 10:42:46 -0700
Subject: [PATCH v9 4/4] arm: ARMv7 dirty page logging 2nd stage page fault
 handling support
In-Reply-To: <20140818125105.GE19635@cbox>
References: <1406249768-25315-1-git-send-email-m.smarduch@samsung.com>
 <1406249768-25315-5-git-send-email-m.smarduch@samsung.com>
 <20140811191315.GI10550@cbox> <53E96CF1.6040806@samsung.com>
 <20140812095045.GN10550@cbox> <53EABEEF.9070907@samsung.com>
 <20140813073008.GP10550@cbox> <53EC0ED3.8070307@samsung.com>
 <20140818125105.GE19635@cbox>
Message-ID: <53F23B16.5000101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2014 05:51 AM, Christoffer Dall wrote:
> On Wed, Aug 13, 2014 at 06:20:19PM -0700, Mario Smarduch wrote:
>> On 08/13/2014 12:30 AM, Christoffer Dall wrote:
>>> On Tue, Aug 12, 2014 at 06:27:11PM -0700, Mario Smarduch wrote:
>>>> On 08/12/2014 02:50 AM, Christoffer Dall wrote:
>>>>> On Mon, Aug 11, 2014 at 06:25:05PM -0700, Mario Smarduch wrote:
>>>>>> On 08/11/2014 12:13 PM, Christoffer Dall wrote:
>>>>>>> On Thu, Jul 24, 2014 at 05:56:08PM -0700, Mario Smarduch wrote:
>>>
>>> [...]
>>>
>>>>>>>> @@ -1151,7 +1170,7 @@ static void kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, void *data)

>>
>> Ok I see, I was thinking you thought it was breaking something.
>> Yeah I'll add the comment, in reality this is another use case
>> where a PMD may need to be converted to page table so it makes sense
>> to contrast use cases.
>>
> 
> the hidden knowledge is that MMU notifiers will ensure a huge PMD gets
> unmapped before trying to change the physical backing of the underlying
> PTEs, so it's a gigantic kernel bug if this gets called on something
> mapped with a huge PMD.
> 

That's a good way of putting it luckily I was aware previously looking
at some other features.

> 
>>>
>>>>
>>>> Should I add comments on flag use in other places as well?
>>>>
>>>
>>> It's always a judgement call.  I didn't find it necessarry to put a
>>> comment elsewhere because I think it's pretty obivous that we would
>>> never care about logging writes to device regions.
>>>
>>> However, this made me think, are we making sure that we are not marking
>>> device mappings as read-only in the wp_range functions?  I think it's
>>
>> KVM_SET_USER_MEMORY_REGION ioctl doesn't check type of region being
>> installed/operated on (KVM_MEM_LOG_DIRTY_PAGES), in case of QEMU
>> these regions wind up in KVMState->KVMSlot[], when
>> memory_region_add_subregion() is called KVM listener installs it.
>> For migration and dirty page logging QEMU walks the KVMSlot[] array.
>>
>> For QEMU VFIO (PCI) mmap()ing BAR of type IORESOURCE_MEM,
>> causes the memory region to be added to KVMState->KVMSlot[].
>> In that case it's possible to walk KVMState->KVMSlot[] issue
>> the ioctl and  come across  a device mapping with normal memory and
>> WP it's s2ptes (VFIO sets unmigrateble state though).
>>
>> But I'm not sure what's there to stop someone calling the ioctl and
>> install a region with device memory type. Most likely though if you
>> installed that kind of region migration would be disabled.
>>
>> But just for logging use not checking memory type could be an issue.
>>
> I forgot that the current write-protect'ing is limited to the memory
> region boundaries, so everything should be fine.

I looked through this way back, but it was worth to revisit.
> 
> If user-space write-protects device memory regions, the worst
> consequence is that it breaks the guest, but that's its own
> responsibility, so I don't think you need to change anything.

Thanks for the detailed review. I'll go off now, rebase and make
the needed changes

> 
> -Christoffer
> 
