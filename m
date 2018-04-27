From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 27 Apr 2018 11:05:44 +0100
Subject: [PATCH] tty: pl011: Avoid spuriously stuck-off interrupts
Message-ID: <1524823545-11309-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an update to a previous RFC [1], to fix a problem observed by
the qemu community that causes serial input to hang when booting a
simulated system with data already queued in the UART FIFO [2].

This patch could cause problems for people that are actually relying
on chars queued in the PL011 RX FIFO during boot or while the UART is
closed.  There are no guarantees about such things working in general.
In either case, there is no protection against RX FIFO overflow or
reprogramming of the UART parameters while Linux is not actively
receiving chars.

Cheers
---Dave

[1] [RFC PATCH v4] tty: pl011: Avoid spuriously stuck-off interrupts
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/574033.html

[2] [Qemu-devel] [Qemu-arm] [PATCH] pl011: do not put into fifo
before enabled the interruption
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06446.html

Dave Martin (1):
  tty: pl011: Avoid spuriously stuck-off interrupts

 drivers/tty/serial/amba-pl011.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.1.4
