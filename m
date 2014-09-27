From: j.uzycki@elproma.com.pl (Janusz Uzycki)
Date: Sat, 27 Sep 2014 11:46:33 +0200
Subject: [PATCH v3] serial: mxs-auart: gpios as modem signals (dirty)
Message-ID: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patchset
"Re: [PATCH 1/4] serial: mxs-auart: use mctrl_gpio helpers for handling modem signals (v2.2c)"
is changed and resent here.

Please comment.

v3 changelog:
* own patches reordered to apply mainline
* outsize of the patchset as independent:
   serial: mxs-auart: add sysrq support

new [PATCH 1/4] serial: mxs-auart: ctrl removed from mxs_auart_port
* the ctrl variable duplicated mctrl, member of uart_port structure
  in serial_core.h
* the code duplicated uart_update_mctrl() and uart_tiocmget()
  in serial_core.c
* mxs_auart_get_mctrl() reads back RTS line. It could be removed too
  but not sure.

[PATCH 2/4] serial: mxs-auart: use mctrl_gpio helpers for handling
 modem signals
* mctrl_gpio_free() removed to simplify:
  mctrl_gpio_free() is not necessary in mxs_auart_probe() and
  mxs_auart_remove() because mctrl_gpio_init() does all
  allocations with devm_* functions.
  (see Documentation/serial/driver since kernel 3.16)
* DMA on HW flow control comment updated, still not sure about the comment
* mxs_auart_modem_status() removed from mxs_auart_get_mctrl():
  mctrl_gpio_get() does not clear gpio interrupt pendings like
  8250_core.c does with MSR.
* mxs_auart_modem_status() moved to [3/4]
  If enable_ms() is not called, uart_handle_cts_change()
  shouldn't be called.

[PATCH 3/4] serial: mxs-auart: add interrupts for modem control lines
* introduces mctrl_prev instead of removed ctrl
* mxs_auart_modem_status() moved from [3/4]
* mxs_auart_modem_status() interrupt_enabled meant s->ms_irq_enabled

[PATCH 4/4] serial: mxs-auart: enable PPS support
* no changes

 .../devicetree/bindings/serial/fsl-mxs-auart.txt   |  10 +-
 drivers/tty/serial/Kconfig                         |   1 +
 drivers/tty/serial/mxs-auart.c                     | 222 ++++++++++++++++++++-
 3 files changed, 224 insertions(+), 9 deletions(-)
