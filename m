From: matt@console-pimps.org (Matt Fleming)
Date: Mon, 23 Aug 2010 11:46:18 +0100
Subject: [PATCH 0/3] Generalise ARM perf-events backend for oprofile
Message-ID: <1282560381-7700-1-git-send-email-matt@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The perf-events backend for OProfile that Will Deacon wrote in
8c1fc96f6fd1f361428ba805103af0d0eee65179 ("ARM: 6072/1: oprofile: use
perf-events framework as backend") is of use to more architectures
than just ARM. Move the code into drivers/oprofile/ so that SH can use
it instead of the nearly identical copy of its OProfile code.

The benefit of the backend is that it becomes necessary to only
maintain one copy of the PMU accessor functions for each architecture,
with bug fixes and new features benefiting both OProfile and perf.

Note that I haven't been able to test these patches on an ARM board to
see if I've caused any regressions. If anyone else could do that I'd
appreciate it.

This patch series is based on tip/master.

Matt Fleming (3):
  sh: Accessor functions for the sh_pmu state
  oprofile: Abstract the perf-events backend for oprofile
  sh: Use the perf-events backend for oprofile

 arch/arm/oprofile/Makefile       |    4 +
 arch/arm/oprofile/common.c       |  176 +-----------------------------------
 arch/sh/include/asm/perf_event.h |    2 +
 arch/sh/kernel/perf_event.c      |   13 +++
 arch/sh/oprofile/Makefile        |    4 +
 arch/sh/oprofile/common.c        |   95 +++----------------
 arch/sh/oprofile/op_impl.h       |   33 -------
 drivers/oprofile/oprofile_perf.c |  188 ++++++++++++++++++++++++++++++++++++++
 include/linux/oprofile.h         |   12 +++
 9 files changed, 240 insertions(+), 287 deletions(-)
 delete mode 100644 arch/sh/oprofile/op_impl.h
 create mode 100644 drivers/oprofile/oprofile_perf.c

-- 
1.7.2.1
