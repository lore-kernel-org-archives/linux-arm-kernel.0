From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 May 2011 11:33:05 +0100
Subject: [RFC PATCH v2 00/12] Consolidating GIC per-cpu interrupts
Message-ID: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current GIC per-cpu interrupt (aka PPIs) suffers from a number of
problems:

- It uses a completely separate scheme to handle the interrupts,
  mostly because the PPI concept doesn't really match the kernel view
  of an interrupt.
- Some low-level code gets duplicated, as usual...
- At least one platform (msm) has started implementing its own
  alternative scheme.

The proposed solution is to let the GIC code expose the PPIs as
something that the kernel can manage. Instead of having a single
interrupt number shared on all cores, make the interrupt number be
different on each CPU.

This enables the use of the normal kernel API (request_irq() and
friends) and the elimination of some low level code.

This patch set is based on 2.6.39-rc6, and depends on Will Deacon's
GIC fasteoi patches. Tested on VExpress, PB-11MP, Pandaboard and
SMDK-S5PV310.
