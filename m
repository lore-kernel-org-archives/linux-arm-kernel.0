From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 16 Sep 2011 14:50:27 +0100
Subject: [RFC PATCH v2 0/3] genirq: handling GIC per-cpu interrupts
Message-ID: <1316181030-5285-1-git-send-email-marc.zyngier@arm.com>
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

The proposed solution is to handle the PPIs using the same path as
SPIs. A new core API is added to deal with per-cpu interrupts in a
less awkward way. The local timer code is updated to reflect these
changes.

The core API changes are based on an initial idea by Thomas Gleixner.

Tested on ARM Versatile Express (Cortex A5 and A15), ARM RealView
PB11MP, OMAP4 (Panda) and Tegra (Harmony). Patch series against
next-20110831.
