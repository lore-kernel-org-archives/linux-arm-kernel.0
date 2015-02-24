From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 24 Feb 2015 18:15:53 +0000
Subject: [PATCH 0/2] Remove pl011 startup glitches and avoid dummy TX during
 startup
Message-ID: <1424801755-16242-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a major rework of a previously-posted patch [1].

This addresses a number of overlapping issues:

 * interaction of the dummy TX in pl011_startup() with hardware that
   doesn't suppress transmission when in loopback mode, causing
   glitches / corruption at the receiver;

 * lack of support for loopback mode in the SBSA Generic UART;

 * issues with the models/simulators that pretend to have an
   unreasonably high baud rate (making it impossible to fill the
   FIFO in some situations).


The general approach in this series is to remove the dummy TX and
start in a timer-based polled IO mode instead.  If and when a TX IRQ
occurs, we switch to interrupt-driven mode for future processing.

If the data written to the UART is a small enough trickle, we may
never using the TX IRQ, but the UART would not stream constantly in
any case unless there is enough data being written to stop the FIFO
ever emptying.


I've kept the second patch separate in case someone can think of a
reason why it might not work...

There is some context overlap with Jorge's probe deferral patch, but
the merge is straightforward.


Tested on ARM Juno and the ARM fast models only for now.

Any review/testing from other folks would be appreciated.

Cheers
Dave


[1] [RFC PATCH] serial: amba-pl011: Kickstart TX by explicit FIFO fill
    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315248.html

Dave Martin (2):
  serial/amba-pl011: Activate TX IRQ passively
  serial/amba-pl011: Leave the TX IRQ alone when the UART is not open

 drivers/tty/serial/amba-pl011.c |  164 +++++++++++++++++++++++++++------------
 1 file changed, 113 insertions(+), 51 deletions(-)

-- 
1.7.10.4
