From: joshc@codeaurora.org (Josh Cartwright)
Date: Fri, 6 Sep 2013 15:55:38 -0500
Subject: [PATCH] ARM: msm: Remove irqs-*.h files for DT based targets
In-Reply-To: <1378499517-24014-1-git-send-email-sboyd@codeaurora.org>
References: <20130906195300.GJ808@joshc.qualcomm.com>
 <1378499517-24014-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130906205538.GK808@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 06, 2013 at 01:31:57PM -0700, Stephen Boyd wrote:
> We don't want or need the irqs.h files from the DT based MSM
> targets. Remove these header files and select sparse irq so that
> we don't try to include the mach/irqs.h file.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> On 09/06, Josh Cartwright wrote:
> > 
> > Selecting _only_ ARCH_MSM8974 with these changes breaks the build with:
> 
> I've been meaning to fix this. Perhaps you can use this patch as a base
> and then push the SPARSE_IRQ selection into the DT config?

Sounds sane to me.  AFAICT, we didn't yet have any users of these
defines upstream.  Using SPARSE_IRQ puts on the path of multiplatform
support anyway.

FWIW, I tested this by applying this change under Rohit's and squashing
the following with patch 1/2:

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index fe35acf..f4a0aaa 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -50,7 +50,6 @@ config ARCH_MSM8X60
 	select HAVE_SMP
 	select MSM_SCM if SMP
 	select USE_OF
-	select SPARSE_IRQ
 
 config ARCH_MSM8960
 	bool "MSM8960"
@@ -60,7 +59,6 @@ config ARCH_MSM8960
 	select GPIO_MSM_V2
 	select MSM_SCM if SMP
 	select USE_OF
-	select SPARSE_IRQ
 
 config ARCH_MSM8974
 	bool "MSM8974"
@@ -74,6 +72,7 @@ config ARCH_MSM8974
 config ARCH_MSM_DT
 	def_bool y
 	depends on (ARCH_MSM8X60 || ARCH_MSM8960 || ARCH_MSM8974)
+	select SPARSE_IRQ
 
 config MSM_HAS_DEBUG_UART_HS
 	bool
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
