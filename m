From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 19 Oct 2018 09:07:36 +0100
Subject: [PATCH 0/7] Ensure stack is aligned for kernel entries
In-Reply-To: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
Message-ID: <e01f2e58-3e78-9f6c-16b4-0b8d92a64a09@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gentle ping on this series.

On 26/09/18 14:56, Julien Thierry wrote:
> Hi,
> 
> Having SCTLR_ELx.SA enabled requires the SP to be 16-bytes aligned before
> using it to access memory. When taking an exception, it is possible that
> the context during which the exception occured had SP mis-aligned. The
> entry code needs to make sure that the stack is aligned before using it to
> save the context.
> 
> This is only a concern when taking exception from an EL using the same
> SP_ELx as the handler. In other cases it can be assumed that the SP being
> picked up on exception entry is aligned under the condition that SP is
> always aligned when doing eret to an EL using a different SP.
> 
> On Juno I see a runtime difference <1% for hackbench. If I do not include
> the fast path at EL1 (patch 4) I see a diff of 1-2%.
> 
> For EL2 entries, a bit of clean up of stuff getting patched in the vector
> has been needed.
> 
> Cheers,
> 
> Julien
> 
> -->
> 
> Julien Thierry (7):
>    arm64: Add static check for pt_regs alignment
>    arm64: sdei: Always use sdei stack for sdei events
>    arm64: Align stack when taking exception from EL1
>    arm64: Add fast-path for stack alignment
>    arm64: Do not apply BP hardening for hyp entries from EL2
>    arm64: Do not apply vector harderning for hyp entries from EL2
>    arm64: kvm: Align stack for exception coming from EL2
> 
>   arch/arm64/include/asm/assembler.h |  9 +++++
>   arch/arm64/include/asm/ptrace.h    |  2 +
>   arch/arm64/include/asm/sdei.h      |  2 -
>   arch/arm64/kernel/cpu_errata.c     | 10 ++++-
>   arch/arm64/kernel/entry.S          | 43 +++++++++++++++++++--
>   arch/arm64/kernel/sdei.c           | 23 ++++-------
>   arch/arm64/kvm/hyp/hyp-entry.S     | 78 +++++++++++++++++++++++++++++++-------
>   drivers/firmware/Kconfig           |  1 +
>   8 files changed, 132 insertions(+), 36 deletions(-)
> 
> --
> 1.9.1
> 

-- 
Julien Thierry
