From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 14:31:46 +0100
Subject: [PATCH 2/2] dmaengine: mmp-tdma: fix terminate_all return code
In-Reply-To: <2099590.pAO9NcseBT@wuerfel>
References: <2099590.pAO9NcseBT@wuerfel>
Message-ID: <9755822.HDlnFBj4xE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a recent cleanup, the mmp_tdma_terminate_all function was
introduced but does not set a proper return value. Almost
no slave driver uses that return value, but if one does, the
result will be undefined, which the compiler warns about:

dma/mmp_tdma.c: In function 'mmp_tdma_terminate_all':
dma/mmp_tdma.c:474:1: warning: no return statement in function returning non-void [-Wreturn-type]

This changes the driver to return zero, like most other
drivers do.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: f43a6fd400ba6 ("dmaengine: mmp-tdma: Split device_control")

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 91fb241102f7..70c2fa9963cd 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -471,6 +471,8 @@ static int mmp_tdma_terminate_all(struct dma_chan *chan)
 	mmp_tdma_disable_chan(chan);
 	/* disable interrupt */
 	mmp_tdma_enable_irq(tdmac, false);
+
+	return 0;
 }
 
 static int mmp_tdma_config(struct dma_chan *chan,
