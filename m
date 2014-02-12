From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 11 Feb 2014 21:41:26 -0800
Subject: [PATCH v2 0/7] armv7 BE kvm support
Message-ID: <1392183693-21238-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

Here is second version of series that enables KVM support for V7 big endian
kernels. Mostly it deals with BE KVM host support. Marc Zyngier showed before 
with his patches how BE guest could run on top LE host. With these patches
BE guest runs on top of BE host. If Marc's kvmtool is used with few
additional changes I tested that BE host could run LE guest. Also I verified
that there were no regressions in BE guest on top of LE host case.

Note that posted series covers only kernel side changes. The changes were
tested inside of bigger setup with additional changes in qemu and kvmtool.
I will post those changes separately in proper aliases but for completeness 
sake Appendix A gives pointers to git repositories and branches with all
needed changes.

Changes since V1:
1) Patch that handles issue of including assembler.h into kvm .S file now
handled separately. It was posted before on mailing list [1]. This series
depend on it.

2) Incorporated most of Christoffer V1 review comments. The only thing 
I did not do wrt Christoffer's suggestion is possible rework of 'one_reg
coproc set and get BE fixes' patch. I think I put better explanation on
what my code does, and if it is still not good we will go from there.

3) Moved rr_lo_hi macro into arch/arm/include/asm/kvm_asm.h along the 
lines Christoffer suggested

4) Split 'fix KVM assembler files to work in BE case' patch into 4 smaller
one each handling one logic issue.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/231432.html

Victor Kamensky (7):
  ARM: KVM: switch hypervisor into BE mode in case of BE host
  ARM: KVM: fix vgic V7 assembler code to work in BE image
  ARM: KVM: handle 64bit values passed to mrcc or from mcrr instructions
    in BE case
  ARM: KVM: __kvm_vcpu_run function return result fix in BE case
  ARM: KVM: one_reg coproc set and get BE fixes
  ARM: KVM: vgic mmio should hold data as LE bytes array in BE case
  ARM: KVM: MMIO support BE host running LE code

 arch/arm/include/asm/kvm_asm.h     | 23 +++++++++-
 arch/arm/include/asm/kvm_emulate.h | 22 +++++++--
 arch/arm/kvm/coproc.c              | 94 ++++++++++++++++++++++++++++----------
 arch/arm/kvm/init.S                |  7 ++-
 arch/arm/kvm/interrupts.S          |  9 +++-
 arch/arm/kvm/interrupts_head.S     | 32 +++++++++----
 virt/kvm/arm/vgic.c                |  4 +-
 7 files changed, 145 insertions(+), 46 deletions(-)

-- 
1.8.1.4

      Appendix A: Testing and Full Setup Description
      ----------------------------------------------

I) No mixed mode setup - i.e BE guest on BE host; and LE guest
on LE host tested to make sure no regressions.

KVM host and guest kernels:
  TC2 on top of Linus 3.13 (this patch series):
      git: git://git.linaro.org/people/victor.kamensky/linux-linaro-tracking-be.git
      branch: arm-be-kvm-3.13
      range: 7098f45..78419d0
      
  TC2 and Arndale on top of Linaro BE tree:
      git: git://git.linaro.org/people/victor.kamensky/linux-linaro-tracking-be.git
      branch: llct-be-20140211-kvm
      range: 308a752..ae47fa8

- TC1 kernels used as guests

qemu:
      git: git://git.linaro.org/people/victor.kamensky/qemu-be.git 
      branch: armv7be-v1
      description: changes to run qemu on armeb target; and other
      changes to work with be image on top of be host

kvmtool:
      git: git://git.linaro.org/people/victor.kamensky/linux-linaro-tracking-be.git
      branch: kvmtool-armv7be-v1
      description: minimal changes to build kvmtool for armeb target; and
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
