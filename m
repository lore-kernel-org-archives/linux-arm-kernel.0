From: atish.patra@wdc.com (Atish Patra)
Date: Thu,  8 Nov 2018 17:50:06 -0800
Subject: [RFC 0/3] Unify CPU topology across ARM64 & RISC-V 
Message-ID: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu-map DT entry in ARM64 can describe the CPU topology in
much better way compared to other existing approaches. RISC-V can
easily adopt this binding to represent it's own CPU topology.
Thus, both cpu-map DT binding and topology parsing code can be
moved to a common location so that RISC-V or any other
architecture can leverage that.

The relevant discussion regarding unifying cpu topology can be
found in [1].

arch_topology seems to be a perfect place to move the common
code. I have not introduced any functional changes in the moved
to code. The only downside in this approach is that the capacity
code will be executed for RISC-V as well. But, it will exit
immediately after not able to find the appropriate DT node. If
the overhead is considered too much, we can always compile out
capacity related functions under a different config for the
architectures that do not support them.

The patches have been tested for RISC-V and compile tested for
ARM64.

The socket changes[2] can be merged on top of this series or vice
versa.

[1] https://lkml.org/lkml/2018/11/6/19
[2] https://lkml.org/lkml/2018/11/7/918

Atish Patra (3):
  dt-binding: cpu-topology: Move cpu-map to a common binding.
  cpu-topology: Move cpu topology code to common code.
  RISC-V: Parse cpu topology during boot.

 Documentation/devicetree/bindings/arm/topology.txt | 475 -------------------
 .../devicetree/bindings/cpu/cpu-topology.txt       | 526 +++++++++++++++++++++
 arch/arm64/include/asm/topology.h                  |  23 +-
 arch/arm64/kernel/topology.c                       | 305 +-----------
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/kernel/smpboot.c                        |   6 +-
 drivers/base/arch_topology.c                       | 303 ++++++++++++
 include/linux/arch_topology.h                      |  23 +
 include/linux/topology.h                           |   1 +
 9 files changed, 864 insertions(+), 799 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/topology.txt
 create mode 100644 Documentation/devicetree/bindings/cpu/cpu-topology.txt

-- 
2.7.4
