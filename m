From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 Jul 2015 11:58:47 +0100
Subject: [RFC PATCH] arm64: force CONFIG_SMP=y and remove redundant #ifdefs
In-Reply-To: <1436293575-5101-1-git-send-email-will.deacon@arm.com>
References: <1436293575-5101-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150708105847.GB6944@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 07:26:15PM +0100, Will Deacon wrote:
> Nobody seems to be producing !SMP systems anymore, so this is just
> becoming a source of kernel bugs, particularly if people want to use
> coherent DMA with non-shared pages.
> 
> This patch forces CONFIG_SMP=y for arm64, removing a modest amount of
> code in the process.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> I'd appreciate any comments on this. Anybody got a good reason for
> CONFIG_SMP=n on arm64?

A good reason would be testing/validating some hardware configurations
or even KVM/Xen (to see how they cope with UP OS'es). Of course, this
still requires that someone tests UP builds regularly but at least under
KVM this shouldn't be hard.

An alternative, which does not remove any code:

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 318175f62c24..8610effa5b0d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -475,7 +475,8 @@ config CPU_BIG_ENDIAN
          Say Y if you plan on running a kernel in big-endian mode.
 
 config SMP
-	bool "Symmetric Multi-Processing"
+	bool "Symmetric Multi-Processing" if EXPERT
+	default y
 	help
 	  This enables support for systems with more than one CPU.  If
 	  you say N here, the kernel will run on single and

The help text needs re-writing as well, it doesn't make much sense these
days.

-- 
Catalin
