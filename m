From: simon.marchi@ericsson.com (Simon Marchi)
Date: Mon, 30 May 2016 13:48:11 -0400
Subject: Possible race between PTRACE_SETVFPREGS and PTRACE_CONT on ARM?
Message-ID: <574C7CDB.7050103@ericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello knowledgeable ARM people!

(Background: https://sourceware.org/ml/gdb/2016-05/msg00020.html )

Debugging a flaky GDB test case on ARM lead me to think there might
be race between PTRACE_SETVFPREGS and PTRACE_CONT on ARM
(PTRACE_SETVFPREGS is ARM-specific anyway).  The test case (and the
reproducer below) changes the value of a VFP register (let's say d0)
using PTRACE_SETVFPREGS and resumes the thread with PTRACE_CONT.  It
happens intermittently that the thread resumes execution with the
old value in d0 instead of the new one.

Here is a minimal reproducing example.

test.S:

  .global _start
  _start:
      vldr.64 d0, constant
      vldr.64 d1, constant

  break_here:
      vcmp.f64 d0, d1
      vmrs APSR_nzcv, fpscr

      # Exit code
      moveq r0, #1
      movne r0, #0

      # Exit syscall
      mov r7, #1
      svc 0

  .align 8
  constant:
  .word 0xc8b43958
  .word 0x40594676

Built with:

  $ gcc -g3 -O0 -o test test.S -nostdlib

And the gdb script, test.gdb:

  file test
  b break_here
  run
  p $d0 = 4.0
  c

The test is ran with

  $ ./gdb -nx -x test.gdb -batch

The test loads the same constant in d0 and d1.  It then does a comparison between
them and exits with 1 (failure) if they are the same, 0 (success) if they are different.
The GDB script breaks at "break_here", tries to change the value of d0 to some other
constant (4.0) and lets the program continue and exit.  If our register write succeeded,
the program should exit with 0 (values are different).  If our register write failed, the
program will exit with 1 (values are still the same).

The result is that I randomly see both cases, hinting to a race between the register write
and the time where the kernel restores the thread's vfp registers.  Note that when GDB's
affinity is pinned to a single core, I do not see the failure.  Also, note that when I
remove the vldr.64 instructions, I can't seem to reproduce the problem, so it looks
like they are somehow important.

I see this behavior on 3 different boards:

- ODroid XU-4, kernel 3.10.96
- Firefly RK3288, kernel 3.10.0
- Raspberry Pi 2, kernel 4.4.8

Any ideas about this problem?

Thanks,

Simon
