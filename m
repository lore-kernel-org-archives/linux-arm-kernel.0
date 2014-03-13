From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Mar 2014 18:15:47 +0000
Subject: [PATCH 0/5] arm: Early IRQ enabling in the Undef user handler
Message-ID: <1394734552-4704-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I've had this series in my repo for a long time with some follow-ups on
the list but without any conclusive ACK or NAK. If there are no
objections, I plan to send it to the patch system.

The only change is rebasing to 3.14-rc6 and adding some Cc for the
crunch bits.

The __und_usr handler accesses the user space to read the opcode of the
faulting instruction. This is currently done with interrupts disabled
but it could potentially cause a data abort of the page table was
modified from another CPU. The data abort with interrupts disabled
triggers a might_sleep() warning in do_page_fault() or, worse, deadlock
on the pte lock when TLB ops broadcasting is enabled (ARM11MPCore or A15
together with workaround for erratum 798181).

Catalin Marinas (5):
  arm: Move asm macro get_thread_info to asm/assembler.h
  arm: Add {inc,dec}_preempt_count asm macros
  arm: Disable preemption in iwmmxt_task_enable()
  arm: Disable preemption in crunch_task_enable()
  arm: Enable IRQs before attempting to read user space in __und_usr

 arch/arm/include/asm/assembler.h   | 42 ++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/entry-armv.S       | 11 ++++++----
 arch/arm/kernel/entry-header.S     | 11 ----------
 arch/arm/kernel/iwmmxt.S           | 15 ++++++++++----
 arch/arm/mach-ep93xx/crunch-bits.S | 13 +++++++++---
 arch/arm/vfp/entry.S               | 28 ++++++++-----------------
 arch/arm/vfp/vfphw.S               | 19 ++++++-----------
 7 files changed, 84 insertions(+), 55 deletions(-)
