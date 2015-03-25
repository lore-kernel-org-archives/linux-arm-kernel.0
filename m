From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 25 Mar 2015 18:22:26 +0000
Subject: =?UTF-8?q?=5BPATCH=20v3=200/*=5D=20serial/amba-pl011=3A=20Activate=20TX=20IRQ=20passively?=
Message-ID: <1427307746-2811-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks to Jakub Kici?ski for his bug report and discussion, and for
showing out how we can manage without the softirq (and providing a
patch, though merging my rework with it got difficult, so I don't
include it in the series now).


There are two alternate versions of the series threaded from this cover
letter:

 * [PATCH v3] - patch against v4.0-rc5 that supersedes the previous
        series; this is the less churny option.

 * [PATCH v3, tty-next..] - patches against tty-next that
        modify/partially revert the previous series without needing a
        rebase.

Take your pick.


Changes since v2:

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


Original cover letter:

The current PL011 driver transmits a dummy character when the UART
is opened, to assert the TX IRQ for the first time
(see pl011_startup()).  The UART is put in loopback mode temporarily,
so the receiver presumably shouldn't see anything.

However...

At least some platforms containing a PL011 send characters down the
wire even when loopback mode is enabled.  This means that a
spurious NUL character may be seen at the receiver when the PL011 is
opened through the TTY layer.

The current code also temporarily sets the baud rate to maximum and
the character width to the minimum, to that the dummy TX completes
as quickly as possible.  If this is seen by the receiver it will
result in a framing error and can knock the receiver out of sync --
turning subsequent output into garbage until synchronisation
is reestablished.  (Particularly problematic during boot with systemd.)

To avoid spurious transmissions, this patch removes assumptions about
whether the TX IRQ will fire until at least one TX IRQ has been seen.

Instead, the UART will unmask the TX IRQ and then slow-start via
polling and timer-based soft IRQs initially.  If the TTY layer writes
enough data to fill the FIFO to the interrupt threshold in one go,
the TX IRQ should assert, at which point the driver changes to
fully interrupt-driven TX.

In this way, the TX IRQ is activated as a side-effect instead of
being done deliberately.

This should also mean that the driver works on the SBSA Generic
UART[1] (a cut-down PL011) without invasive changes.  The Generic
UART lacks some features needed for the dummy TX approach to work
(FIFO disabling and loopback).

[1] Server Base System Architecture (ARM-DEN-0029-v2.3)
    http://infocenter.arm.com/
    (click-thru required :/)

-- 
1.7.10.4
