From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Apr 2015 10:44:38 +0100
Subject: [PATCH 0/7] Fix Keystone 2 physical address switch
Message-ID: <20150408094438.GM12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some time, the Keystone 2 physical address switch has been
tainting the kernel ever since we decided that it was not safe.

This series re-works the address switch to be compliant architecturally.

There's still a niggle in the keystone2 code, where we set the
arch_virt_to_idmap function pointer in keystone_pv_fixup() - something
I'd ideally like to avoid.

I'm in two minds about how much of this code should be in SoC specific
code, and how much should be in generic code - on one hand, I don't
want to give a green light to this kind of sillyness by encouraging
it, but I'd rather not end up with multiple implementations of this.

 arch/arm/include/asm/mach/arch.h  |   2 +-
 arch/arm/kernel/setup.c           |   7 +-
 arch/arm/mach-keystone/keystone.c |  41 +++++------
 arch/arm/mm/Kconfig               |   4 ++
 arch/arm/mm/Makefile              |   1 +
 arch/arm/mm/mmu.c                 | 148 +++++++++++++++-----------------------
 arch/arm/mm/nommu.c               |   9 ---
 arch/arm/mm/pv-fixup-asm.S        |  88 +++++++++++++++++++++++
 8 files changed, 174 insertions(+), 126 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
