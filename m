From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Jan 2010 11:52:58 +0000
Subject: [PATCH 2/3] ASoC: AC97: S3C: Add controller driver
In-Reply-To: <1b68c6791001260317k44893521vc0310ea35bac8ee1@mail.gmail.com>
References: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
	<20100126104723.GF15759@rakim.wolfsonmicro.main>
	<1b68c6791001260317k44893521vc0310ea35bac8ee1@mail.gmail.com>
Message-ID: <20100126115258.GM15759@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 08:17:25PM +0900, jassi brar wrote:
> On Tue, Jan 26, 2010 at 7:47 PM, Mark Brown

> >> + ? ? default:
> >> + ? ? ? ? ? ? s3c_ac97_cold_reset(ac97);
> >> + ? ? ? ? ? ? s3c_ac97_warm_reset(ac97);
> >> + ? ? ? ? ? ? break;
> >> + ? ? }

> > This automatic cold and warm reset looks a bit fishy - obviously if this
> > code path ever gets hit in normal operation then it's going to seriously
> > disrupt things since it'll reset the CODEC registers. ?A warm reset by
> > itself wouldn't be a problem but I'd rather see explicit cold resets in
> > the callers where that's required.

> Before read/write we need to ensure the link is active. And to reach the
> active state we have to do that as suggested by the FSM shown in SoCs' Manual.

That's not addressing the problem, though - the big issue is not
bringing up the AC97 link, it's the fact that you're doing an
uncontrolled cold reset.  If we hit this code path it'll revert the
device registers to default which will upset the drivers for the CODEC
rather badly.  There should be no possibility of that happening, if it
is happening it's something that callers really should know about.

> Also, this helps not relying on codec/core to perform particular steps
> of initializations.

Equally well if the controller driver diverges from what other drivers
do it's going to lead to interoperability skew for drivers.

For the warm reset function I'd suggest adding something which checks to
see if the link is already active and suppresses the warm reset in that
case.  That will avoid slowing everything down with spurious warm resets
when the link is already runnning and other drivers assume they need to
bring it up - with the way things are structured at present many warm
resets requested by other drivers are likely to be spurious.

Ideally the core would keep track of this and transparently trigger the
warm reset when required, but driver local is fine since that's not
there yet.

> >> + ? ? ac_glbctrl = S3C_AC97_GLBCTRL_ACLINKON;
> >> + ? ? writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
> >> + ? ? msleep(1);

> > This also looks a bit odd, ACLINKON sounds like bringing up the link
> > which is what a warm reset does.

> As shown in FSM of SoCs manual, this sets the controller state to READY.
> Please have a look at any manual's AC97 chapter.

Right, but why is this being done by this function and not, for example,
by the warm reset?  It's the structure of the code I'm commenting on
rather than the operations that get performed on the hardware.

> >> +lb5:
> >> + ? ? free_irq(irq_res->start, NULL);

> > Perhaps a better name than 'lb' - err, or fail or something. ?lb means
> > nothing to me at least.

> means label to me :)

If you'd spelt out label I'd probably have been OK, but in English lb is
normally only an abbreviation for pounds as a unit of weight.
