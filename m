From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 27 Aug 2015 18:39:13 +0200
Subject: [PATCH 0/8] i.MX early debug UART clock fixes
Message-ID: <1440693561-28095-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes a long standing interaction issue between the
kernels early debug facilities and the i.MX clock drivers.

Both earlyprintk and earlycon rely on the bootloader setup clocks
for the UARTs to be retained during kernel init. As those clocks are
only enabled in hardware, but not referenced in software they (or even
their parent clocks) may get disabled as a result of other clocks being
en-/disabled during boot.

This results in missing messages from the early debug console until the
regular system console takes over, or even worse system hangs in response
to unclocked register accesses. This renders those debugging facilities a
lot less useful.

The fix implemented here is to check if any of this early debugging is
enabled and keep the UART clocks referenced and enabled in that case.
The clocks will then only be disabled at the end of kernel init, at which
point the real console should have taken over and the early outputs being
disabled.

I've runtime tested this on i.MX6Q and i.MX53, other platforms are only
compile tested. This is mostly a mechanical change, but still I would
appreciate some testing.

Regards,
Lucas

Lucas Stach (8):
  clk: imx: add common logic to detect early UART usage
  clk: imx25: retain early UART clocks during kernel init
  clk: imx27: retain early UART clocks during kernel init
  clk: imx31: retain early UART clocks during kernel init
  clk: imx35: retain early UART clocks during kernel init
  clk: imx5: retain early UART clocks during kernel init
  clk: imx6: retain early UART clocks during kernel init
  clk: imx7d: retain early UART clocks during kernel init

 drivers/clk/imx/clk-imx25.c       | 20 ++++++++++++++++++++
 drivers/clk/imx/clk-imx27.c       | 22 ++++++++++++++++++++++
 drivers/clk/imx/clk-imx31.c       | 20 ++++++++++++++++++++
 drivers/clk/imx/clk-imx35.c       | 16 ++++++++++++++++
 drivers/clk/imx/clk-imx51-imx53.c | 28 ++++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx6q.c       | 12 ++++++++++++
 drivers/clk/imx/clk-imx6sl.c      | 12 ++++++++++++
 drivers/clk/imx/clk-imx6sx.c      | 12 ++++++++++++
 drivers/clk/imx/clk-imx7d.c       | 22 ++++++++++++++++++++++
 drivers/clk/imx/clk.c             | 33 +++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h             |  2 ++
 11 files changed, 199 insertions(+)

-- 
2.5.0
