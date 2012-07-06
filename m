From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Jul 2012 10:20:18 +0100
Subject: [RFC PATCH 0/4] arch_timers patches to enable KVM support
Message-ID: <1341566422-20368-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is aimed at offering the minimum level of support that KVM
needs when it comes to architected timers.

The first patch shouldn't be controvertial, as it changes the driver
to use the virtual timer instead of the physical one (access to the
latest is conditioned by the hypervisor settings, while the former is
always available). It is actually required if the kernel is run as a
guest. The next two are basic infrastructure additions.

The last one is really the cause of the RFC tag. It allows the kernel
to switch from using the virtual timer to the physical one - KVM needs
this to allow guests to use the virtual timer, and because it runs in
PL2, it allows the kernel to use the physical timer. This allows the
same kernel to be used both as a host or guest kernel.

The ugly part of this patch is that that KVM needs to handle the
virtual timer interrupt itself, and this patch adds some sort of
interrupt offloading. Frankly, I hate it, but I'm posting it so people
can show they have better ideas than I do... ;-)

Patches based on v3.5-rc5.

Marc Zyngier (4):
  ARM: arch_timers: enable the use of the virtual timer
  ARM: arch_timers: register a time/cycle counter
  ARM: arch_timers: give the virtual timer its own interrupt handler
  ARM: arch_timers: dynamic switch to physical timer and virtual timer
    offloading

 arch/arm/include/asm/arch_timer.h |   14 ++
 arch/arm/kernel/arch_timer.c      |  330 ++++++++++++++++++++++++++++++-------
 2 files changed, 284 insertions(+), 60 deletions(-)

-- 
1.7.10.3
