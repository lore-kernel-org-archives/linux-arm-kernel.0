From: rob@ti.com (Rob Clark)
Date: Thu, 15 Jul 2010 23:15:37 -0500
Subject: [PATCH 0/2] Fix ptrace software breakpoints
In-Reply-To: <1279209238-16234-1-git-send-email-will.deacon@arm.com>
References: <1279209238-16234-1-git-send-email-will.deacon@arm.com>
Message-ID: <FB3C047B-0B6C-4605-A481-667C7E75B745@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fyi, my gdb test (git://github.com/robclark/gdb-test.git) seems to be passing reliable so far (I haven't seen it fail once yet) with these patches..  without these patches, it was triggering passing the breakpoing 90+% of the time.

I'll keep you posted if I notice any issues, but so far so good!

thx

BR,
-R

On Jul 15, 2010, at 10:53 AM, Will Deacon wrote:

> When using GDB on a quad-core Cortex-A9 (Versatile Express) board, software
> breakpoints do not work if the inferior is scheduled onto a different CPU from
> the debugger.
> 
> When GDB changes the code of another context via the ptrace POKETEXT mechanism,
> the I-cache must be invalidated before the inferior is allowed to resume. If a
> copy-on-write is triggered by the copy_to_user_page function, the new page
> mappings must be used by the inferior in order to pick up the new instructions.
> 
> This patch series addresses this problem by:
> 
> (a) Providing a workaround for a known TLB issue on some revisions of the Cortex-A9.
> (b) Performing correct I-cache invalidation in the flush_ptrace_access code.
> 
> All feedback/comments/tested-bys welcome.
> 
> Cc: Rob Clark <rob@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> 
> Will Deacon (2):
>  ARM: errata: TLBIASIDIS and TLBIMVAIS operations can broadcast a
>    faulty ASID
>  ARM: flush_ptrace_access: invalidate all I-caches
> 
> arch/arm/Kconfig                |   12 ++++++++++++
> arch/arm/include/asm/tlbflush.h |    8 ++++++++
> arch/arm/mm/flush.c             |    4 ++--
> 3 files changed, 22 insertions(+), 2 deletions(-)
