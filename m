From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Mar 2013 17:04:18 +0100
Subject: [PATCH v3 1/1 net-next] NET: FEC: dynamtic check DMA desc buff
 type
In-Reply-To: <1357265063-30528-1-git-send-email-Frank.Li@freescale.com>
References: <1357265063-30528-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130320160418.GG20530@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jan 04, 2013 at 10:04:23AM +0800, Frank Li wrote:
> MX6 and mx28 support enhanced DMA descriptor buff to support 1588
> ptp. But MX25, MX3x, MX5x can't support enhanced DMA descriptor buff.
> Check fec type and choose correct DMA descriptor buff type.
> 
> Remove static config CONFIG_FEC_PTP.
> ptp function will be auto detected.
Your patch (now as ff43da86c69d76a726ffe7d1666148960dc1d108 in v3.9-rc1)
breaks building with CONFIG_FEC=m:

	ERROR: "fec_ptp_init" [drivers/net/ethernet/freescale/fec.ko] undefined!
	ERROR: "fec_ptp_ioctl" [drivers/net/ethernet/freescale/fec.ko] undefined!
	ERROR: "fec_ptp_start_cyclecounter" [drivers/net/ethernet/freescale/fec.ko] undefined!

IMHO you should build fec.o and fec_ptp.o into the same module as they
cannot live without each other anyhow.

Having said I wonder if it would be worthwile to support FEC without
PTP_1588_CLOCK. For example make the above three functions static
inlines if CONFIG_PTP_1588_CLOCK=n and drop the select on the latter.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
