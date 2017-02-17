From: james.morse@arm.com (James Morse)
Date: Fri, 17 Feb 2017 16:08:44 +0000
Subject: [PATCH v32 06/13] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170207080904.5974-4-takahiro.akashi@linaro.org>
References: <20170207080601.5816-1-takahiro.akashi@linaro.org>
 <20170207080904.5974-4-takahiro.akashi@linaro.org>
Message-ID: <58A7200C.8010707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 07/02/17 08:08, AKASHI Takahiro wrote:
> arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
> are meant to be called by kexec_load() in order to protect the memory
> allocated for crash dump kernel once it's loaded.
> 
> Here, the protection is implemented by unmapping the relevant range
> of memory, rather than making it read-only, to prevent any corruption
> due to potential cache alias (with different attributes) problem.
> 
> To make the things work correctly, we have to
> - use page-level mappings entirely
> - have the mappings isolated from the other normal memory
> - move copying kexec's control_code_page to machine_kexec_prepare()
> 
> Note that page-level mappings are required to allow shrinking the region,
> through /sys/kernel/kexec_crash_size, to the size of any number of pages
> and putting the freed memory back to buddy system.

This shrinking means memory marked memblock:reserve gets used by the slab
allocator. This makes me feel uneasy, but I agree its not going to break
anything, and we can't easily un-reserve it.

The temporary no-map when building the linear map is a neat trick!

Reviewed-by: James Morse <james.morse@arm.com>


This patch will conflict with Ard's 'arm64: mmu: avoid writeable-executable
mappings' series[0], but they may be complimentary as he adds a
update_mapping_prot() call in patch 2 [1] which has a similar use-case.


Thanks,

James

[0] https://www.spinics.net/lists/arm-kernel/msg562724.html
[1] https://www.spinics.net/lists/arm-kernel/msg562726.html
