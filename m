From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jan 2014 18:55:03 +0000
Subject: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
In-Reply-To: <20140113173744.GA7746@atomide.com>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
 <20140108012110.GL5074@atomide.com>
 <20140109152437.GB27282@n2100.arm.linux.org.uk>
 <20140113141811.GD27282@n2100.arm.linux.org.uk>
 <20140113173744.GA7746@atomide.com>
Message-ID: <20140113185503.GE27282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 09:37:45AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [140113 08:48]:
> > Any news on this?
> 
> Sorry for the delay, now getting this:
> 
> arch/arm/mach-omap1/dma.c: In function ?omap1_system_dma_init?:
> arch/arm/mach-omap1/dma.c:368: error: ?struct omap_dma_dev_attr? has no member named ?chan?

Gah.  Next incremental patch:

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 404f89e3eeb8..1b1b64647def 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -344,14 +344,14 @@ static int __init omap1_system_dma_init(void)
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
 			__func__, pdev->name, pdev->id);
-		goto exit_release_chan;
+		goto exit_release_d;
 	}
 
 	ret = platform_device_add(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
 			__func__, pdev->name, pdev->id);
-		goto exit_release_chan;
+		goto exit_release_d;
 	}
 
 	dma_pdev = platform_device_register_full(&omap_dma_dev_info);
@@ -364,8 +364,6 @@ static int __init omap1_system_dma_init(void)
 
 exit_release_pdev:
 	platform_device_del(pdev);
-exit_release_chan:
-	kfree(d->chan);
 exit_release_d:
 	kfree(d);
 exit_iounmap:


-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
