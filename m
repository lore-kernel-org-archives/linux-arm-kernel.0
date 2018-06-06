From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Jun 2018 16:45:21 +0100
Subject: [PATCH v13 0/3] Fix issues with huge mapping in ioremap for ARM64
In-Reply-To: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
Message-ID: <20180606154520.GM6631@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chintan,

Thanks for sticking with this. I've reviewed the series now and I'm keen
for it to land in mainline. Just a couple of things below.

On Wed, Jun 06, 2018 at 12:31:18PM +0530, Chintan Pandya wrote:
> This series of patches re-bring huge vmap back for arm64.
> 
> Patch 1/3 has been taken by Toshi in his series of patches
> by name "[PATCH v3 0/3] fix free pmd/pte page handlings on x86"
> to avoid merge conflict with this series.
> 
> These patches are tested on 4.16 kernel with Cortex-A75 based SoC.
> 
> The test used for verifying these patches is a stress test on
> ioremap/unmap which tries to re-use same io-address but changes
> size of mapping randomly i.e. 4K to 2M to 1G etc. The same test
> used to reproduce 3rd level translation fault without these fixes
> (and also of course with Revert "arm64: Enforce BBM for huge IO/VMAP
> mappings" being part of the tree).

[...]

> These patches can also go into '-stable' branch (if accepted)
> for 4.6 onwards.

Not sure we need to target -stable, since we solved the crash by disabling
the use of huge io mappings.

>  arch/arm64/include/asm/tlbflush.h |  7 ++++++
>  arch/arm64/mm/mmu.c               | 48 +++++++++++++++++++++++++++++++++++----
>  arch/x86/mm/pgtable.c             |  8 ++++---
>  include/asm-generic/pgtable.h     |  8 +++----
>  lib/ioremap.c                     |  4 ++--

If you get an ack from the x86 folks, then I could take all of this via
arm64. Alternatively, now that I've reviewed the series this could happily
go via another tree (e.g. akpm).

Thanks,

Will
