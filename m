From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Sun, 17 Jun 2018 13:23:29 +0200
Subject: Patch "spi: bcm2835aux: ensure interrupts are enabled for shared
 handler" has been added to the 4.14-stable tree
Message-ID: <1529234609240107@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    spi: bcm2835aux: ensure interrupts are enabled for shared handler

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     spi-bcm2835aux-ensure-interrupts-are-enabled-for-shared-handler.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo at baz Sun Jun 17 12:13:49 CEST 2018
From: Rob Herring <robh@kernel.org>
Date: Thu, 3 May 2018 13:09:44 -0500
Subject: spi: bcm2835aux: ensure interrupts are enabled for shared handler

From: Rob Herring <robh@kernel.org>

[ Upstream commit bc519d9574618e47a0c788000fb78da95e18d953 ]

The BCM2835 AUX SPI has a shared interrupt line (with AUX UART).
Downstream fixes this with an AUX irqchip to demux the IRQ sources and a
DT change which breaks compatibility with older kernels. The AUX irqchip
was already rejected for upstream[1] and the DT change would break
working systems if the DTB is updated to a newer one. The latter issue
was brought to my attention by Alex Graf.

The root cause however is a bug in the shared handler. Shared handlers
must check that interrupts are actually enabled before servicing the
interrupt. Add a check that the TXEMPTY or IDLE interrupts are enabled.

[1] https://patchwork.kernel.org/patch/9781221/

Cc: Alexander Graf <agraf@suse.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Cc: linux-spi at vger.kernel.org
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-bcm2835aux.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -184,6 +184,11 @@ static irqreturn_t bcm2835aux_spi_interr
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	irqreturn_t ret = IRQ_NONE;
 
+	/* IRQ may be shared, so return if our interrupts are disabled */
+	if (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_CNTL1) &
+	      (BCM2835_AUX_SPI_CNTL1_TXEMPTY | BCM2835_AUX_SPI_CNTL1_IDLE)))
+		return ret;
+
 	/* check if we have data to read */
 	while (bs->rx_len &&
 	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &


Patches currently in stable-queue which might be from robh at kernel.org are

queue-4.14/spi-bcm2835aux-ensure-interrupts-are-enabled-for-shared-handler.patch
queue-4.14/dt-bindings-panel-lvds-fix-path-to-display-timing-bindings.patch
queue-4.14/dt-bindings-pinctrl-sunxi-fix-reference-to-driver.patch
queue-4.14/dt-bindings-serial-sh-sci-add-support-for-r8a77965-h-scif.patch
queue-4.14/doc-add-vendor-prefix-for-kieback-peter-gmbh.patch
queue-4.14/dt-bindings-dmaengine-rcar-dmac-document-r8a77965-support.patch
