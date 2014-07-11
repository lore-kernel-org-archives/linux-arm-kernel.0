From: sdu.liu@huawei.com (Liu Hua)
Date: Fri, 11 Jul 2014 14:46:15 +0800
Subject: [RFC PATCH 0/2] irqchip: GIC: check and clear GIC interupt active
 status
Message-ID: <1405061177-43834-1-git-send-email-sdu.liu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For this version of GIC codes, kernel assumes that all the interrupt
status of GIC is inactive. So the kernel does not check this when 
booting.

This is no problem on must sitations. But when kdump is deplayed.
And a panic occurs when a interrupt is being handled (may be PPI 
and SPI). We have no chance to write relative bit to GICC_EOIR.
So this interrupt remains active. And GIC will not deliver this
type interrupt to cpu interface. And the capture kernel may 
fail to boot becase of lacking of certain interrupt (such as timer 
interupt).


I glanced over the GIC Architecture Specification, but did not 
find a simple way to deactive state of all interrupts. For GICv1,
I can only deal with one abnormal interrupt state one time. For 
GICv2, I can deactive 32 one time.


So guys, Do you know a better way to do that? 


Liu Hua (2):
  irqchip: gic: introduce ICPIDR2 register interface
  irqchip: GIC: introduce method to deactive interupts

 drivers/irqchip/irq-gic.c       | 57 +++++++++++++++++++++++++++++++++++++++++
 include/linux/irqchip/arm-gic.h |  1 +
 2 files changed, 58 insertions(+)

-- 
1.9.0
