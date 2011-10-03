From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  3 Oct 2011 18:04:02 +0100
Subject: [PATCH v4 0/4] genirq: handling GIC per-cpu interrupts
Message-ID: <1317661446-2876-1-git-send-email-marc.zyngier@arm.com>
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

Tested on ARM Versatile Express (Cortex A15), ARM RealView PB11MP,
OMAP4 (Panda) and Tegra (Harmony). Patch series against next-20110930.

The two first patches can also be found in Thomas' tree:

	git://tesla.tglx.de/git/linux-2.6-tip irq/core

Changelog:
