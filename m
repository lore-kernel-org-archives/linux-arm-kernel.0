From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Sep 2009 13:15:40 +0100
Subject: [PATCH 09/10] S3C64XX I2S: Set parent links for clock audio-bus.
In-Reply-To: <1b68c6790909150442m5aaf826fy73a9c48bd2fabbf2@mail.gmail.com>
References: <1253008961-10698-1-git-send-email-jassi.brar@samsung.com>
	<20090915111204.GJ22878@rakim.wolfsonmicro.main>
	<1b68c6790909150442m5aaf826fy73a9c48bd2fabbf2@mail.gmail.com>
Message-ID: <20090915121539.GO22878@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 08:42:32PM +0900, jassi brar wrote:
> On Tue, Sep 15, 2009 at 8:12 PM, Mark Brown

> > code? ?It seems bad form for the audio driver to be looking at clock
> > configuration outside its domain.

> I understand that.
> Even without this patch it sources FOUTepll by default.
> This is not meant to be forever.  I patched it because
> I didn't want to get stuck making platform perfect to push the idea.

I'm not saying don't touch this, I'm saying that this doesn't belong in
this driver.

> > The mout/fout connection in particular isn't audio local, there's way
> > more EPLL users than just the audio.

> Ofcourse, but i think those drivers and requirements are far off that
> may need EPLL.

Are you sure?  UART, USB, MMC and SPI all have options to clock off EPLL
- I've worked with designs that were actively using it for at least USB.

> EPLL is a shared but unused resource. Using EPLL gives far more accurate clocks
> and we shudn't keep hands off just because there is no arbiter.

That doesn't seem like it's going to work so well, especially if Samsung
are actively pushing more drivers into mainline - if two drivers start
trying to play about with this simultaneously then what'll happen is
that users who end up trying to use those drivers together will have to
deal with the fallout.

> If not here, i favor controlling it from machine specific code.

Well, for the EPLL mux/PLL connection I'm not sure why we're not just
doing it in the default clock setup - I had thought that that was being
done by default already to be honest but I've not checked.

For anything where there's serious decisions to be taken it does need to
be machine-specific but if the clock implementation were to choose
sensible defaults I wouldn't see any problem with that, though I don't
know what Ben thinks.
