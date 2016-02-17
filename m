From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Feb 2016 14:54:41 +0100
Subject: [PATCH] i.MX SPI DMA cleanup
In-Reply-To: <56C478C9.6050706@de.bosch.com>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
 <56C478C9.6050706@de.bosch.com>
Message-ID: <20160217135441.GA3939@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

On Wed, Feb 17, 2016 at 02:42:33PM +0100, Dirk Behme wrote:
> Hi Sascha,
> 
> On 17.02.2016 14:28, Sascha Hauer wrote:
> >This picks up a series sent by Anton Bondarenko last year. It
> >contains the remaining not yet upstreamed patches from Antons series
> >plus some more DMA related cleanup patches.
> >
> >My mission was to hunt a bug in the DMA code path sometimes causing
> >an additional word in the RX FIFO which locked up the driver in the
> >next transfer. It turned out that this was no bug in the driver but
> >instead in the device tree: We used the wrong SDMA script for i.MX6.
> >The ECSPI cores are connected through the SPBA, so according to the
> >reference manual we need the shp/mcu scripts rather than the app/mcu
> >scripts.
> 
> 
> Are you talking about what is known as "TKT238285 hardware issue"
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-imx.c?id=a02bb401f8ae264be782ee57d98bdd99f14c8022

I am aware of this issue, but I have no idea if this is the same or
another issue. It says:

> For TKT238285 hardware issue which may cause txfifo store data twice can only
> be caught on i.mx6dl, we use pio mode instead of DMA mode on i.mx6dl.

What I saw here is that there was one word more than expected in the RX
FIFO. Since both RX and TX FIFO act synchronously it could be that the
additional word in the RX FIFO was caused by an additional word in the
TX FIFO as described above.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
