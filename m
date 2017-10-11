From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 11 Oct 2017 10:41:45 +0100
Subject: [PATCH 0/3] GICv3: Bounds check redistributor accesses
Message-ID: <20171011094148.15674-1-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While bringing up linux on a platform with GICv3, I ran into a kernel
crash (data abort) due to incorrectly sized GIC redistributor region
in the device tree.

Even though the firmware is expected to provide incorrect information,
crashing on the kernel's part when that is not the case is also not
ideal.

This series adds bounds checking to redistributor accesses. This
prevents the crash. But we can do one better - when the redistributor
region has been exhausted without encountering the last record the
user is warned of this situation. This can be useful for developers
during board bring-up.

Patch 3 is where the bulk of the checking is introduced. The patch is
a bit invasive but there doesn't seem to be a nicer way to isolate the
change given layout of the redistributor.

Feedback welcome.

Thanks,
Punit

Punit Agrawal (3):
  irqchip/gic-v3: Use resource structure to store redistributor regions
  irqchip/gic-v3: Report firmwware provided address in case of error
  irqchip/gic-v3: Bounds check redistributor accesses

 drivers/irqchip/irq-gic-v3.c | 80 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 19 deletions(-)

-- 
2.14.1
