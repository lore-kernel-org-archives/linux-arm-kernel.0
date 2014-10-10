From: j.uzycki@elproma.com.pl (Janusz Uzycki)
Date: Fri, 10 Oct 2014 18:53:23 +0200
Subject: [PATCH v4 0/4] serial: mxs-auart: gpios as modem signals
Message-ID: <1412960007-28159-1-git-send-email-j.uzycki@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It contains improved version of the old v3 patchset
"[PATCH v3] serial: mxs-auart: gpios as modem signals (dirty)"

v3 -> v4 changelog:
[PATCH 1/4] serial: mxs-auart: clean get_mctrl and set_mctrl
* renamed from "serial: mxs-auart: ctrl removed from mxs_auart_port"
* mxs_auart_get_mctrl() read back RTS line. It is removed too.

[PATCH 2/4] serial: mxs-auart: use mctrl_gpio helpers for handling
 modem signals
* RTS_AT_AUART() and CTS_AT_AUART() macro defined
* DMA engine disabled if RTS or CTS is GPIO line
* warn if fsl,uart-has-rtscts and RTS/CTS via GPIO are mixed
* CTSEN can't be enabled for hardware flow control block
  if CTS is defined as GPIO line
* RTSEN can be enabled for hardware flow control block
  even if RTS is defined as GPIO line.
  RTS pin depends on pinctrl configuration which
  selects RTS output from hardware flow control block or GPIO line.
* mxs_auart_settermios(): RTS_AT_AUART() and CTS_AT_AUART() used
* mxs_auart_irq_handle(): CTS_AT_AUART() used
* mxs_auart_init_gpios() returns true(success)/false(failure)
* dev_err() message fixed in mxs_auart_probe()

[PATCH 3/4] serial: mxs-auart: add interrupts for modem control lines
* rebased

[PATCH 4/4] serial: mxs-auart: enable PPS support
* coding style: braces in both branches of condition


v2 -> v3 changelog:
* own patches reordered to apply mainline
* patch "serial: mxs-auart: add sysrq support"
  removed from the patchset and resent as independent

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


Janusz Uzycki (4):
  serial: mxs-auart: clean get_mctrl and set_mctrl
  serial: mxs-auart: use mctrl_gpio helpers for handling modem signals
  serial: mxs-auart: add interrupts for modem control lines
  serial: mxs-auart: enable PPS support

 .../devicetree/bindings/serial/fsl-mxs-auart.txt   |  10 +-
 drivers/tty/serial/Kconfig           |   1 +
 drivers/tty/serial/mxs-auart.c       | 237 +++++++++++++++++++--
 3 files changed, 233 insertions(+), 15 deletions(-)

-- 
1.7.11.3
