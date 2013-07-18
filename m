From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 18 Jul 2013 12:02:01 +0100
Subject: [PATCH v3] clk: add MOXA ART SoCs clock driver
In-Reply-To: <CACmBeS2SnpiUtiQD6j9qyaXZ5-chHSHVeo4c5=UhitVonvkKtw@mail.gmail.com>
References: <1372943292-6960-1-git-send-email-jonas.jensen@gmail.com>
 <1374067396-30155-1-git-send-email-jonas.jensen@gmail.com>
 <20130718095035.GA29153@e106331-lin.cambridge.arm.com>
 <CACmBeS2SnpiUtiQD6j9qyaXZ5-chHSHVeo4c5=UhitVonvkKtw@mail.gmail.com>
Message-ID: <20130718110201.GB29153@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 11:36:40AM +0100, Jonas Jensen wrote:
> Hi Mark, thanks for taking a look at this.
> 
> On 18 July 2013 11:50, Mark Rutland <mark.rutland@arm.com> wrote:
> > This confuses me. moxart_of_clk_init gets called because there was a
> > "moxa,moxart-core-clock", node in the dt, but the driver only seems to
> > use the information to figure out the configuration of another clock
> > ("moxa,moxart-apb-clock"), and never registers a clock specifically for
> > the core-clock.
> >
> > I couldn't find "moxa,moxart-apb-clock" described in mainline. COuld you
> > describe the relationship between core-clock and apb-clock?
> 
> It's true core-clock exist only so the register can be mapped.

Ok. I'm just concerned that the linkage isn't explicit or obvious.

> 
> apb-clock is part of a patch set that will add new device tree files for the
> MOXA ART SoC, but it's not in mainline:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/181757.html
> 
> apb-clock could be a fixed rate 48MHz DT only clock, but because we can't
> be sure it's 48MHz on all platforms, reading it from a register with core-clock
> is more portable.

This does leave apb-clock completely dependent on core-clock, and unless
I've missed something there's no linkage between the two described in
the dt.

How does core-clock physically relate to apb-clock? Does it feed or is
it fed by apb-clock?

Are we always guaranteed to have core-clock if we have apb-clock, and is
it part of the same block in hardware? If so we could describe the
amalgamation as a provider with two clock outputs, with core-clock's
registers for configuration at probe-time.

Thanks,
Mark.

> 
> 
> Best regards,
> Jonas
> 
