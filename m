From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 01:18:29 +0100
Subject: [PATCH 10/10] S3C64XX I2S: En/Disable codec clocks.
In-Reply-To: <1b68c6790909150535p777f93d4pc416f65dd8dbced4@mail.gmail.com>
References: <1253008962-10730-1-git-send-email-jassi.brar@samsung.com>
	<20090915114936.GK22878@rakim.wolfsonmicro.main>
	<1b68c6790909150535p777f93d4pc416f65dd8dbced4@mail.gmail.com>
Message-ID: <20090916001829.GF24720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 09:35:48PM +0900, jassi brar wrote:
> On Tue, Sep 15, 2009 at 8:49 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Tue, Sep 15, 2009 at 07:02:42PM +0900, Jassi wrote:
> >
> >> ? ? ? switch (clk_id) {
> >> ? ? ? case S3C64XX_CLKSRC_PCLK:
> >> ? ? ? ? ? ? ? iismod &= ~S3C64XX_IISMOD_IMS_SYSMUX;
> >> + ? ? ? ? ? ? clk_disable(i2s->iis_cclk);
> >> ? ? ? ? ? ? ? break;
> >>
> >> ? ? ? case S3C64XX_CLKSRC_MUX:
> >> ? ? ? ? ? ? ? iismod |= S3C64XX_IISMOD_IMS_SYSMUX;
> >> + ? ? ? ? ? ? clk_enable(i2s->iis_cclk);
> >> ? ? ? ? ? ? ? break;
> >
> > I'd expect that this will cause trouble eventually - machine drivers
> > tend to call set_sysclk() repeatedly, meaning that the clock will be
> > repeatedly enabled or disabled. ?Eventually this will overflow the
> > counter the clock API is using, perhaps even cause it to complain loudly
> > about errors (eg, if the use count drops below zero). ?A local reference
> > count should deal with those issues, or checking to see if iismod
> > actualy changed before updating the clock API.
> Yes, this was a bad idea.

agreed.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090916/40a97046/attachment.sig>
