From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 1 Feb 2011 11:51:28 +0100
Subject: [PATCH 3/9] Add a mfd IPUv3 driver
In-Reply-To: <1292842127-21406-4-git-send-email-s.hauer@pengutronix.de>
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
	<1292842127-21406-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110201105127.GA10128@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Dec 20, 2010 at 11:48:41AM +0100, Sascha Hauer wrote:
> The IPU is the Image Processing Unit found on i.MX50/51/53 SoCs. It
> features several units for image processing, this patch adds support
> for the units needed for Framebuffer support, namely:
> 
> - Display Controller (dc)
> - Display Interface (di)
> - Display Multi Fifo Controller (dmfc)
> - Display Processor (dp)
> - Image DMA Controller (idmac)
> 
> This patch is based on the Freescale driver, but follows a different
> approach. The Freescale code implements logical idmac channels and
> the handling of the subunits is hidden in common idmac code pathes
> in big switch/case statements. This patch instead just provides code
> and resource management for the different subunits. The user, in this
> case the framebuffer driver, decides how the different units play
> together.
> 
> The IPU has other units missing in this patch:
> 
> - CMOS Sensor Interface (csi)
> - Video Deinterlacer (vdi)
> - Sensor Multi FIFO Controler (smfc)
> - Image Converter (ic)
> - Image Rotator (irt)
> 
> So expect more files to come in this directory.
I couldn't look into details as the patch is huge, but it looks mostly good.
One thing I don't really like is the

+static struct device *ipu_dev;
+void __iomem *ipu_cm_reg;
+void __iomem *ipu_idmac_reg;

part. I know there is currently no HW supporting more than one of those
controllers, but as a general principle I find this is not a good programming
habit.

Now, on a less technical note: I don't really see how this driver fits in the
MFD category, unless the upcoming units support brings something new. If I
were looking for the i.MX5x image processing unit, I would be looking under
drivers/video/.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
