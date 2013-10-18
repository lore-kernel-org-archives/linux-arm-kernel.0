From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 18 Oct 2013 22:13:09 +0200
Subject: [PATCH v3 0/6] iommu/arm-smmu: Misc modifications to support SMMUs on
 Calxeda ECX-2000
Message-ID: <1382127195-15261-1-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is v3 of arm-smmu changes to support SMMUs on Calxeda ECX-2000.

Esp. I've reworked the automatic StreamID masking. With this I try to
keep the number of used SMRs as low as possible. Of course it still
depends on some kind of reasonable ordering of StreamIDs for a master.

The general problem to determine the least number of mask/id pairs to
use for a given number of StreamIDs is not easy to solve.  But I think
the solution provided with patch 4 plus considering that we have some
influence how the StreamIDs are ordered (eg. when provided in DT) is
sufficient for kernel usage.

Here an example of SMR-usage for 3 SMMUs, each with one master device
and having StreamIDs 0-9, 0-1 and 0-1:

 arm-smmu 920180000.smmu: SMR0: 0x80070000
 arm-smmu 920180000.smmu: SMR1: 0x80010008
 arm-smmu 920180000.smmu: S2CR0: 0x0
 arm-smmu 920180000.smmu: S2CR1: 0x0
 arm-smmu 920000000.smmu: SMR0: 0x80010000
 arm-smmu 920000000.smmu: S2CR0: 0x0
 arm-smmu 920080000.smmu: SMR0: 0x80010000
 arm-smmu 920080000.smmu: S2CR0: 0x0


Changelog:
v3:
- Reworked automatic StreamID masking (I think the previous posted
  version was buggy anyway). It repeatedly tries to determine mask/id
  pairs for stream matching.
- Removed the patch that introduced support to mask all StreamIDs
  of a master device.
- Removed setting of flag sCR0_USFCFG in arm_smmu_device_notifier.
v2:
  http://marc.info/?l=linux-arm-kernel&m=138135834704855
v1:
   http://marc.info/?l=linux-arm-kernel&m=138122450023564


Regards,
Andreas
