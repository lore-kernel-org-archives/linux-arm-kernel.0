From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 25 Sep 2015 15:50:59 +0100
Subject: [PATCH v1 0/8] xen/arm: vgic: Support 32-bit access for 64-bit
 register
Message-ID: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series aims to fix the 32-bit access on 64-bit register. Some guest
OS such as FreeBSD and Linux (only in the ITS) use 32-bit access and will
crash at boot time.

I took the opportunity to go further and optimize the way Xen is storing
registers such as GICD_IPRIORITYR, GICD_ITARGETR and GICD_IROUTER.

Major changes in v2:
    - Use the helpers in GICv2
    - Optimize the assembly input for vgic_regN_* helpers on arm32
    - Add support for sign-extension generically
    - Store GICD_{IPRIORITYR, ITARGETSR, IROUTER} in a better way

For all the changes see in each patch.

A branch has been pushed based on the lastest staging:

git://xenbits.xen.org/people/julieng/xen-unstable.git branch gicv3-32bit-v1

Sincerely yours,

Julien Grall (8):
  xen/arm: io: remove mmio_check_t typedef
  xen/arm: io: Extend write/read handler to pass the register in
    parameter
  xen/arm: Support sign-extension for every read access
  xen/arm: vgic: ctlr stores a 32-bit hardware register so use uint32_t
  xen/arm: vgic: Optimize the way to store GICD_IPRIORITYR in the rank
  xen/arm: vgic: Optimize the way to store the target vCPU in the rank
  xen/arm: vgic: Introduce helpers to read/write/clear/set vGIC register
    ...
  xen/arm: vgic-v3: Support 32-bit access for 64-bit registers

 xen/arch/arm/io.c            |  42 +++++-
 xen/arch/arm/vgic-v2.c       | 295 +++++++++++++++++++++---------------
 xen/arch/arm/vgic-v3.c       | 352 +++++++++++++++++++++++++------------------
 xen/arch/arm/vgic.c          |  72 ++++++++-
 xen/arch/arm/vuart.c         |  16 +-
 xen/include/asm-arm/domain.h |   2 +-
 xen/include/asm-arm/mmio.h   |   5 +-
 xen/include/asm-arm/vgic.h   | 148 +++++++++++++++---
 8 files changed, 617 insertions(+), 315 deletions(-)

-- 
2.1.4
