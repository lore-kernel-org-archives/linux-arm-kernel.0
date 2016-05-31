From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 May 2016 12:33:00 +0100
Subject: [PATCH 0/3] arm64: Kill ESR_LNX_EXEC
Message-ID: <1464694383-31700-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we (ab)use a reserved bit in ESR_ELx for our own purposes as
ESR_LNX_EXEC, which isn't ideal, especially as we're inconsistent with our
mnemonic usage. This series removes ESR_LNX_EXEC entirely, avoiding (ab)use of
reserved ESR_ELx bits, and makes things a little more consistent.

I've extracted this from my entry-deasm branch [1], and rebased to v4.7-rc1.
I've split the KVM changes as the KVM code is undergoing rapid change these
days, and it should be possible to take those as a subsequent cleanup rather
than forcing a painful merging process.

Thanks,
Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/log/?h=arm64/entry-deasm


Mark Rutland (3):
  arm64: add macro to extract ESR_ELx.EC
  arm64/kvm: use ESR_ELx_EC to extract EC
  arm64: kill ESR_LNX_EXEC

 arch/arm64/include/asm/esr.h         |  1 +
 arch/arm64/include/asm/kvm_emulate.h |  2 +-
 arch/arm64/kernel/entry.S            |  2 +-
 arch/arm64/kernel/traps.c            |  2 +-
 arch/arm64/kvm/handle_exit.c         |  4 ++--
 arch/arm64/kvm/hyp/switch.c          |  2 +-
 arch/arm64/mm/fault.c                | 15 +++++++++------
 7 files changed, 16 insertions(+), 12 deletions(-)

-- 
1.9.1
