From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 16 Jun 2012 15:26:52 +0100
Subject: [PATCH] mmc: mmci.c: Defer probe() in case of missing GPIOs
In-Reply-To: <1339856099-9313-1-git-send-email-stigge@antcom.de>
References: <1339856099-9313-1-git-send-email-stigge@antcom.de>
Message-ID: <20120616142652.GC7628@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 16, 2012 at 04:14:59PM +0200, Roland Stigge wrote:
> If the GPIOs used by the MMCI driver are not registered yet when the
> driver is probe()d, they can't be used. This happens if the mmci driver
> is probed before the respective GPIO controller (e.g. on the LPC32xx
> EA3250 board, the PCA9532 GPIO controller would be initialized via DT
> after mmci). Therefore, we defer mmci in this case.

This code is wrong.  There are platforms where plat->gpio_cd is negative
(because there isn't an associated GPIO) and we still expect the driver
to successfully bind.  In that case, the driver gets the CD and WP
information via the status callback.

So this is an incompatible change with existing (and required) driver
behaviour.
