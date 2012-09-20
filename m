From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 20 Sep 2012 07:18:22 +0200
Subject: [PATCH v4] Add basic address decoding support for Marvell 370/XP
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120920071822.05e00e33@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew, Jason,

Do you have any comments on this patch series? It has received a:

Acked-by: Arnd Bergmann <arnd@arndb.de>

with the only comment being the missing DT binding documentation. And
therefore wanted to see if you had other comments about the patches
before I send a v5 that includes the requested DT binding documentation.

Thanks!

Thomas

On Tue, 11 Sep 2012 14:27:13 +0200, Thomas Petazzoni wrote:
> Andrew, Jason, Gr?gory,
> 
> Here is a patch set that introduces basic support for address decoding
> on Armada 370 and Armada XP. The aim of this basic support is
> essentially to be able to configure a window to remap the BootROM,
> which is needed to startup the secondary CPUs for the SMP support.
> 
> As we had discussed already, the address decoding configuration is not
> described in the Device Tree, it is for now hardcoded on a per-SoC
> basis. We might later discuss how to extend this to the Device Tree.
> 
> The patch set is relatively long, as it refactors some existing
> Dove/Kirkwood/MV78xx0/Orion code to use void __iomem pointers instead
> of unsigned long, as per the request of Arnd Bergmann and Olof
> Johansson.
> 
> This patch set is split in several parts:
> 
>  (1) Patches 1-4 replaces binary or operators used in register address
>      definitions by plus operators. This is necessary because followup
>      patches change the base addresses constants to void __iomem
>      pointers, and binary or arithmetic on pointers is not
>      allowed. Also, using the plus operator to add an offset to a base
>      address is much more traditional. In our case, the binary or
>      operator and plus operator seem equivalent, as the low-order bits
>      of the base addresses that were being or'ed with an offset were
>      all zero.
> 
>  (2) Patches 5-9 use the IOMEM() macro to turn the various base
>      virtual addresses constants into void __iomem pointers. This
>      naturally makes all derived constants (virtual addresses of
>      specific registers or units) as void __iomem pointers as
>      well. The patches also adjust the code to take into this
>      change. It adds a few temporary "(unsigned long)" casts that are
>      removed by the following patches that rework a few plat-orion
>      APIs. These temporary casts are necessary to make the patch set
>      properly bisectable, without having a single big patch that does
>      the complete IOMEM() conversion. At the end of the patch set, the
>      only (unsigned long) casts that remain are the one in the
>      map_desc[] array definitions, and those ones are expected.
> 
>  (3) Patches 10-13 rework some plat-orion APIs so that they use void
>      __iomem pointers instead of unsigned long for virtual
>      addresses. Those patches also remove the now useless "(unsigned
>      long)" casts added in step (2) above.
> 
>  (4) Patch 14 introduces PLAT_ORION_LEGACY, which allows the Marvell
>      370/XP platforms to be part of PLAT_ORION, and therefore re-use
>      the existing address decoding code.
> 
>  (5) Patch 15 makes a small change to an address decoding structure so
>      that we can define at runtime the virtual address of the
>      configuration registers. This is needed as on Armada 370/XP the
>      address decoding "controller" is declared in the Device Tree.
> 
>  (6) Patch 16 adds the 370/XP address decoding code itself. For now,
>      it only maps the BootROM on Armada XP.
> 
>  (7) Patch 17 adds the necessary DT code to instantiate the address
>      decoding "controller".
> 
> This patch set has been:
> 
>  * Built, boot tested on Armada XP. The operation of the address
>    mapping support has been tested as well.
> 
>  * Built tested only on Dove, Kirkwood, Orion5x and MV78xx0.
> 
> Changes since v3:
>  * As per the request of Olof Johansson, use void __iomem pointers
>    everywhere instead of introducing more casts in the patch set. This
>    change has significantly increased the patch set size, though
>    (going from 5 patches in v3 to 17 patches in v4)
> 
> Changes since v2:
>  * Remove one more useless (void __iomem *) cast in the Armada 370/XP
>    addr-map.c file, as noticed by Arnd Bergmann.
> 
> Changes since v1:
>  * Use void __iomem * in addr-map code. Suggested by Arnd Bergmann.
>  * Add Acked-by on patches 2->5 from Gr?gory Cl?ment
> 
> Thanks,
> 
> Thomas Petazzoni
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
