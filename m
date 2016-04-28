From: james.morse@arm.com (James Morse)
Date: Thu, 28 Apr 2016 18:31:12 +0100
Subject: [PATCH v9 00/14] arm64: kernel: Add support for
 hibernate/suspend-to-disk
In-Reply-To: <20160428124054.GC30834@arm.com>
References: <1461775633-29715-1-git-send-email-james.morse@arm.com>
 <20160428124054.GC30834@arm.com>
Message-ID: <572248E0.6050009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 28/04/16 13:40, Will Deacon wrote:
> On Wed, Apr 27, 2016 at 05:46:59PM +0100, James Morse wrote:
>> This is the today's version of hibernate for arm64, based on arm64's
>> for-next/core with latest commit 6a1f54711447 ("arm64: acpi: add acpi=on
>> cmdline option to prefer ACPI boot over DT").
> 
> I've queued this locally, but it breaks an allmodconfig build:

... I should have tested that ...


> kernel/built-in.o: In function `saveable_page':
> memremap.c:(.text+0x100f90): undefined reference to `kernel_page_present'
> kernel/built-in.o: In function `swsusp_save':
> memremap.c:(.text+0x1026f0): undefined reference to `kernel_page_present'
> make: *** [vmlinux] Error 1
> 
> Can you take a look, please?

This is caused by DEBUG_PAGEALLOC, which clears the PTE_VALID bit from 'free'
pages. Hibernate uses it as a hint that it shouldn't save/access that page. This
function is used to test whether the PTE_VALID bit has been cleared by
kernel_map_pages(), hibernate is the only user.

Fixing this exposes a bigger problem with that configuration though: if the
resume kernel has cut free pages out of the linear map, we copy this
swiss-cheese view of memory, and try to use it to restore...

We can fixup the copy of the linear map, but it then explodes in my lazy 'clean
the whole kernel to PoC' after resume, as now both the kernel and linear map
have holes in them.

For now I think forbidding this configuration is best. ARCH_HIBERNATION_POSSIBLE
depends on !DEBUG_PAGEALLOC would be best, but we can't do that, as
DEBUG_PAGEALLOC has:
> depends on !HIBERNATION || ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC
which causes kconfig to winge about loops in its dependencies.

-----------------------%<-----------------------
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b87f303765d4..0a7ff709a851 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -579,6 +579,7 @@ source kernel/Kconfig.hz

 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
        def_bool y
+       depends on !HIBERNATION

 config ARCH_HAS_HOLES_MEMORYMODEL
        def_bool y if SPARSEMEM
-----------------------%<-----------------------


Thanks,

James
