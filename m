From: james.morse@arm.com (James Morse)
Date: Tue, 16 Feb 2016 10:50:47 +0000
Subject: [PATCH] arm64: mark kernel text segment as MEMBLOCK_NOMAP
In-Reply-To: <1455528512-32491-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455528512-32491-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <56C2FF07.30205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 15/02/16 09:28, Ard Biesheuvel wrote:
> Commit 752af28bd711 ("arm64: move kernel image to base of vmalloc area")
> moves the mapping of the kernel text and data segments out of the linear
> region, and takes care not to create a writable alias of the read-only
> kernel text segment by checking each memblock against overlap when the
> memblocks are mapped into the linear mapping.
> 
> However, it is more correct, and much simpler, to mark the [_stext, _etext]
> interval as MEMBLOCK_NOMAP. This will also prevent the interval from being
> omitted from the linear region, but this fact will now also be reflected
> in the output of pfn_valid(), and so code that expects any pfn_valid()
> page to be mapped and accessible (which is a reasonable assumption) does
> not get surprised by the text segment being inaccessible via the linear
> mapping.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---

With this patch on arm64/for-next/kernmap, I get the following KVM-related boot
failure on Juno:
-----------------------------%<-----------------------------
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counters available
------------[ cut here ]------------
kernel BUG at ../arch/arm64/kvm/../../../arch/arm/kvm/mmu.c:577!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
Modules linked in:
CPU: 4 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc1+ #2022
Hardware name: ARM Juno development board (r1) (DT)
task: ffffffc976cf8000 ti: ffffffc976d60000 task.ti: ffffffc976d60000
PC is at create_hyp_mappings+0x144/0x148
LR is@create_hyp_mappings+0x7c/0x148

[SNIP]

[<ffffff80040abc14>] create_hyp_mappings+0x144/0x148
[<ffffff80040a9be8>] kvm_arch_init+0x198/0x53c
[<ffffff800409fe24>] kvm_init+0x38/0x290
[<ffffff80040a84e4>] arm_init+0x24/0x2c
[<ffffff8004082994>] do_one_initcall+0x94/0x198
[<ffffff8004a22b10>] kernel_init_freeable+0x148/0x1e8
[<ffffff800473e344>] kernel_init+0x20/0xe4
[<ffffff8004085cd0>] ret_from_fork+0x10/0x40

-----------------------------%<-----------------------------

The offending function is:
-----------------------------%<-----------------------------
static phys_addr_t kvm_kaddr_to_phys(void *kaddr)
{
	if (!is_vmalloc_addr(kaddr)) {
		BUG_ON(!virt_addr_valid(kaddr));
		return __pa(kaddr);
	} else {
		return page_to_phys(vmalloc_to_page(kaddr)) +
		       offset_in_page(kaddr);
	}
}
-----------------------------%<-----------------------------

When the BUG_ON() fires, kaddr points into the hole in the linear map left by
the kernel text.


> This should hopefully address the issue reported by James, but I suppose
> more work is required on the hibernate side to ensure the unmapped text
> region is preserved, since it is no longer covered by the linear mapping.

It does, now I have to work out how best to fix hibernate!


Thanks,

James
