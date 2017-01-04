From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Jan 2017 11:11:19 +0000
Subject: arm64: virt_to_page() does not return right page for a kernel
 image address
In-Reply-To: <CAHB_GuqqXqVu4i4eCZ3V_d8JbdSO6rjWpA_B0NMJsNc_Zw0Niw@mail.gmail.com>
References: <CAHB_GuqqXqVu4i4eCZ3V_d8JbdSO6rjWpA_B0NMJsNc_Zw0Niw@mail.gmail.com>
Message-ID: <20170104111119.GD8329@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 11:19:38AM +0530, Pratyush Anand wrote:
> Hi,

Hi,

> I noticed that on arm64 kmap_atomic() does not return correct address
> corresponding to a page located in data section. It causes crash in
> kdump kernel with v29 kdump patches. crash happens in a newly
> implemented crypto test [1], and the same test fails(even though it
> does not crash) in 1st kernel as well.
> 
> Further debugging showed that the physical address returned by
> virt_to_phys(kaddr)  and virt_to_phys(kmap_atomic(virt_to_page(kaddr))
> + offset_in_page(kaddr)) are not same.

As I mentioned over IRC, virt_to_phys() on a kmap*() result is wrong
anyway. A kmap() results is not guaranteed to be a linear map address,
even if that's the trivial implementation used today.
 
> Mark Rutland thinks(IRC :#armlinux) that _virt_to_pgoff *only* handles
> linear addresses, and not kernel image addresses. However, we have to
> ask if it should?

>From Ard's commit, the intention is clearly that it should not,
especially given the update to virt_addr_valid(). With Larua's
DEBUG_VIRTUAL updates, we can use lm_alias() to get a linear map address
before using virt_to_page().

Other than the (new) crypto test and the (not yet upstream) kdump
patches, does any code rely on virt_to_page() working for a kernel image
address? If so, and if we cannot fix those in the short term, we may
want to temporarily revert commit 9f2875912dac35d9 until those are fixed
up.

Regardless, I think that the kdump code should not rely on
virt_to_page() for a kernel image (or kmap) result.

Thanks,
Mark.

> Meanwhile, I reverted commit [2] and then everything worked fine
> *atleast* in my case. But, I am not sure if that could be the right
> and best solution.
> 
> Opinion?
> 
> ~Pratyush
> 
> [1]
> commit d7db7a882debaffc78f91aabedee973aa1f73390
> Author: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Date:   Fri Oct 21 13:19:54 2016 +0100
> 
>     crypto: acomp - update testmgr with support for acomp
> 
> [2]commit 9f2875912dac35d9272a82ea9eec9e5884b42cd2
> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Date:   Wed Mar 30 16:46:01 2016 +0200
> 
>     arm64: mm: restrict virt_to_page() to the linear mapping
