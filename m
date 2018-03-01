From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Thu,  1 Mar 2018 17:43:41 +0100
Subject: [PATCH v2 0/2] ARM: Implement MODULE_PLT support in FTRACE
Message-ID: <20180301164343.5794-1-alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FTRACE's function tracer currently doesn't always work on ARM with
MODULE_PLT option enabled. If the module is loaded too far, FTRACE's
code modifier cannot cope with introduced veneers and turns the
function tracer off globally.

ARM64 already has a solution for the problem, refer to the following
patches:

arm64: ftrace: emit ftrace-mod.o contents through code
arm64: module-plts: factor out PLT generation code for ftrace
arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels
arm64: ftrace: fix building without CONFIG_MODULES
arm64: ftrace: add support for far branches to dynamic ftrace
arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()

But the presented ARM variant has just a half of the footprint in terms of
the changed LoCs. It also retains the code validation-before-modification
instead of switching it off.

Changelog:
v2:
* As suggested by Steven Rostedt, refrain from tree-wide API modification,
  save module pointer in dyn ftrace entry struct instead (PowerPC way)

Alexander Sverdlin (2):
  ARM: PLT: Move struct plt_entries definition to header
  ARM: ftrace: Add MODULE_PLTS support

 arch/arm/include/asm/ftrace.h |  1 +
 arch/arm/include/asm/module.h | 10 ++++++++
 arch/arm/kernel/ftrace.c      | 60 ++++++++++++++++++++++++++++++++++++-------
 arch/arm/kernel/module-plts.c | 58 ++++++++++++++++++++++++++---------------
 4 files changed, 100 insertions(+), 29 deletions(-)

-- 
2.4.6
