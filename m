From: gerg@linux-m68k.org (Greg Ungerer)
Date: Tue, 26 Jul 2016 10:53:28 +1000
Subject: [PATCH v5 00/15] allow BFLT executables on systems with a MMU
In-Reply-To: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
References: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1712235f-a4b3-3026-adc5-3f19e1a47ae4@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/16 01:30, Nicolas Pitre wrote:
> This series provides the necessary changes to allow "flat" executable
> binaries meant for no-MMU systems to actually run on systems with a MMU.
> Also thrown in are various cleanups to binfmt_flat.c.
> 
> This can also be found in the following git repo:
> 
> 	git://git.linaro.org/people/nicolas.pitre/linux binfmt_flat_with_mmu

So everyone is in the loop - I have pulled this into my for-linus branch
at https://git.kernel.org/cgit/linux/kernel/git/gerg/m68knommu.git/ ,
excepting patch 15 (ARM specific changes).

My continued testing hasn't found any issues on m68k platforms.
I can completely boot up with a no-MMU user space and run on an
MMU enabled ColdFire platform).

I'll like to consider pushing this to Linus nearer the end of the
merge window if no-one has any objections.

Regards
Greg


> *Why?*
> 
> Because developing and testing natively on a large system with lots of
> RAM makes it so much more convenient to use all the existing profiling
> tools and debugging facilities that a kernel with lots of RAM can give.
> And incidentally, those systems with lots of RAM all have a MMU.
> 
> *Why not use elf_fdpic?*
> 
> The flat executable format is simple with very small footprint
> overhead, either in the executables themselves or kernel support.
> This makes the flat format more suitable than elf_fdpic for very small
> single user-app embedded systems.
> 
> And while elf_fdpic binaries can run on MMU systems, flat binaries still
> couldn't, which just felt wrong.
> 
> So here it is. The no-MMU support should remain unaffected, confirmed by
> Greg Ungerer. Tested with MMU on ARM and M68K.
> 
> Changes since v4:
> 
> - Isolated architecture specific changes in their own patches for easier
>   review through their own path to mainline.
> 
> - Added needed m68k register fixup from Greg Ungerer.
> 
> Changes since v3:
> 
> - Small cosmetic changes to pr_*().
> 
> - Addressed most important checkpatch complaints on the whole source file
>   and patches in this seris.
> 
> Changes since  v2:
> 
> - Added protection against a corrupted header that could have caused nasty
>   overflows etc. Suggested by Alan Cox.
> 
> - printk() modernization. Suggested by Greg Ungerer / Geert Uytterhoeven.
> 
> - Added Greg Ungerer's reviewed-by tag.
> 
> Changes since v1:
> 
> - Removed SuperH and Xtensa from the Kconfig rule as they fail to build
>   due to lack of get/put_unaligned_user().
> 
> - Clarified some commit logs a bit.
> 
> diffstat:
> 
>  arch/arm/include/asm/flat.h       |   5 +-
>  arch/m68k/include/asm/flat.h      |  11 +-
>  arch/m68k/include/asm/processor.h |   2 -
>  fs/Kconfig.binfmt                 |   3 +-
>  fs/binfmt_elf_fdpic.c             |  38 +--
>  fs/binfmt_flat.c                  | 525 ++++++++++++++++++--------------
>  fs/exec.c                         |  33 ++
>  include/linux/binfmts.h           |   2 +
>  8 files changed, 345 insertions(+), 274 deletions(-)
> 
