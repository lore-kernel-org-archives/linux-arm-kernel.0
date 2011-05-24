From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 May 2011 10:39:13 +0100
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
In-Reply-To: <20110523132124.GI17672@n2100.arm.linux.org.uk>
References: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>
	<20110523132124.GI17672@n2100.arm.linux.org.uk>
Message-ID: <1306229953.19557.14.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-23 at 14:21 +0100, Russell King - ARM Linux wrote:
> On Mon, May 23, 2011 at 12:16:48PM +0100, Catalin Marinas wrote:
> > Newer versions of gcc generate unaligned accesses by default, causing
> > kernel panics when CONFIG_ALIGNMENT_TRAP is enabled. This patch adds the
> > -mno-unaligned-access option to gcc.
> 
> This description doesn't make sense.  If we have alignment traps enabled,
> then we _expect_ to fix up unaligned loads and stores.
> 
> Therefore there should be no panic if CONFIG_ALIGNMENT_TRAP is enabled.
> 
> So what's the _actual_ problem that this is trying to address?  What's
> the panic/oops look like?  And that information should be in the commit
> description _anyway_.

Does the patch below look better?

We cannot move alignment_init() earlier as we don't know how early the
compiler would generate unaligned accesses. An alternative is some
#ifdef's in head.S. Please let me know which variant you prefer.


ARM: Do not allow unaligned accesses when CONFIG_ALIGNMENT_TRAP

From: Catalin Marinas <catalin.marinas@arm.com>

Newer versions of gcc generate unaligned accesses by default. For ARMv6
and newer architecture versions, Linux disables the alignment trapping
(SCTLR.A) in the alignment_init() function. However, unaligned accesses
may still happen before this function is called (currently
pcpu_dump_alloc_info causes a kernel panic).

This patch adds the -mno-unaligned-access option to gcc when
CONFIG_ALIGNMENT_TRAP is enabled.

Reported-by: Ali Saidi <ali.saidi@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c7d321a..1c383d0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -101,6 +101,10 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
 CFLAGS_ABI	+=-funwind-tables
 endif
 
+ifeq ($(CONFIG_ALIGNMENT_TRAP),y)
+CFLAGS_ABI	+=$(call cc-option,-mno-unaligned-access,)
+endif
+
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
 AFLAGS_AUTOIT	:=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
 AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)


-- 
Catalin
