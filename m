From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  9 Aug 2011 10:56:38 +0100
Subject: [PATCH v11 0/4] Consolidating GIC per-cpu interrupts
Message-ID: <1312883802-15022-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
problems:

- They use a completely separate scheme to handle the interrupts,
  mostly because the PPI concept doesn't really match the kernel view
  of an interrupt.
- PPIs can only be used by the timer code, unless we add more low-level
  assembly code.
- The local timer code can only be used by devices generating PPIs,
  and not SPIs.
- At least one platform (msm) has started implementing its own
  alternative scheme.
- Some low-level code gets duplicated, as usual...

As the previous solution which tried to map PPIs to normal interrupts
has been proved to be buggy, I've opted to a much simpler scheme
(based on Russell's input).

The proposed solution is to handle the interrupt using the same path
as SPIs, with a common handler for all PPIs. Each PPI can be requested
using gic_request_ppi(), similar to request_irq(). The local timer
code is updated to reflect these changes.

Patches against v3.1-rc1 + Will Deacon's TWD patch ("ARM: twd:
register clockevents device before enabling PPI"). Tested on PB11MP,
VE, OMAP4 (Panda) and Tegra (Harmony). As this patch series is quite
different from the previous one, I've dropped all previous acks from
platform maintainers.
