From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 4 Jul 2016 09:41:23 -0400
Subject: [PATCH 3/4] bus: tegra-aconnect: make it explicitly non-modular
In-Reply-To: <577A2995.6020504@nvidia.com>
References: <20160703173040.23612-1-paul.gortmaker@windriver.com>
 <20160703173040.23612-4-paul.gortmaker@windriver.com>
 <577A2995.6020504@nvidia.com>
Message-ID: <20160704134123.GV26134@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH 3/4] bus: tegra-aconnect: make it explicitly non-modular] On 04/07/2016 (Mon 10:17) Jon Hunter wrote:

> Hi Paul,
> 
> On 03/07/16 18:30, Paul Gortmaker wrote:
> > The Kconfig currently controlling compilation of this code is:
> > 
> > drivers/bus/Kconfig:config TEGRA_ACONNECT
> > drivers/bus/Kconfig:    bool "Tegra ACONNECT Bus Driver"
> > 
> > ...meaning that it currently is not being built as a module by anyone.
> > 
> > Lets remove the modular code that is essentially orphaned, so that
> > when reading the driver there is no doubt it is builtin-only.
> > 
> > We explicitly disallow a driver unbind, since that doesn't have a
> > sensible use case anyway, and it allows us to drop the ".remove"
> > code for non-modular drivers.
> > 
> > Since module_platform_driver() uses the same init level priority as
> > builtin_platform_driver() the init ordering remains unchanged with
> > this commit.
> > 
> > Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> > 
> > We also delete the MODULE_LICENSE tag etc. since all that information
> > was (or is now) contained at the top of the file in the comments.
> 
> In version 3 of the aconnect series [0] I had made this a tristate
> because we allowed it to be removed and you had submitted a patch to
> export the PM_CLK APIs. However, when discussing with Thierry he said
> that we were unable to merge with tristate because of the dependency on
> your patch. So he suggested we merge with bool for now and then change
> it back to tristate for v4.9.

Oh I see.  The exported clock syms were for the 210 DMA driver and it
never crossed my mind that this driver needed the same syms in order for
it to be tristate.  Guess the exports proved useful afterall.  :)

> 
> I understand that we should not do this, but we do plan to make this
> modular in the future.

No problem ; I will drop this patch in favor of a one line Kconfig patch
in my test queue so it doesn't trip the regular audit, just like I have
for the 210 below -- not yet submitted for the same dependency reason.

P.
---


 From fe5bdc6348828c157deb14e8d75c732abcc2ad2b Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 20 May 2016 14:30:43 -0400
Subject: [PATCH] dma: tegra210-adma: convert TEGRA210_ADMA from bool to
 tristate

This driver currently uses modular infrastructure but is controlled
by a bool Kconfig.

There is a general consensus from the DMA reviewers and maintainers
that "if it can be modular, it should be modular" in order to keep
the bzImage size under control for multi platform kernels.

Build tested only.  Also needs some new pm_clk symbols exported
before this commit is applied to tree in order to avoid modpost
errors like:

  ERROR: "pm_clk_add_clk" [drivers/dma/tegra210-adma.ko] undefined!
  ERROR: "pm_clk_create" [drivers/dma/tegra210-adma.ko] undefined!
  ERROR: "pm_clk_destroy" [drivers/dma/tegra210-adma.ko] undefined!
  ERROR: "pm_clk_suspend" [drivers/dma/tegra210-adma.ko] undefined!
  ERROR: "pm_clk_resume" [drivers/dma/tegra210-adma.ko] undefined!

Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: dmaengine at vger.kernel.org
Cc: linux-tegra at vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 8c98779a12b1..866068d84ca2 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -468,7 +468,7 @@ config TEGRA20_APB_DMA
 	  or vice versa. It does not support memory to memory data transfer.
 
 config TEGRA210_ADMA
-	bool "NVIDIA Tegra210 ADMA support"
+	tristate "NVIDIA Tegra210 ADMA support"
 	depends on ARCH_TEGRA_210_SOC
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
-- 
2.8.0

> 
> Cheers
> Jon
> 
> [0] http://marc.info/?l=linux-tegra&m=146616753627760&w=2
> 
> -- 
> nvpublic
