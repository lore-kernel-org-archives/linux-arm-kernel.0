From: ml-arm@syscall.eu (=?UTF-8?B?UmFwaGHDq2wgUmlnbw==?=)
Date: Sun, 15 Jun 2014 20:59:48 +0200
Subject: [BUG] Armada 370 system clock drift (SSC related)
Message-ID: <539DED24.6010802@syscall.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I have a Netgear ReadyNAS 102 which exhibits a strong drift of its system clock.
The drift is pretty stable, as this old log shows :

Dec 15 07:23:41  9.760884 sec
Dec 15 08:23:58  9.737968 sec
Dec 15 09:24:14  9.750450 sec
Dec 15 10:24:31  9.762054 sec
...
Dec 16 19:33:37  9.750936 sec
Dec 16 20:33:54  9.757914 sec

I took a look at Netgear GPL code in their kernel (3.0.93, based on Marvell 4.0
LSP) and noticed the following in arch/arm/mach-armada370/time.c:

#include "boardEnv/mvBoardEnvSpec.h"
void __init axp_time_init(unsigned int fabric_clk)
{
        u32 u;

        printk("axp_time_init\n");

        ticks_per_jiffy = (fabric_clk + HZ/2) / HZ;
        if (get_board_type() & (NETGEAR_BD_TYPE_RN102 | NETGEAR_BD_TYPE_RN104))
        {
                if (0 == (MV_REG_READ(MPP_SAMPLE_AT_RESET) & BIT10))
                {
                        // DDR SSC is enabled.


                        fabric_clk = 598393125;
                } else {
                        // DDR SSC is disabled. fabric_clk is no need to change.


                        ;
                }
        }

I noticed that the above value is such that

  3600*(1 - (598393125/600000000)) = 9.64125

i.e. the hardcoded correction matches the drift observed above.


Which is consistent with the information in the recently released Marvell
documentation. In ARMADA370-FunctionalSpec-datasheet.pdf page 1140 there's the
explanation of the SSCG (spread spectrum clock generator) Configuration Register
which can be read to adjust the clock rate.

It would be nice if this bug could be fixed. If nobody steps up, I may try
patching it but since I have zero knowledge of creating kernel patches, it would
take me a long time compared to someone familiar with the code base.

Regards,
Rapha?l Rigo
