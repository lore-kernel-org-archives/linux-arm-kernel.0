From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 15:42:18 +0000
Subject: [PATCH v2] ARM: setup.c: Fix build warning by removing
 unneeded header file
In-Reply-To: <1325536725-28403-1-git-send-email-festevam@gmail.com>
References: <1325535113-26551-1-git-send-email-festevam@gmail.com>
 <1325536725-28403-1-git-send-email-festevam@gmail.com>
Message-ID: <20120103154218.GW2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2012 at 06:38:45PM -0200, Fabio Estevam wrote:
> Fix the following build warning:
> 
>   CC      arch/arm/kernel/setup.o
> In file included from arch/arm/kernel/setup.c:39:
> arch/arm/include/asm/elf.h:102:1: warning: "vmcore_elf64_check_arch" redefined
> In file included from arch/arm/kernel/setup.c:24:
> include/linux/crash_dump.h:30:1: warning: this is the location of the previous definition
> 
> Since commit 93a72052 (crash_dump: export is_kdump_kernel to modules, consolidate elfcorehdr_addr, setup_elfcorehdr and saved_max_pfn)
> the inclusion of <linux/crash_dump.h> is no longer needed.
> 
> Remove the inclusion of <linux/crash_dump.h> and the build warning is fixed.

Actually, this is fragile.  This is _excessively_ fragile.

linux/crash_dump.h makes no attempt to include asm/elf.h, but it depends
on stuff in asm/elf.h to determine how stuff inside this file is defined
at parse time.

So, if asm/elf.h is included after linux/crash_dump.h or not at all, you
get a different result from the situation where asm/elf.h is included
before.

Therefore, while this change may on the face of it seem correct, it's
only a sticky plaster over the problem by avoiding the situation rather
than fixing it properly.

I won't apply this until the real problem (missing include in
linux/crash_dump.h) is resolved.
