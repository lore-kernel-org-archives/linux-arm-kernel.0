From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Jan 2017 12:13:27 +0000
Subject: arm64: virt_to_page() does not return right page for a kernel
 image address
In-Reply-To: <CAHB_GuqqXqVu4i4eCZ3V_d8JbdSO6rjWpA_B0NMJsNc_Zw0Niw@mail.gmail.com>
References: <CAHB_GuqqXqVu4i4eCZ3V_d8JbdSO6rjWpA_B0NMJsNc_Zw0Niw@mail.gmail.com>
Message-ID: <20170104121326.GA28876@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 11:19:38AM +0530, Pratyush Anand wrote:
> I noticed that on arm64 kmap_atomic() does not return correct address
> corresponding to a page located in data section. It causes crash in
> kdump kernel with v29 kdump patches. crash happens in a newly
> implemented crypto test [1], and the same test fails(even though it
> does not crash) in 1st kernel as well.
> 
> Further debugging showed that the physical address returned by
> virt_to_phys(kaddr)  and virt_to_phys(kmap_atomic(virt_to_page(kaddr))
> + offset_in_page(kaddr)) are not same.
> 
> Mark Rutland thinks(IRC :#armlinux) that _virt_to_pgoff *only* handles
> linear addresses, and not kernel image addresses. However, we have to
> ask if it should?

It looks like we have a different behaviour for virt_to_page() depending
on whether CONFIG_SPARSEMEM_VMEMMAP is defined.

We've had some discussions about a month ago on whether we should allow
virt_to_phys() on kernel addresses and requiring that __pa_symbol() is
used instead but I forgot on what the decision was (if any). It seems
that we have other cases as well that need to be addressed, in which
case it may be better to simply allow virt_to_page/phys on kernel
symbols.

-- 
Catalin
