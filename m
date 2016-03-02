From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 2 Mar 2016 07:13:10 -0500
Subject: [PATCH 0/2] Tracking user space vDSO remaping
In-Reply-To: <cover.1426866405.git.ldufour@linux.vnet.ibm.com>
References: <cover.1426866405.git.ldufour@linux.vnet.ibm.com>
Message-ID: <56D6D8D6.6060306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/20/2015 11:53 AM, Laurent Dufour wrote:
> CRIU is recreating the process memory layout by remapping the checkpointee
> memory area on top of the current process (criu). This includes remapping
> the vDSO to the place it has at checkpoint time.
> 
> However some architectures like powerpc are keeping a reference to the vDSO
> base address to build the signal return stack frame by calling the vDSO
> sigreturn service. So once the vDSO has been moved, this reference is no
> more valid and the signal frame built later are not usable.
> 
> This patch serie is introducing a new mm hook 'arch_remap' which is called
> when mremap is done and the mm lock still hold. The next patch is adding the
> vDSO remap and unmap tracking to the powerpc architecture.
> 
> Laurent Dufour (2):
>   mm: Introducing arch_remap hook
>   powerpc/mm: Tracking vDSO remap
> 
>  arch/powerpc/include/asm/mmu_context.h   | 35 +++++++++++++++++++++++++++++++-
>  arch/s390/include/asm/mmu_context.h      |  6 ++++++
>  arch/um/include/asm/mmu_context.h        |  5 +++++
>  arch/unicore32/include/asm/mmu_context.h |  6 ++++++
>  arch/x86/include/asm/mmu_context.h       |  6 ++++++
>  include/asm-generic/mm_hooks.h           |  6 ++++++
>  mm/mremap.c                              |  9 ++++++--
>  7 files changed, 70 insertions(+), 3 deletions(-)

We would like to be able to remap/unmap the VDSO on arm and arm64 as
well. When I proposed a patch with mmu_context.h and mmu-arch-hooks.h
changes to arm64 that were nearly identical to those done to powerpc,
Will Deacon reasonably suggested [1] attempting to combine the code and
provide generic VDSO accessors. Unfortunately, I no prior experience
with generic MM code. Can anyone advise on how to get started with that?

1. http://www.spinics.net/lists/linux-arm-msm/msg18441.html

Thanks,
Christopher Covington

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
