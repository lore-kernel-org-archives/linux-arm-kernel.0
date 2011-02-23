From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Feb 2011 13:22:43 -0800
Subject: [PATCH 5/5] ARM: Tegra: Enable Harmony audio support
In-Reply-To: <AANLkTikk6f0Nv8XZEmY4-85FtBE1re9hKqgFRNZkyPfz@mail.gmail.com>
References: <1298487532-5000-1-git-send-email-swarren@nvidia.com>
	<1298487532-5000-6-git-send-email-swarren@nvidia.com>
	<AANLkTimffVNK2EmTqypQcrWHLisf3c8_dMsHwSbv-nWi@mail.gmail.com>
	<AANLkTikk6f0Nv8XZEmY4-85FtBE1re9hKqgFRNZkyPfz@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03112A5D88@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross wrote at Wednesday, February 23, 2011 2:16 PM:
> 
> On Wed, Feb 23, 2011 at 1:08 PM, Olof Johansson <olof@lixom.net> wrote:
> > ...
> > On Wed, Feb 23, 2011 at 10:58 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > [...]
> >> diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
> >> index 4fe33b8..fbf2304 100644
> >> --- a/arch/arm/mach-tegra/board-harmony.h
> >> +++ b/arch/arm/mach-tegra/board-harmony.h
> >> @@ -17,12 +17,19 @@
> >> ?#ifndef _MACH_TEGRA_BOARD_HARMONY_H
> >> ?#define _MACH_TEGRA_BOARD_HARMONY_H
> >>
> >> +#define GPIO_WM8903(_x_) ? ? ? ? ? ? ? (TEGRA_NR_GPIOS + (_x_))
> >
> >
> > The above assumes that wm8903 is the GPIO controller that gets
> > allocated the numbers right after native tegra gpio. That might not be
> > the case on all boards, since the TPS PMIC has some as well, I
> > believe.
> The GPIO numbers above TEGRA_NR_GPIOS are allocated by the board, and
> this is in board-harmony.h, so I think its OK.

The Seaboard equivalent of this that I wrote for ChromeOS is:

#define TPS_GPIO_BASE			TEGRA_NR_GPIOS

#define TPS_GPIO_WWAN_PWR		(TPS_GPIO_BASE + 2)

#define GPIO_WM8903(_x_)		(TPS_GPIO_BASE + 4 + (_x_))

Which takes into account other devices.

> > Does it need a hardcoded GPIO base, or can it use the dynamic one
> > (i.e. use -1 here)? I don't even see any reference to gpio_base in the
> > driver...
> I assume that is in the ASoC tree.  The platform data in tegra
> for-next does not include a gpio_base entry.

Yes, gpio_base is added to that tree.

-1 would probably work. But then, I have no idea how to find out what base
was assigned to the WM8903, in order to initialize the ASoC machine driver's
platform_data...

-- 
nvpublic
