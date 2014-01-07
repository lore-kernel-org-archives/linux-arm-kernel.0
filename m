From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Jan 2014 15:12:33 +0100
Subject: [PATCH] scripts/kallsyms: filter symbols not in kernel address
 space
In-Reply-To: <1382975339-25831-1-git-send-email-tom.leiming@gmail.com>
References: <1382975339-25831-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <201401071512.34016.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 October 2013, Ming Lei wrote:
> This patch uses CONFIG_PAGE_OFFSET to filter symbols which
> are not in kernel address space because these symbols are
> generally for generating code purpose and can't be run at
> kernel mode, so we needn't keep them in /proc/kallsyms.
> 
> For example, on ARM there are some symbols which are
> linked in relocatable code section, then perf can't parse
> symbols any more from /proc/kallsyms, and this patch fixes
> the problem.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Michal Marek <mmarek@suse.cz>
> Acked-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

Sorry for the late report, but I seem to have encountered a problem with this
patch, now that it has made it into all stable kernels.

When linking an ARM nommu kernel, I get the output "No valid symbol." twice,
from scripts/kallsyms. The problem evidently is that PAGE_OFFSET is still
set to 0xC0000000 on ARM NOMMU builds but the kernel is linked to start at
PLAT_PHYS_OFFSET instead, which may be elsehwere. For most platforms,
this is defined in Kconfig these days, so we could get away with

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d1e4098..c477a7c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1592,6 +1592,7 @@ endchoice
 
 config PAGE_OFFSET
 	hex
+	default PHYS_OFFSET if !MMU
 	default 0x40000000 if VMSPLIT_1G
 	default 0x80000000 if VMSPLIT_2G
 	default 0xC0000000

but there are still a few ARM platforms that define their own PLAT_PHYS_OFFSET
in memory.h, and it wouldn't help on non-ARM systems that might have the same
problem.

	Arnd
