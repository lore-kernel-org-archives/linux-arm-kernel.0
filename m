From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 29 Nov 2013 11:01:18 +0530
Subject: Build warning in drivers/dma/mmp_tdma.c
In-Reply-To: <CAPcyv4i1i+3ia5qcYA-LR4TFq1MOCXTHLhW2u5maq6Us9kyATg@mail.gmail.com>
References: <CAPcyv4i1i+3ia5qcYA-LR4TFq1MOCXTHLhW2u5maq6Us9kyATg@mail.gmail.com>
Message-ID: <20131129053118.GC8834@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 02:58:53PM -0800, Dan Williams wrote:
> My build warning test is failing on this driver please fix:
> 
> drivers/dma/mmp_tdma.c:236:8: warning: 'tdcr' may be used
> uninitialized in this function [-Wuninitialized]
> 
> It's valid as mmp_tdma_control as the direction is specified in
> mmp_tdma_control() and may not be one of the two tests in that branch.
Yup, i guess best would be init to zero, which is what i have done here
I did check this driver and got bunch of warns which i fixed in [1]. But i didnt
get this one, i need to redo my build scripts now or use yours :)

From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 29 Nov 2013 10:52:52 +0530
Subject: [PATCH] dmaengine: mmp: fix uninitialized variable

drivers/dma/mmp_tdma.c:236:8: warning: 'tdcr' may be used
uninitialized in this function [-Wuninitialized]

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/mmp_tdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 61b562b..d4b730c 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -182,7 +182,7 @@ static void mmp_tdma_pause_chan(struct mmp_tdma_chan *tdmac)
 
 static int mmp_tdma_config_chan(struct mmp_tdma_chan *tdmac)
 {
-	unsigned int tdcr;
+	unsigned int tdcr = 0;
 
 	mmp_tdma_disable_chan(tdmac);
 
-- 
[1]: https://patchwork.kernel.org/patch/3253411/

> 
> 
> 
> I'm also carrying patch to add a missing dependency:
> 
> commit 1a4ee91dacedde3e82d8ce6eeace7f16884474f9
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Thu Nov 28 12:27:38 2013 -0800
> 
>     dma: mmp_dma depends on CPU_MMP2
> 
>     It calls sram_get_gpool() which is only defined if CONFIG_CPU_MMP2=y
> 
>     Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 446687cc2334..dad83634cb65 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -287,7 +287,7 @@ config DMA_SA11X0
> 
>  config MMP_TDMA
>         bool "MMP Two-Channel DMA support"
> -       depends on ARCH_MMP
> +       depends on ARCH_MMP && CPU_MMP2
>         select DMA_ENGINE
>         help
>           Support the MMP Two-Channel DMA engine.
> 
> Is there a different ARCH type that this driver should be depending on?
This looks good to me though I tried removing CPU_MMP2 manually and compiling.
Kconfig tells me "selected by: MACH_BROWNSTONE [=y] && ARCH_MMP [=y] &&
!CPU_MOHAWK [=n]" so I think its implict here, but I think this patch ensures we
dont have build breakage

--
~Vinod
