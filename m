From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 06 Nov 2014 11:14:41 +0100
Subject: [PATCH v12 2/6] KVM: Add generic support for dirty page logging
In-Reply-To: <545AAD3B.6070602@samsung.com>
References: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
 <1414017251-5772-3-git-send-email-m.smarduch@samsung.com>
 <20141101101208.GE12801@jhogan-linux.le.imgtec.org>
 <545A4BCE.40504@redhat.com> <545AAD3B.6070602@samsung.com>
Message-ID: <545B4A11.5080807@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/11/2014 00:05, Mario Smarduch wrote:
> On 11/05/2014 08:09 AM, Paolo Bonzini wrote:
>>
>>
>> On 01/11/2014 11:12, James Hogan wrote:
>>> AFAICT all of the arch implementations of kvm_vm_ioctl_get_dirty_log()
>>> except x86 and ppc hv (i.e. ia60, mips, ppc pv, s390) already make use
>>> of the existing generic function kvm_get_dirty_log() to help implement
>>> their kvm_vm_ioctl_get_dirty_log functions, which all look pretty
>>> similar now except for TLB flushing.
>>>
>>> Would they not be a better base for a generic
>>> kvm_vm_ioctl_get_dirty_log()?
>>>
>>> It feels a bit wrong to add a generic higher level function which
>>> doesn't make use of the existing generic lower level abstraction.
>>>
>>> (Appologies if this has already been brought up in previous versions of
>>> the patchset, I haven't been tracking them).
>>
>> I agree that we should make the interface look more like
>> kvm_get_dirty_log().  Here the steps are:
>>
>> + *   1. Take a snapshot of the bit and clear it if needed.
>> + *   2. Write protect the corresponding page.
>> + *   3. Flush TLB's if needed.
>> + *   4. Copy the snapshot to the userspace.
> 
> Hi Paolo,
>   thanks for breaking it down between generic/architecture layers,
> helps a lot. Initially I thought we could get TLB flushing to
> generic layer, previous x86 version worked for ARM. But looking
> deeper other architectures either use non-generic flush or none
> at all. Right now we would have x86, ARM, IA64 using generic TLB flush.
> I'll restructure for another version.

I'll test the swap between 3 and 4 above, and send it to the list.  Feel
free to include it in v13, so that it gets back to me via Christoffer
and Marc.

Paolo
