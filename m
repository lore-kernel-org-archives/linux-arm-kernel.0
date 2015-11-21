From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Nov 2015 17:23:14 -0800
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
Message-ID: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a respin of a patch series from about a year ago[1]. I realized
that we already had most of the code in recordmcount to figure out
where we make calls to particular functions, so recording where
we make calls to the integer division functions should be easy enough
to add support for in the same codepaths. Looking back on the thread
it seems like Mans was thinking along the same lines, although it wasn't
obvious to me back then or even over the last few days when I wrote this.

This series extends recordmcount to record the locations of the calls
to the library functions on ARM builds, and puts those locations into a
table that we use to patch instructions at boot. The first two patches
are the recordmcount changes, while the last patch implements the runtime
patching for modules and kernel code. The module part also hooks into the
relocation patching code we already have.

The RFC tag is because I'm thinking of splitting the recordmcount changes
into a new program based on recordmcount so that we don't drag in a lot
of corner cases and stuff when we don't need to. I suspect it will be
cleaner that way too. Does anyone prefer one way or the other?

Comments/feedback appreciated.

[1] http://lkml.kernel.org/r/1383951632-6090-1-git-send-email-sboyd at codeaurora.org

Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: M?ns Rullg?rd <mans@mansr.com>

Stephen Boyd (3):
  scripts: Allow recordmcount to be used without tracing enabled
  recordmcount: Record locations of __aeabi_{u}idiv() calls on ARM
  ARM: Replace calls to __aeabi_{u}idiv with udiv/sdiv instructions

 Makefile                      |   7 +
 arch/arm/Kconfig              |  14 ++
 arch/arm/kernel/module.c      |  44 ++++++
 arch/arm/kernel/setup.c       |  34 +++++
 arch/arm/kernel/vmlinux.lds.S |  13 ++
 kernel/trace/Kconfig          |   4 +
 scripts/Makefile.build        |  15 +-
 scripts/recordmcount.c        |  10 +-
 scripts/recordmcount.h        | 337 +++++++++++++++++++++++++++++++++---------
 scripts/recordmcount.pl       |  11 +-
 10 files changed, 406 insertions(+), 83 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
