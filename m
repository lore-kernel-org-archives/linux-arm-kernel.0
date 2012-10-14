From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 14 Oct 2012 18:28:43 +1300
Subject: dma_alloc_coherent fails in framebuffer
Message-ID: <1350192523.10946.4.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Up until 07 Oct, drivers/video/wm8505-fb.c was working fine, but on the
11 Oct when I did another pull from linus all of a sudden
dma_alloc_coherent is failing to allocate the framebuffer any longer.

I did a quick look back and found this:

ARM: add coherent dma ops

arch_is_coherent is problematic as it is a global symbol. This
doesn't work for multi-platform kernels or platforms which can support
per device coherent DMA.

This adds arm_coherent_dma_ops to be used for devices which connected
coherently (i.e. to the ACP port on Cortex-A9 or A15). The arm_dma_ops
are modified at boot when arch_is_coherent is true.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>


This is the only patch lately that I could find (not that I would claim
to be any good at finding things) that is related to the problem. Could
it have caused the allocations to fail?

Regards
Tony P
