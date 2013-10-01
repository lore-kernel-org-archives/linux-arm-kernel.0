From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 01 Oct 2013 19:32:55 +0900
Subject: [PATCH 00/05] ARM: shmobile: KZM9D Multiplatform update
Message-ID: <20131001103255.813.65710.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: KZM9D Multiplatform update

[PATCH 01/05] ARM: shmobile: Sync KZM9D DTS with KZM9D reference DTS
[PATCH 02/05] ARM: shmobile: Use KZM9D without reference for multiplatform
[PATCH 03/05] ARM: shmobile: Remove non-multiplatform KZM9D reference support
[PATCH 04/05] ARM: shmobile: Let KZM9D multiplatform boot with KZM9D DTB
[PATCH 05/05] ARM: shmobile: Remove KDM9D reference DTS

This series updates mach-shmobile and the KZM9D board code to propose
a way forward for future CCF-enabled multiplatform board support.

With this series applied the following rules apply:

 - CONFIG_ARCH_MULTIPLATFORM=y is used to enable multiplatform
   - CONFIG_ARCH_SHMOBILE_MULTI=y is used in case of multiplatform build
 - CONFIG_ARCH SHMOBILE=y is used in case of legacy non-multiplatform build
 - CONFIG_MACH_KZM9D=y enables KZM9D board support regardless of multiplatform
   - In case of multiplatform build board-kzm9d-reference.c is used
   - In case of legacy non-multiplatform build board-kzm9d.c is used
 - KZM9D reference can no longer be built for non-multiplatform
 - CONFIG_MACH_KZM9D_REFERENCE actually no longer exists
 - emev2-kzm9d-reference.dts has been removed, use emev2-kzm9d.dts instead
 - The same emev2-kzm9d.dts is used regardless of kernel configuration
  - emev2-kzm9d.dtb can be used with legacy non-multiplatform
  - emev2-kzm9d.dtb can be used with multiplatform

In practice the above means that legacy board code users can keep on using
existing emev2-kzm9d.dtb as-is, but when updating to multiplatform kernel
the DTB needs to be updated as well and from that point the DTB needs to
be updated whenever new hardware is added.

The above seems pretty straight forward from my point of view, so I
propose that we follow the same style for future multiplatform board
support.

Before merging this series I'd like to see Yoshii-san's CCF patches
for KZM9D and EMEV2 to be finalized and picked up.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-20131001 and
 [PATCH 00/10] ARM: shmobile: r8a7791 SoC and Koelsch update V2
 plus selected CCF patches from Yoshii-san.

 arch/arm/boot/dts/Makefile                     |    3 -
 arch/arm/boot/dts/emev2-kzm9d-reference.dts    |   57 ------------------------
 arch/arm/boot/dts/emev2-kzm9d.dts              |   33 +++++++++++++
 arch/arm/mach-shmobile/Kconfig                 |   22 ---------
 arch/arm/mach-shmobile/Makefile                |    5 +-
 arch/arm/mach-shmobile/Makefile.boot           |    1 
 arch/arm/mach-shmobile/board-kzm9d-reference.c |    1 
