From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Nov 2017 16:19:35 -0800
Subject: [PATCH 00/18] arm64: Unmap the kernel whilst running in
 userspace (KAISER)
In-Reply-To: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
Message-ID: <20171118001935.GB18379@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17, Will Deacon wrote:
> Hi all,
> 
> This patch series implements something along the lines of KAISER for arm64:
> 
>   https://gruss.cc/files/kaiser.pdf
> 
> although I wrote this from scratch because the paper has some funny
> assumptions about how the architecture works. There is a patch series
> in review for x86, which follows a similar approach:
> 
>   http://lkml.kernel.org/r/<20171110193058.BECA7D88@viggo.jf.intel.com>
> 
> and the topic was recently covered by LWN (currently subscriber-only):
> 
>   https://lwn.net/Articles/738975/
> 
> The basic idea is that transitions to and from userspace are proxied
> through a trampoline page which is mapped into a separate page table and
> can switch the full kernel mapping in and out on exception entry and
> exit respectively. This is a valuable defence against various KASLR and
> timing attacks, particularly as the trampoline page is at a fixed virtual
> address and therefore the kernel text can be randomized independently.
> 
> The major consequences of the trampoline are:
> 
>   * We can no longer make use of global mappings for kernel space, so
>     each task is assigned two ASIDs: one for user mappings and one for
>     kernel mappings
> 
>   * Our ASID moves into TTBR1 so that we can quickly switch between the
>     trampoline and kernel page tables
> 
>   * Switching TTBR0 always requires use of the zero page, so we can
>     dispense with some of our errata workaround code.
> 
>   * entry.S gets more complicated to read
> 
> The performance hit from this series isn't as bad as I feared: things
> like cyclictest and kernbench seem to be largely unaffected, although
> syscall micro-benchmarks appear to show that syscall overhead is roughly
> doubled, and this has an impact on things like hackbench which exhibits
> a ~10% hit due to its heavy context-switching.

Do you have performance benchmark numbers on CPUs with the Falkor
errata? I'm interested to see how much the TLB invalidate hurts
heavy context-switching workloads on these CPUs.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
