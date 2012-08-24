From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Aug 2012 15:52:54 +0100
Subject: [PATCH v3 0/2] arch_timers patches to enable KVM support
Message-ID: <1345819976-6339-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is aimed at offering the minimum level of support that KVM
needs when it comes to architected timers.

The first patch changes the driver to use the virtual timer by default
instead of the physical one (access to the later is conditioned by the
hypervisor settings, while the former is always available). This could
be required even if the kernel is not running as a guest.

The second patch exposes a clockcycle counter that can be used by
other subsystems.

Tested on A15 (VE+TC2), both as a host and a KVM guest. Patches
against v3.6-rc3.

* From v2:
- Trick the compiler into generating really nice code, at the expense
  of a certain lack of abstraction
- Don't mandate physical timer non-secure PPI, in order to stay
  compatible with existing and possibly incomplete DTs.
  
Marc Zyngier (2):
  ARM: arch_timers: enable the use of the virtual timer
  ARM: arch_timers: register a time/cycle counter

 arch/arm/include/asm/arch_timer.h |   7 +
 arch/arm/kernel/arch_timer.c      | 362 +++++++++++++++++++++++++++-----------
 2 files changed, 265 insertions(+), 104 deletions(-)

-- 
1.7.11.4
