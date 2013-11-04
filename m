From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Mon, 4 Nov 2013 13:51:53 +0100
Subject: [PATCH 01/28] dmaengine: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <20131030130325.GA18788@intel.com>
References: <20131017020745.GA14013@intel.com>
 <20131017142755.GA4477@breakpoint.cc>
 <20131017134846.GG14013@intel.com>
 <Pine.LNX.4.64.1310242326500.2900@axis700.grange>
 <20131025042310.GC21230@intel.com>
 <Pine.LNX.4.64.1310250813370.6186@axis700.grange>
 <20131025054321.GD21230@intel.com>
 <Pine.LNX.4.64.1310250840350.6186@axis700.grange>
 <CAOesGMivD_3zSL503R0OaqyGv4Rj8qJqnbM2TdmjtxR2U63ztw@mail.gmail.com>
 <20131030130325.GA18788@intel.com>
Message-ID: <20131104125152.GA27260@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.10.13, Vinod Koul wrote:
> I fixed up the error with below, can you pls verify. Pls note this is compile
> tested only!

I tested this and my mmc driver using edma via drivers/dma seems to
work.
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

However you missed one piece:

  CC [M]  sound/soc/davinci/davinci-pcm.o
sound/soc/davinci/davinci-pcm.c: In function ?davinci_pcm_dma_irq?:
sound/soc/davinci/davinci-pcm.c:241: error: ?DMA_COMPLETE? undeclared (first use in this function)
sound/soc/davinci/davinci-pcm.c:241: error: (Each undeclared identifier is reported only once
sound/soc/davinci/davinci-pcm.c:241: error: for each function it appears in.)

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 sound/soc/davinci/davinci-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 8460edc..e68ba31 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -238,7 +238,7 @@ static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
 	print_buf_info(prtd->ram_channel, "i ram_channel");
 	pr_debug("davinci_pcm: link=%d, status=0x%x\n", link, ch_status);
 
-	if (unlikely(ch_status != DMA_COMPLETE))
+	if (unlikely(ch_status != EDMA_DMA_COMPLETE))
 		return;
 
 	if (snd_pcm_running(substream)) {
-- 
1.8.4.rc3

Sebastian
