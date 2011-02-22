From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Feb 2011 09:27:57 -0800
Subject: [PATCH 4/4] ARM: tegra: Move pinmux init call
In-Reply-To: <AANLkTimcadeAHWuFApw_H+AEs+hgURxCRO2X92M9cehG@mail.gmail.com>
References: <1298173137-9242-1-git-send-email-swarren@nvidia.com>
	<1298173137-9242-5-git-send-email-swarren@nvidia.com>
	<AANLkTimcadeAHWuFApw_H+AEs+hgURxCRO2X92M9cehG@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03112A5A37@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross wrote at Monday, February 21, 2011 8:22 PM:
> 
> On Sat, Feb 19, 2011 at 7:38 PM, Stephen Warren <swarren@nvidia.com>
> wrote:
> > In order for the clock initialization to pick up the results of the
> > pinmux initialization (which will initialize various parameters of
> > clocks cdev1, cdev2), the pinmux initialization must happen first.
> > Move the pinmux init to achieve this.
>...
> > ?{
> > + ? ? ? harmony_pinmux_init();
> > +
> > ? ? ? ?tegra_common_init();
> >
> > ? ? ? ?tegra_clk_init_from_table(harmony_clk_init_table);
> >
> > - ? ? ? harmony_pinmux_init();
> > -
> 
> This isn't going to work any more.  In order for the timer to get a
> reference to its clock, clocks have to be up before the system timer
> is initialized, so Russell added an init_early hook for clock
> initialization.  init_machine happens much later, so the per-board
> pinmux init will always happen after clock init.

OK. Drop this patch then.

IIRC, this patch was mostly about making the state (e.g. debugfs files) match
between the pinmux and clock drivers. At least initially I'll ignore this now
that I know what's going on with the audio clocks, and just make audio work
with the appropriate pinmux settings as you suggest.

Maybe that approach will obviate the need for my patch that adds set_parent
for cdev[12], if it's done by pinmux settings instead. I'll check and see.
We can think about the underlying synchronization issue between clock/pinmux
later I think.

-- 
nvpublic
