From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Sat, 5 Dec 2015 20:39:16 -0800
Subject: [PATCH LINUX v4 00/13] tty: xuartps: Fix lock ups
Message-ID: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I picked up all the review tags from Peter and Moritz and addressed
Peter's comments.
Most patches are unchanged but I added the info Peter suggested/provided
to some commit messages.
The patches "tty: xuartps: Move request_irq to after setting up the HW",
"tty: xuartps: Improve sysrq handling" and "tty: xuartps: Remove
'_OFFSET' suffix from #defines" are new, implementing the suggestions
Peter made in the v3 review (https://lkml.org/lkml/2015/11/21/172).
I pretty much rewrote "tty: xuartps: Refactor IRQ handling" (was: "tty:
xuartps: Only handle RX IRQs when RX is enabled"). Instead of adding a
flag, we now disable/enable the RX interrupts together with the
receiver. That should prevent the RX lock ups I saw.

	Thanks,
	S?ren

S?ren Brinkmann (13):
  tty: xuartps: Beautify read-modify writes
  tty: xuartps: Use spinlock to serialize HW access
  tty: xuartps: Don't consider circular buffer when enabling transmitter
  tty: xuartps: Clear interrupt status register in shutdown
  tty: xuartps: Improve startup function
  tty: xuartps: Move request_irq to after setting up the HW
  tty: xuartps: Keep lock for whole ISR
  tty: xuartps: Acquire port lock for shutdown
  tty: xuartps: Move RX path into helper function
  tty: xuartps: Refactor IRQ handling
  tty: xuartps: Cleanup: Reformat if-else
  tty: xuartps: Improve sysrq handling
  tty: xuartps: Remove '_OFFSET' suffix from #defines

 drivers/tty/serial/xilinx_uartps.c | 451 ++++++++++++++++++-------------------
 1 file changed, 224 insertions(+), 227 deletions(-)

-- 
2.6.3.3.g9bb996a
