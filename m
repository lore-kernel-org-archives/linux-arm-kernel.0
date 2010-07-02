From: ra7055@freescale.com (Rob Herring)
Date: Fri, 02 Jul 2010 10:06:04 -0500
Subject: [PATCH] [ARM] Introduce patching of phys_to_virt and vice versa
In-Reply-To: <1277542025-19881-1-git-send-email-eric.miao@canonical.com>
References: <1277542025-19881-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1278083164.15298.55.camel@ra7055-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric,

On Sat, 2010-06-26 at 16:47 +0800, eric.miao at canonical.com wrote:
> From: Eric Miao <eric.miao@canonical.com>
> 
> In most cases, the delta between PHYS_OFFSET and PAGE_OFFSET is normally
> 16MiB aligned, which means the difference can be handled by a simple ADD
> or SUB instruction with an immediate shift operand in ARM.  This will be
> a bit more efficient and generic when PHYS_OFFSET goes run-time.
> 
> This idea can be made generic to allow conversions more than phys_to_virt
> and virt_to_phys. A stub instruction is inserted where applicable, and it
> has a form of 'add rn, rd, #imm', where the lowest 8-bit of #imm is used
> to identify the type of patching.  Currently, only two types are defined,
> but could be expanded in my POV to definitions like __io(), __mem_pci()
> and so on. A __patch_table section is introduced to include the addresses
> of all these stub instructions.
> 
> There are several places for improvement:
> 
> 1. constant parameters which can be optimized by the compiler now needs
>    one additional instruction (although the optimization is neither
>    possible when PHYS_OFFSET goes a variable)
> 
> 2. flush_cache_all() when patching is done seems to be brute but simple
>    enough here in this patch to show a proof concept
> 
> Any thing else?
> 
> PS: the general idea comes from Nicolas Pitre, and is drafted at
>     https://wiki.ubuntu.com/Specs/ARMSingleKernel
> 

Should something more generic like the x86 alternative code be done for
ARM? It's very likely we will need patching in other places like for UP
and SMP in one kernel. 

Rob
