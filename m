From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Apr 2018 12:12:41 +0100
Subject: noveau vs arm dma ops
In-Reply-To: <20180426090942.GA18811@infradead.org>
References: <20180425054855.GA17038@infradead.org>
 <CAKMK7uEFitkNQrD6cLX5Txe11XhVO=LC4YKJXH=VNdq+CY=DjQ@mail.gmail.com>
 <CAKMK7uFx=KB1vup=WhPCyfUFairKQcRR4BEd7aXaX1Pj-vj3Cw@mail.gmail.com>
 <20180425064335.GB28100@infradead.org> <20180425074151.GA2271@ulmo>
 <20180425085439.GA29996@infradead.org>
 <20180425100429.GR25142@phenom.ffwll.local>
 <20180425153312.GD27076@infradead.org>
 <CAKMK7uH14qupTYDa1pr8UC434Vs+97eUXj+fYi=+2uijCLayMA@mail.gmail.com>
 <20180426090942.GA18811@infradead.org>
Message-ID: <20180426111240.GS16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(While there's a rain shower...)

On Thu, Apr 26, 2018 at 02:09:42AM -0700, Christoph Hellwig wrote:
> synopsis:
> 
> drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c:    pdevinfo.dma_mask       = DMA_BIT_MASK(32);
> drivers/gpu/drm/bridge/synopsys/dw-hdmi.c:              pdevinfo.dma_mask = DMA_BIT_MASK(32);

This is for the AHB audio driver, and is a correct default on two counts:

1. It is historically usual to initialise DMA masks to 32-bit, and leave
   it to the device drivers to negotiate via the DMA mask functions if
   they wish to use higher orders of bits.

2. The AHB audio hardware in the HDMI block only supports 32-bit addresses.

What I've missed from the AHB audio driver is calling the DMA mask
functions... oops.  Patch below.

> drivers/gpu/drm/bridge/synopsys/dw-hdmi.c:              pdevinfo.dma_mask = DMA_BIT_MASK(32);

This is for the I2S audio driver, and I suspect is wrong - I doubt
that the I2S sub-device itself does any DMA what so ever.

8<===
From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: drm: bridge: dw-hdmi: Negotiate dma mask with DMA API

DMA drivers are supposed to negotiate the DMA mask with the DMA API,
but this was missing from the AHB audio driver.  Add the necessary
call.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
index cf3f0caf9c63..16c45b6cd6af 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
@@ -539,6 +539,10 @@ static int snd_dw_hdmi_probe(struct platform_device *pdev)
 	unsigned revision;
 	int ret;
 
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
 	writeb_relaxed(HDMI_IH_MUTE_AHBDMAAUD_STAT0_ALL,
 		       data->base + HDMI_IH_MUTE_AHBDMAAUD_STAT0);
 	revision = readb_relaxed(data->base + HDMI_REVISION_ID);


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
