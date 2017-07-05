From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 5 Jul 2017 15:29:10 +0200
Subject: [PATCH v2 1/6] serial: imx: only set DMA rx-ing when DMA starts
In-Reply-To: <20170705130706.10388-2-romain.perier@collabora.com>
References: <20170705130706.10388-1-romain.perier@collabora.com>
 <20170705130706.10388-2-romain.perier@collabora.com>
Message-ID: <20170705132910.nmixhnh4l6h2hlga@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jul 05, 2017 at 03:07:01PM +0200, Romain Perier wrote:
> From: Nandor Han <nandor.han@ge.com>
> 
> Avoid the situation when `dma_is_rxing` could incorrectly signal that
> DMA RX channel is receiving data in case DMA preparation or sg mapping
> fails.
> 
> This commit fixes the issues by moving the assignment of dma_is_rxing
> out of imx_disable_rx_int(), then the variable is set to 1 from
> start_rx_dma() only when the preparation is correctly done.

I'd write:

	There are a few issues with setting dma_is_rxing to 1 in
	imx_disable_rx_int:

	 - Currently always after imx_disable_rx_int() the function
	   start_rx_dma() is called. This dependency isn't obvious though.
	 - start_rx_dma() does error checking and might exit without enabling
	   DMA but keeping dma_is_rxing 1.

	So the more natural place for setting dma_is_rxing to 1 is in
	start_rx_dma after all errors are checked.

If you use this, there is nothing left of Nandor Han's patch and you can
drop his authorship.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
