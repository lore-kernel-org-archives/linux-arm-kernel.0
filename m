From: mgr@pengutronix.de (Michael Grzeschik)
Date: Tue, 31 Mar 2015 22:13:00 +0200
Subject: [PATCH v2] spi: bitbang: only toggle bitchanges
In-Reply-To: <CAOiHx=k_NhSgzUDNPGXLUWN9r9bJ1rbsv3vLg_gFKpuinEqKmA@mail.gmail.com>
References: <20150331141321.GR2869@sirena.org.uk>
 <1427812501-7194-1-git-send-email-m.grzeschik@pengutronix.de>
 <CAOiHx=k_NhSgzUDNPGXLUWN9r9bJ1rbsv3vLg_gFKpuinEqKmA@mail.gmail.com>
Message-ID: <20150331201300.GB12253@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 08:59:28PM +0200, Jonas Gorski wrote:
> On Tue, Mar 31, 2015 at 4:35 PM, Michael Grzeschik
> <m.grzeschik@pengutronix.de> wrote:
> > The current implementation of bitbang_txrx_be_cpha0 and
> > bitbang_txrx_be_cpha1 always call setmosi. That runs into several
> > unnecessary calls into the gpiolib when the level of the GPIO actually
> > has not to be changed.
> >
> > This patch changes the routines to remember the last GPIO level
> > and only calls setmosi if an change has to be made. This
> > way it improves the transfer throughput.
> >
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> > v2: added missing braces
> >
> >  drivers/spi/spi-bitbang-txrx.h | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
> > index c616e41..06b34e5 100644
> > --- a/drivers/spi/spi-bitbang-txrx.h
> > +++ b/drivers/spi/spi-bitbang-txrx.h
> > @@ -49,12 +49,17 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
> >  {
> >         /* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
> >
> > +       bool oldbit = !(word & 1);
> 
> Is it intentional you check the first bit (word & 1) here? Everywhere
> else you use (word & 31).

Doh! I was reworking this from an _le_ variant of the same code.
This hunk unfortunately is an leftover... :/

Mark, should I send a corrected version or do you squash the 31 into the
applied patch?

Thanks for the hint,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
