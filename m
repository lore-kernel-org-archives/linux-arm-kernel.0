From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 11 Jul 2018 17:15:07 +0800
Subject: Does the driver need check the GICD_ACTIVE or GICD_PENDING state
 before SPI affinity changing
Message-ID: <5B45CA9B.8020602@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

The following case :

            cpu0           cpu1                          cpu2
           read iar
                           set affinity to cpu2
            dsb(sy)                                       read iar

cpu0 is interrupted by a edge-SPI. After cpu0 getting INTID,
cpu1 set SPI's affinity to another cpu(like cpu2), if the effects
of reading ICC_IAR1_EL1 on the state of a returned INTID are
not seeing by GIC, the SPI's state is still pending and the state
will be migrated to cpu2, so cpu2 can also read the INTID from
ICC_IAR1_EL1. It makes the SPI be handled twice.

Does the driver need check the GICD_ACTIVE or GICD_PENDING
state before SPI affinity changing or should hardware guarantee
this case can't happen ?

Does GIC SPEC have describe the affinity chaning flow ?


Thanks,
Yang
