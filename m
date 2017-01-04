From: panand@redhat.com (Pratyush Anand)
Date: Wed, 4 Jan 2017 11:19:38 +0530
Subject: arm64: virt_to_page() does not return right page for a kernel image
 address
Message-ID: <CAHB_GuqqXqVu4i4eCZ3V_d8JbdSO6rjWpA_B0NMJsNc_Zw0Niw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I noticed that on arm64 kmap_atomic() does not return correct address
corresponding to a page located in data section. It causes crash in
kdump kernel with v29 kdump patches. crash happens in a newly
implemented crypto test [1], and the same test fails(even though it
does not crash) in 1st kernel as well.

Further debugging showed that the physical address returned by
virt_to_phys(kaddr)  and virt_to_phys(kmap_atomic(virt_to_page(kaddr))
+ offset_in_page(kaddr)) are not same.

Mark Rutland thinks(IRC :#armlinux) that _virt_to_pgoff *only* handles
linear addresses, and not kernel image addresses. However, we have to
ask if it should?

Meanwhile, I reverted commit [2] and then everything worked fine
*atleast* in my case. But, I am not sure if that could be the right
and best solution.

Opinion?

~Pratyush

[1]
commit d7db7a882debaffc78f91aabedee973aa1f73390
Author: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Date:   Fri Oct 21 13:19:54 2016 +0100

    crypto: acomp - update testmgr with support for acomp

[2]commit 9f2875912dac35d9272a82ea9eec9e5884b42cd2
Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed Mar 30 16:46:01 2016 +0200

    arm64: mm: restrict virt_to_page() to the linear mapping
