From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Sat, 29 Sep 2012 23:58:57 +0200
Subject: imx6q: high interrupt latencies
Message-ID: <50676F21.4000705@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

I have been observing high interrupt latencies on imx6q, the problem
seems to be in the FEC driver, function fec_enet_tx. The following line:

        while (((status = bdp->cbd_sc) & BD_ENET_TX_READY) == 0) {

can take 100us or more to execute, during which the local timer
interrupt are postponed.

As far as I understand, bdp is a pointer to a "struct bufdesc" shared
with the hardware and its status member is updated by the hardware when
the corresponding ethernet packet transmission is complete.

Adding a call to "mb()" or "outer_sync()" before reading the status
seems to avoid the issue, though I do not know if this is the proper fix.

Some more data. The boot logs say:
CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d
CPU identified as i.MX6Q, silicon rev 1.0
l2x0: 16 ways, CACHE_ID 0x410000c7

the kernel is compiled with the following errata enabled:
CONFIG_PL310_ERRATA_588369
CONFIG_PL310_ERRATA_727915
CONFIG_ARM_ERRATA_743622
CONFIG_ARM_ERRATA_751472
CONFIG_ARM_ERRATA_754322
CONFIG_ARM_ERRATA_764369
CONFIG_PL310_ERRATA_769419

Regards.

-- 
                                                                Gilles.
