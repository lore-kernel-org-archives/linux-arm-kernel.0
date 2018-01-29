From: rdunlap@infradead.org (Randy Dunlap)
Date: Mon, 29 Jan 2018 13:49:14 -0800
Subject: [PATCH v7 2/2] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <1517217696-17816-1-git-send-email-yong.deng@magewell.com>
References: <1517217696-17816-1-git-send-email-yong.deng@magewell.com>
Message-ID: <c86097d7-dade-01e5-3826-3f22f9ca4b4f@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2018 01:21 AM, Yong Deng wrote:
> Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> interface and CSI1 is used for parallel interface. This is not
> documented in datasheet but by test and guess.
> 
> This patch implement a v4l2 framework driver for it.
> 
> Currently, the driver only support the parallel interface. MIPI-CSI2,
> ISP's support are not included in this patch.
> 
> Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Yong Deng <yong.deng@magewell.com>
> ---


A previous version (I think v6) had a build error with the use of
PHYS_OFFSET, so Kconfig was modified to depend on ARM and ARCH_SUNXI
(one of which seems to be overkill).  As is here, the COMPILE_TEST piece is
meaningless for all arches except ARM.  If you care enough for COMPILE_TEST
(and I would), then you could make COMPILE_TEST useful on any arch by
removing the "depends on ARM" (the ARCH_SUNXI takes care of that) and by
having an alternate value for PHYS_OFFSET, like so:

+#if defined(CONFIG_COMPILE_TEST) && !defined(PHYS_OFFSET)
+#define PHYS_OFFSET	0
+#endif

With those 2 changes, the driver builds for me on x86_64.

> diff --git a/drivers/media/platform/sunxi/sun6i-csi/Kconfig b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> new file mode 100644
> index 0000000..f80c965
> --- /dev/null
> +++ b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> @@ -0,0 +1,10 @@
> +config VIDEO_SUN6I_CSI
> +	tristate "Allwinner V3s Camera Sensor Interface driver"
> +	depends on ARM
> +	depends on VIDEO_V4L2 && COMMON_CLK && VIDEO_V4L2_SUBDEV_API && HAS_DMA
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	select VIDEOBUF2_DMA_CONTIG
> +	select REGMAP_MMIO
> +	select V4L2_FWNODE
> +	---help---
> +	   Support for the Allwinner Camera Sensor Interface Controller on V3s.

thanks,
-- 
~Randy
