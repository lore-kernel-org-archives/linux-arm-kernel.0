From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  2 Jul 2014 18:21:07 +0200
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
Message-ID: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew, Gregory, Sebastian,

I believe you have seen the on-going discussion with Russell on how to
ensure that the relevant requirements for hardware I/O coherency are
meant in non-SMP situations. Since it appears it will take quite a bit
of time to find a proper solution to this problem, this patch series
proposes to simply disable hardware I/O coherency in problematic
configurations.

It has the consequence of completely disabling hardware I/O coherency
on Armada 370 (this processor is single-core, so it is never executed
in a SMP situation, as is_smp() returns false), and it disables
hardware I/O coherency for Armada XP in !CONFIG_SMP
configurations. For Armada 375 and 38x there is no change since they
were already using hardware I/O coherency only in SMP-enabled
situations.

The first patch is a preparation needed to not use the coherency
fabric at all on Armada 370/XP by making some assembly code accept
this situation.

The second patch actually implements the disabling by reworking the
coherency_type() function.

The third patch is a somewhat unrelated fix, just added in this patch
series because it touches the same coherency.c file.

Since the fact of having I/O coherency enabled when it should not can
cause infrequent but real data corruptions, I'd like to see the first
two patches backported all the way up to when I/O coherency support
was added, i.e in v3.8. I'm especially interested in seeing these
patches reach the longterm 3.10 kernel version, which many people are
using on Armada 370 systems today. As mentionned in the patch
comments, the patches will most likely not easily apply on older
kernel versions, but I'll provide the appropriate backports when
requested.

Some independent testing/review of this patch series would definitely
be welcome.

Thanks,

Thomas

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
