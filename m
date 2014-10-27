From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 27 Oct 2014 16:32:32 +0100
Subject: [PATCHv2 0/3] ARM: mvebu: disable I/O coherency on !SMP
Message-ID: <1414423955-5933-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The hardware I/O coherency feature of Marvell SoC relies on a number
of assumptions that are true only on SMP systems (shareable pages
being used, and cache policy set to write allocate). Making those
assumptions valid for non-SMP systems is challenging, and while the
discussion about solving those challenges is going, many users are
provided with a kernel on which we know the I/O coherency cannot
work. This is especially true for Armada 370 users, as it is a single
core CPU, and therefore, the required assumptions are always false,
even when CONFIG_SMP=y.

This patch series was already proposed in July, but the discussion
about the series itself never took place. Instead, it deviated towards
solving the complex challenge of making the various required
assumptions true on non-SMP systems.

Therefore, I'm proposing again to merge this series today, so that we
provide users with a known-working situation, and work from there
progressively to maybe re-enable hardware I/O coherency in non-SMP
configurations at a later point.

Changes since v1:

 - Rebased on top of v3.18-rc2.
 - Added some Fixes:/Cc: tags on the last patch to get it merged into
   the stable tree, as it fixes a real DT reference count leak.

Thomas Petazzoni (3):
  ARM: mvebu: make the coherency_ll.S functions work with no coherency
    fabric
  ARM: mvebu: disable I/O coherency on non-SMP situations on Armada
    370/XP
  ARM: mvebu: add missing of_node_put() call in coherency.c

 arch/arm/mach-mvebu/coherency.c    | 39 ++++++++++++++++++++++++--------------
 arch/arm/mach-mvebu/coherency_ll.S | 21 ++++++++++++++++++--
 2 files changed, 44 insertions(+), 16 deletions(-)

-- 
2.0.0
