From: panand@redhat.com (Pratyush Anand)
Date: Tue,  4 Jul 2017 00:40:25 +0530
Subject: [PATCH 0/2] ARM64: Fix irq generation between breakpoint and step
 exception
Message-ID: <cover.1499107909.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

samples/hw_breakpoint/data_breakpoint.c passes with x86_64 but fails with
ARM64. Even though it has been NAKed previously on upstream [1, 2], I have
tried to come up with patches which can resolve it for ARM64 as well.

I noticed that even perf step exception can go into an infinite loop if CPU
receives an interrupt while executing breakpoint/watchpoint handler. So,
event though we are not concerned about above test, we will have to find a
solution for the perf issue.

This patchset attempts to resolve both the issue. Please review.

[1] http://marc.info/?l=linux-arm-kernel&m=149580777524910&w=2
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/425266.html

Pratyush Anand (2):
  arm64: hw_breakpoint: Allow stepping if a kernel mode overflow handler
    exists
  arm64: disable irq between breakpoint and step exception

 arch/arm64/kernel/debug-monitors.c |  3 +++
 arch/arm64/kernel/hw_breakpoint.c  | 13 ++++++++-----
 arch/arm64/mm/fault.c              | 22 ++++++++++++++++++----
 3 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.9.3
