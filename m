From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed,  7 Jan 2015 16:16:43 +0000
Subject: [PATCH 0/2] Support deprecated SETEND instruction for AArch32
Message-ID: <1420647405-3907-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This series add support for controlling the 'setend' instruction,
which is deprecated in ARMv8, using the legacy instruction emulation
framework, introduced by Punit Agrawal.

Patch 1 re-organises the infrastructure a little bit to avoid multiple
CPU hotplug notifiers.

Patch 2 adds the support for SETEND.

Testing :

 $ cat setend_sig.c 
 #include <stdio.h>
 #include <signal.h>

 #define setend_be(a)	asm __volatile__ ( "setend be" ::: "memory" )
 #define setend_le(a)	asm __volatile__ ( "setend le" ::: "memory" )

 volatile int flag = 1;

 void sigint(int sig)
 {
	printf("in sighandler %d\n", sig);
	flag = 0;
	return;
 }

 main()
 {
	volatile int a = 0x0;

	(void)signal(SIGINT, sigint);
	printf("Press Ctrl+C to continue\n");
	setend_be();
	a ++;

	while (flag);

	setend_le();
	a ++;

	printf("a: 0x%x\n", a);
	return 0;
 }
 $ cat /proc/sys/abi/setend 
 1
 $ echo 1 > /sys/kernel/debug/tracing/events/emulation/instruction_emulation/enable 
 $ echo 1 > /sys/kernel/debug/tracing/tracing_on 
 $ ./setend_sig_a32 
 Press Ctrl+C to continue
 ^Cin sighandler 2
 a: 0x1000001
 $ cat /sys/kernel/debug/tracing/trace
 # tracer: nop
 #
 # entries-in-buffer/entries-written: 2/2   #P:2
 #
 #                              _-----=> irqs-off
 #                             / _----=> need-resched
 #                            | / _---=> hardirq/softirq
 #                            || / _--=> preempt-depth
 #                            ||| /     delay
 #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
 #              | |       |   ||||       |         |
   setend_sig_a32-1373  [000] ...1   491.554499: instruction_emulation: instr="setend be" addr=0x8460
   setend_sig_a32-1373  [000] ...1   492.833056: instruction_emulation: instr="setend le" addr=0x8488
 $ dmesg | tail
 [  491.554807] "setend_sig_a32" (1373) uses deprecated setend instruction at 0x8460
 [  492.833285] "setend_sig_a32" (1373) uses deprecated setend instruction at 0x8488
 $ echo 2 > /proc/sys/abi/setend
 $ ./setend_sig_t16 
 Press Ctrl+C to continue
 ^Cin sighandler 2
 a: 0x1000001
 $ dmesg | tail
 [  491.554807] "setend_sig_a32" (1373) uses deprecated setend instruction at 0x8460
 [  492.833285] "setend_sig_a32" (1373) uses deprecated setend instruction at 0x8488
 [  537.426216] Removed setend emulation handler
 [  537.426624] Enabled setend support
 ---

Suzuki K. Poulose (2):
  arm64: Consolidate hotplug notifier for instruction emulation
  arm64: Emulate SETEND for AArch32 tasks

 Documentation/arm64/legacy_instructions.txt |    5 +
 arch/arm64/Kconfig                          |   10 ++
 arch/arm64/include/asm/ptrace.h             |    7 ++
 arch/arm64/kernel/armv8_deprecated.c        |  174 +++++++++++++++++++--------
 arch/arm64/kernel/signal32.c                |    5 +-
 5 files changed, 151 insertions(+), 50 deletions(-)

-- 
1.7.9.5
