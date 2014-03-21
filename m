From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Fri, 21 Mar 2014 13:37:41 -0400
Subject: [RFC PATCH] staging: imx-drm: add suspend / resume
References: <20140320151712.22089.59230.stgit@localhost>
Message-ID: <87mwgj4fmi.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 Mar 2014, mfuzzey at parkeon.com wrote:

> Currently i.MX53 boards with the imx-drm display driver active
> fail an intensive suspend to ram / resume test.

> After around 5 - 50 cycles it is no longer possible to resume
> the board.

> The culprit is the imx-drm driver which does not stop DMA
> before suspending. Removing the driver "fixes" the problem.

> This patch provides a minimal suspend / resume implementation
> enabling the intensive test to work (500 cycles ok).

> I am only sending this as RFC for the moment since I don't
> really know the hardware or driver code well enough to be
> sure this is the "right" way of doing it.

Sorry, I do not known that much about the imx53.  However, the imx25
needs to have DMA controllers/modules clocked and working when trying to
suspend the DDRam.  They may currently be bursting to the RAM
independent of the main CPU, so some deep sleep (self-refresh) need all
DMA controllers to ACK the DDR controller so that it may go to
self-refresh.

The controllers (FB, USB, ENET, etc on imx25) themselves seem to have a
'sleep' mode.  However, the sleep code maybe trying to disable some
clocks during sleep which need to remain active.  If the DRM DMA is
active, but the module clock is turned off, it will not be able to ACK
the DDR-controller.  Similar issues may exist with USB, ENET, etc.

Fwiw,
Bill Pringlemeir.
