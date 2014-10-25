From: wangnan0@huawei.com (Wang Nan)
Date: Sat, 25 Oct 2014 14:42:49 +0800
Subject: [PATCH 0/4] ARM: kprobes: introduces instruction checker.
Message-ID: <1414219373-20070-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is part of the version 7 of patch 'ARM: kprobes:
enable OPTPROBES for ARM 32.'. Its main goal is introducing checker
mechanism to give a chance to detail check each probed instructions.
Based on Masami Hiramatsu's suggestion, I make it a dedicated series.

Previous discussions can be found in following threads:

https://lkml.org/lkml/2014/10/22/254
https://lkml.org/lkml/2014/8/27/255
https://lkml.org/lkml/2014/8/12/12
https://lkml.org/lkml/2014/8/8/992
https://lkml.org/lkml/2014/8/8/5
https://lkml.org/lkml/2014/8/5/63

Different from v6, this version redesign checker to make it use seprate
tables other than K/Uprobe action tables, because checkers are not
K/Uprobt specific.

Patch 4/4 in this series also fix a minor bug in kprobe: original ARM
kprobe allows probing on instructions like 'str r0, [sp, r1]', which is
unsafe because we are unable to determine the stack space required to be
protected.  However, this bug exists since 2007, and gcc for ARM
actually doesn't generate code like it.

Wang Nan (4):
  ARM: kprobes: seprates load and store actions
  ARM: kprobes: introduces checker
  ARM: kprobes: collects stack consumption for store instructions
  ARM: kprobes: disallow probing stack consuming instructions

 arch/arm/include/asm/probes.h        |   1 +
 arch/arm/kernel/kprobes-arm.c        |   6 +-
 arch/arm/kernel/kprobes-test-arm.c   |  17 ++--
 arch/arm/kernel/kprobes-test-thumb.c |  13 +++
 arch/arm/kernel/kprobes-thumb.c      |  18 ++--
 arch/arm/kernel/kprobes.c            |  23 ++++-
 arch/arm/kernel/kprobes.h            |   3 +-
 arch/arm/kernel/probes-arm.c         |  41 +++++++--
 arch/arm/kernel/probes-arm.h         |  10 ++-
 arch/arm/kernel/probes-thumb.c       | 168 ++++++++++++++++++++++++++++++-----
 arch/arm/kernel/probes-thumb.h       |  26 ++++--
 arch/arm/kernel/probes.c             | 115 +++++++++++++++++++++++-
 arch/arm/kernel/probes.h             |  24 ++++-
 arch/arm/kernel/uprobes-arm.c        |   6 +-
 arch/arm/kernel/uprobes.c            |   2 +-
 15 files changed, 412 insertions(+), 61 deletions(-)

-- 
1.8.4
