From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Fri, 20 Dec 2013 08:48:40 -0800
Subject: [PATCH REPOST 0/5] armv7 BE kvm support
Message-ID: <1387558125-3460-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[repost: adding kvmarm mailing list as per Christoffer's request]

Hi Guys,

Here is series that enables KVM support for V7 big endian kernels. Mostly
it deals with BE KVM host support. Marc Zyngier showed before with his patches
how BE guest could run on top LE host. With these patches BE guest runs on 
top of BE host. If Marc's kvmtool is used with few additional changes I tested
that BE host could run LE guest. Also I verified that there were no 
regressions in BE guest on top of LE host case.

Note that posted series covers only kernel side changes. The changes were
tested inside of bigger setup with additional changes in qemu and kvmtool.
I will post those changes separately in proper aliases but for completeness 
sake Appendix A gives pointers to git repositories and branches with all
needed changes.

Please note first patch is not related to BE KVM per se. I've run
into an issue of conflicting 'push' identifier use while trying to include 
assembler.h into KVM .S files. Details of an issue I observed covered in
Appendix B. The first patch is my take on solving it.

Victor Kamensky (5):
  ARM: kvm: replace push and pop with stdmb and ldmia instrs to enable
    assembler.h inclusion
  ARM: fix KVM assembler files to work in BE case
  ARM: kvm one_reg coproc set and get BE fixes
  ARM: kvm vgic mmio should return data in BE format in BE case
  ARM: kvm MMIO support BE host running LE code

 arch/arm/include/asm/assembler.h   |  7 +++
 arch/arm/include/asm/kvm_asm.h     |  4 +-
 arch/arm/include/asm/kvm_emulate.h | 22 +++++++--
 arch/arm/kvm/coproc.c              | 94 ++++++++++++++++++++++++++++----------
 arch/arm/kvm/init.S                |  7 ++-
 arch/arm/kvm/interrupts.S          | 50 +++++++++++---------
 arch/arm/kvm/interrupts_head.S     | 61 +++++++++++++++----------
 virt/kvm/arm/vgic.c                |  4 +-
 8 files changed, 168 insertions(+), 81 deletions(-)

-- 
1.8.1.4

Thanks,
Victor

      Appendix A: Testing and Full Setup Description
      ----------------------------------------------

I) No mixed mode setup - i.e BE guest on BE host; and LE guest
on LE host tested to make sure no regressions.

KVM host and guest kernels:
  TC2 on top of Linus 3.13-rc4 (this patch series):
      git: git://git.linaro.org/people/victor.kamensky/linux-linaro-tracking-be.git
      branch: armv7be-kvm-3.13-rc4
      
  TC2 and Arndale on top of Linaro BE tree:
      git: git://git.linaro.org/people/victor.kamensky/linux-linaro-tracking-be.git
      branch: llct-be-20131216-kvm

- TC1 kernels used as guests

qemu:
      git: git://git.linaro.org/people/victor.kamensky/qemu-be.git 
      branch: armv7be-v1
      description: changes to run qemu on armeb target; and other
      changes to work with be image on top of be host

kvmtool:
      git: git://git.linaro.org/people/victor.kamensky/linux-linaro-tracking-be.git
      branch: kvmtool-armv7be-v1
      desciption: minimal changes to build kvmtool for armeb target; and
      tiny change with virtio magic

II) Mixed mode setup all possible combinations within V7 (LE guest on BE host;
BE guest on LE host as Marc's setup tested to make sure no regressions) only
with kvmtool.

This work is based on Marc Zyngier's work that made BE guest to run on top
of LE host. For this setup special version of kvmtool should be used and
in addition I had to apply patch to guest kernel that would switch reading
virtio configs reads to be LE only, that is made on top of previous Rusty
Russell's changes. Effectively I just had to do very minor addition to make
LE guest to work on BE host, most of heavy lifting was done before by Marc.

KVM host kernels: as in previous setup

Guest TC1 kernels with LE virtio config patch:
      git: git://git.linaro.org/people/victor.kamensky/linux-linaro-tracking-be.git
      branch: virtio-leconfig-3.13-rc4

kvmtool:
      git: git://git.linaro.org/people/victor.kamensky/linux-linaro-tracking-be.git
      branch: kvmtool-mixed-v1
      description: based on git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
      branch kvm-arm64/kvmtool-be-on-le; adds missing include fix; above armeb target
      build patches; and one fix related to BE mode

qemu:
      git: git://git.linaro.org/people/victor.kamensky/qemu-be.git
      branch: armv7be-leconfig-v1
      description: change virtio-blk that so qemu could work with guest image
      where virtio leconfig is made; note it does not work in mixed mode; to do
      so qemu would need bunch of similar changes that Marc did in kvmtool


      Appendix B: kvm asm file and asm/assembler.h file issue
      -------------------------------------------------------

diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index ddc1553..5d3b511 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -25,6 +25,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_arm.h>
 #include <asm/vfpmacros.h>
+#include <asm/assembler.h>
 #include "interrupts_head.S"
 
        .text

produce the following compilation errors:

/run/media/kamensky/wd/linaro/linux-linaro-core-tracking/092913/linux-linaro-tracking-be/arch/arm/kvm/interrupts.S: Assembler messages:
/run/media/kamensky/wd/linaro/linux-linaro-core-tracking/092913/linux-linaro-tracking-be/arch/arm/kvm/interrupts.S:51: Error: ARM register expected -- `lsr {r2,r3}'
/run/media/kamensky/wd/linaro/linux-linaro-core-tracking/092913/linux-linaro-tracking-be/arch/arm/kvm/interrupts.S:100: Error: ARM register expected -- `lsr {r2}'
/run/media/kamensky/wd/linaro/linux-linaro-core-tracking/092913/linux-linaro-tracking-be/arch/arm/kvm/interrupts.S:100: Error: ARM register expected -- `lsr {r4-r12}'
