From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 27 Apr 2015 16:49:03 +0100
Subject: [PATCH v4 REPOST 0/2] serial/amba-pl011: Refactor and simplify TX
 FIFO handling
Message-ID: <1430149745-27195-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Repost against v4.1-rc1.

This fixes a couple of known bugs.

 * The "Leave the TX IRQ alone when the UART is open" optimisation
   turned out to be a source of bugs because serial_core does shut down
   the UART with the FIFO still non-empty in certain situations -- this
   series simply reverts that patch.

 * The sortirq based mechanism was complex and still suffered from some
   race conditions which could lead to misbehaviour.  This series
   simplifies the mechanism to resolve these races.


No material changes from v2-v4.
Changes since v2 (= what is in -rc1):

 * Remove the optimisation that assumes TXIS stays asserted across port
   shutdown..startup (thanks to Jakub Kici?ski for spotting this on
   raspberrypi-2).  This turns out to be untrue in certain situations,
   namely when the only process with the port open is killed by a
   signal.  This may indicate a bug in serial_core, but the "correct"
   behaviour for this case is not completely obvious.

   For this repost, I just revert the optimisation so that the pl011
   driver doesn't hang in this situation.  It didn't bring much real
   benefit in any case.

 * Remove the tx softirq and rework the code for more intelligible
   code flow.

 * pl011_start_tx() now simply stuffs the FIFO until it's full (in which
   case the TX IRQ will definitely fire), or until the serial_core
   circular buffer is empty (in which case we don't care about the
   interrupt because there is nothing more to send).

Dave Martin (2):
  Revert "serial/amba-pl011: Leave the TX IRQ alone when the UART is
    not open"
  serial/amba-pl011: Refactor and simplify TX FIFO handling

 drivers/tty/serial/amba-pl011.c |  118 +++++++++------------------------------
 1 file changed, 27 insertions(+), 91 deletions(-)

-- 
1.7.10.4
