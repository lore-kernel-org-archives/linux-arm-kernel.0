From: sdu.liu@huawei.com (Liu Hua)
Date: Mon, 4 Aug 2014 12:17:39 +0800
Subject: [PATCH V2 0/1] irqchip: GIC: check and clear GIC interupt active state
Message-ID: <1407125860-37718-1-git-send-email-sdu.liu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For this version of GIC codes, kernel assumes that all the interrupt
status of GIC is inactive. So the kernel does not check this when 
booting.

This is no problem on must sitations. But when kdump is deplayed.
And a panic occurs when an interrupt is being handled (may be PPI 
). We have no chance to write relative bit to GICC_EOIR. So this 
interrupt remains active. And GIC will not deliver this type 
interrupt to cpu interface. And the capture kernel may  fail to boot
becase of lacking of certain interrupt (such as timer interupt).

I have test this patch on arma9el(GIC v1), arma15el and arma15eb(GIC v2) 
platforms. And the tests passed.

changes from V1:

  - used for_each_set_bit instead of find_next_bit
  - removed the GIC version indentifying codes.
  - used one way to inactive GIC interupt states for all GIC version

Liu Hua (1):
  GIC: introduce method to deactive interupts

 drivers/irqchip/irq-gic.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
1.9.0
