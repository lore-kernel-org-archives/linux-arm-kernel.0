From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Jan 2017 10:57:58 +0000
Subject: arm64: virt_to_page() does not return right page for a kernel
 image address
In-Reply-To: <322d61f1-0b72-6125-f5cd-153e0baad733@redhat.com>
References: <CAHB_GuqqXqVu4i4eCZ3V_d8JbdSO6rjWpA_B0NMJsNc_Zw0Niw@mail.gmail.com>
 <20170104121326.GA28876@e104818-lin.cambridge.arm.com>
 <322d61f1-0b72-6125-f5cd-153e0baad733@redhat.com>
Message-ID: <20170105105757.GA29765@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 10:39:05AM -0800, Laura Abbott wrote:
> On 01/04/2017 04:13 AM, Catalin Marinas wrote:
> > On Wed, Jan 04, 2017 at 11:19:38AM +0530, Pratyush Anand wrote:
> >> I noticed that on arm64 kmap_atomic() does not return correct address
> >> corresponding to a page located in data section. It causes crash in
> >> kdump kernel with v29 kdump patches. crash happens in a newly
> >> implemented crypto test [1], and the same test fails(even though it
> >> does not crash) in 1st kernel as well.
> >>
> >> Further debugging showed that the physical address returned by
> >> virt_to_phys(kaddr)  and virt_to_phys(kmap_atomic(virt_to_page(kaddr))
> >> + offset_in_page(kaddr)) are not same.
> 
> I think the underlying issue has been resolved but in general, relying
> on virt_to_phys(kmap_atomic(page)) to work at all doesn't seem
> correct. On arm64 and other !CONFIG_HIGHMEM systems this currently
> returns the page_address but if it's actually remapped this isn't
> going to work.

Good point, kmap_atomic() does not always return an address in the
linear map, so virt_to_phys() on such address is not generally expected
to work (unrelated to arm64).

-- 
Catalin
