From: stefan@datenfreihafen.org (Stefan Schmidt)
Date: Tue, 21 Jun 2011 17:18:39 +0200
Subject: Slow spi_sync() on pxa2xx_spi
In-Reply-To: <BANLkTi=+oNHYYL_=gYUCC+zFBfnkxZqJWA@mail.gmail.com>
References: <20110616082112.GA10075@excalibur.local>
	<BANLkTikuo_fHbw9FFMtorpg15vOnXMK-+g@mail.gmail.com>
	<20110616091931.GB10075@excalibur.local>
	<BANLkTinU+chEbZRpFSdRH_dPE2vhK_7pHg@mail.gmail.com>
	<20110621140341.GK3652@excalibur.local>
	<BANLkTi=S+WJYqMJJZptMCxtzSUU=W2UL0Q@mail.gmail.com>
	<20110621142025.GL3652@excalibur.local>
	<BANLkTi=+oNHYYL_=gYUCC+zFBfnkxZqJWA@mail.gmail.com>
Message-ID: <20110621151839.GM3652@excalibur.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On Tue, 2011-06-21 at 23:04, Eric Miao wrote:
> On Tue, Jun 21, 2011 at 10:20 PM, Stefan Schmidt
> <stefan@datenfreihafen.org> wrote:
> >
> > On Tue, 2011-06-21 at 22:08, Eric Miao wrote:
> >> On Tue, Jun 21, 2011 at 10:03 PM, Stefan Schmidt
> >> <stefan@datenfreihafen.org> wrote:
> >> > On Thu, 2011-06-16 at 17:44, Eric Miao wrote:
> >> > > On Thu, Jun 16, 2011 at 5:19 PM, Stefan Schmidt
> >> > > <stefan@datenfreihafen.org> wrote:
> >> > > >
> >> > > > Its either 8bit or 16bit for a message. The mentioned problem happens
> >> > > > on a 8 bit message. It does nothing else then writing to a defined
> >> > > > register address to trigger the hardware sending the data in the FIFO.
> >> > >
> >> > > This might get too much overhead. I didn't check the source code, but
> >> > > my guess is it's waiting for interrupt for each message, and once the
> >> > > interrupt of message being flushed out happens, it starts the next one
> >> > > waiting for the FIFO empty interrupt coming. Did you try stuff more
> >> > > bytes into a single message?
> >> >
> >> > Took me some time to implement and test al kind of different
> >> > scenarios. As you suggested I tried to stuff more bytes into a message
> >> > as well as testing all kind of combination with tx and rx thresholds,
> >> > timout, PIO and DMA, cs_change , etc. No change.
> >> >
> >> > I then bit the bullet and changed the board to use the spi_gpio driver
> >> > instead of pxa2xx. After some struggling (make sure you setup pin
> >> > config correctly :)) I got it working but with the same result.
> >> >
> >> > My last test block was around using spi_async() instead of spi_sync
> >> > and as well I was not able to reach my timing criteria. :(
> >> >
> >> > To me it seems right now as if it is just not possible to reach
> >> > something in the 100 usec range with the SPI framework. Obviuously I
> >> > would be loved to be proven wrong. :)
> >> >
> >> > As I'm running way out of time for this part of my project I'm back to
> >> > the driver now trying to find a solution that avoids the tight timing
> >> > criteria.
> >>
> >> I think for a time budget like this, you may want to try a dedicated
> >> polling driver avoid all the interrupt/wait stuff, that's going to maximize
> >> the throughput. If that's even not possible, it might be HW limitations.
> >
> > You mean like configuring the pins as plain GPIO and have some small
> > bitbang functions on my own without the SPI framework? Just trying to
> > understand in what direction you are pointing me. :)
> 
> I mean just to have a small driver, configure the SPI controller with
> hardcoded values, and try writing to the SSDR all by yourself, and
> polling the SSSR status bits. Not something simulating SPI w/ GPIO,
> that will be slow.

Wow, that is something I like to avoid doing at all. :) Thanks for the
pointer though. Something to have in mind if everythings else fails.

regards
Stefan Schmidt
