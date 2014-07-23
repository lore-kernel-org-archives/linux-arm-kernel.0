From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 23 Jul 2014 23:33:05 +0800
Subject: [PATCH v5 0/2] serial: 8250_dw: optional reset control and deferred
 probe support
Message-ID: <1406129587-24668-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

This series adds optional reset control and deferred probing support
to 8250_dw. These are required to support the UARTs on sun6i/sun8i.
They were originally part of my sun8i PRCM series. The other parts
of that series have been merged already. It would be really nice
if we could get these 2 in as well.

Patch 1 adds optional reset control support to the 8250_dw, which
is used by sun6i and sun8i platforms. Till now, this wasn't needed
from a working standpoint, as the bootloader de-asserts the reset
control on the console UART for us. However, during the development
of the sun8i patches, I noticed other UARTs wouldn't work. Also the
new sun6i A31 Hummingbird has multiple UARTs available, which would
require this patch.

Patch 2 adds deferred probing to 8250_dw. In my case, even though
the clocks and reset controller "devices" were registered before
the UART, the 8250_dw driver binded with the UART devices before
the clocks and resets were available. This resulted in the 8250_dw
driver failing. I only tested the R_UART device.

Patch 2 also does proper cleanup in the event that probing failed.

Maxime, I dropped your Acked-by because I added the cleanup code
path.

Changes since v4:
  - Rebased onto tty-next (4847914)
  - Do proper cleanup in the probe function if errors are encountered.

No changes before v4.


Cheers
ChenYu


Chen-Yu Tsai (2):
  serial: 8250_dw: Add optional reset control support
  serial: 8250_dw: Add support for deferred probing

 .../bindings/serial/snps-dw-apb-uart.txt           |  1 +
 drivers/tty/serial/8250/8250_dw.c                  | 50 +++++++++++++++++++---
 2 files changed, 44 insertions(+), 7 deletions(-)

-- 
2.0.1
