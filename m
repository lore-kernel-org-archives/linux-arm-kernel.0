From: labbott@redhat.com (Laura Abbott)
Date: Wed, 4 Jan 2017 10:39:05 -0800
Subject: arm64: virt_to_page() does not return right page for a kernel
 image address
In-Reply-To: <20170104121326.GA28876@e104818-lin.cambridge.arm.com>
References: <CAHB_GuqqXqVu4i4eCZ3V_d8JbdSO6rjWpA_B0NMJsNc_Zw0Niw@mail.gmail.com>
 <20170104121326.GA28876@e104818-lin.cambridge.arm.com>
Message-ID: <322d61f1-0b72-6125-f5cd-153e0baad733@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2017 04:13 AM, Catalin Marinas wrote:
> On Wed, Jan 04, 2017 at 11:19:38AM +0530, Pratyush Anand wrote:
>> I noticed that on arm64 kmap_atomic() does not return correct address
>> corresponding to a page located in data section. It causes crash in
>> kdump kernel with v29 kdump patches. crash happens in a newly
>> implemented crypto test [1], and the same test fails(even though it
>> does not crash) in 1st kernel as well.
>>
>> Further debugging showed that the physical address returned by
>> virt_to_phys(kaddr)  and virt_to_phys(kmap_atomic(virt_to_page(kaddr))
>> + offset_in_page(kaddr)) are not same.
>>

I think the underlying issue has been resolved but in general, relying
on virt_to_phys(kmap_atomic(page)) to work at all doesn't seem
correct. On arm64 and other !CONFIG_HIGHMEM systems this currently
returns the page_address but if it's actually remapped this isn't
going to work.

>> Mark Rutland thinks(IRC :#armlinux) that _virt_to_pgoff *only* handles
>> linear addresses, and not kernel image addresses. However, we have to
>> ask if it should?
> 
> It looks like we have a different behaviour for virt_to_page() depending
> on whether CONFIG_SPARSEMEM_VMEMMAP is defined.
> 

Yes, and I think the !CONFIG_SPARSEMEM_VMEMMAP is doing the correct
thing.

> We've had some discussions about a month ago on whether we should allow
> virt_to_phys() on kernel addresses and requiring that __pa_symbol() is
> used instead but I forgot on what the decision was (if any). It seems
> that we have other cases as well that need to be addressed, in which
> case it may be better to simply allow virt_to_page/phys on kernel
> symbols.
> 

So far we've been able to enforce virt_to_phys to be used only on
linear addresses and require __pa_symbol be used on kernel image symbols.
This may change once CONFIG_DEBUG_VIRTUAL gets more testing though.

This really needs to be documented somewhere though. I've added this
to my TODO list along with generally documenting some of the
virt<->phys<->page since none of that is well specified anywhere.

Thanks,
Laura
