From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Feb 2012 15:33:14 +0000
Subject: [PATCH V2 1/4] pinctrl: add a driver for NVIDIA Tegra
In-Reply-To: <CACRpkda+KCutSFgPwH2Xvd14h0OCrArFGXAidp3n_ZgG28KB5g@mail.gmail.com>
References: <1328130290-17607-1-git-send-email-swarren@nvidia.com>
 <CACRpkda+KCutSFgPwH2Xvd14h0OCrArFGXAidp3n_ZgG28KB5g@mail.gmail.com>
Message-ID: <201202021533.14650.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 February 2012, Linus Walleij wrote:
> On Wed, Feb 1, 2012 at 10:04 PM, Stephen Warren <swarren@nvidia.com> wrote:
> 
> > This adds a driver for the Tegra pinmux, and required parameterization
> > data for Tegra20 and Tegra30.
> 
> OK so I've applied this monster patch and the three others,
> 
> the diffstat looks like so:
> 
> git diff --stat v3.3-rc2..HEAD
>  arch/arm/mach-tegra/Kconfig                       |    4 +
>  arch/arm/mach-tegra/Makefile                      |    3 -
>  arch/arm/mach-tegra/board-harmony-pinmux.c        |  362 ++-
>  arch/arm/mach-tegra/board-paz00-pinmux.c          |  362 ++-
>  arch/arm/mach-tegra/board-pinmux.c                |   62 +-
>  arch/arm/mach-tegra/board-pinmux.h                |   39 +-
>  arch/arm/mach-tegra/board-seaboard-pinmux.c       |  442 ++-
>  arch/arm/mach-tegra/board-trimslice-pinmux.c      |  366 ++-
>  arch/arm/mach-tegra/include/mach/pinconf-tegra.h  |   63 +
>  arch/arm/mach-tegra/include/mach/pinmux-tegra20.h |  184 -
>  arch/arm/mach-tegra/include/mach/pinmux-tegra30.h |  320 --
>  arch/arm/mach-tegra/include/mach/pinmux.h         |  302 --
>  arch/arm/mach-tegra/pinmux-tegra20-tables.c       |  244 --
>  arch/arm/mach-tegra/pinmux-tegra30-tables.c       |  376 ---
>  arch/arm/mach-tegra/pinmux.c                      |  987 ------
>  drivers/pinctrl/Kconfig                           |   15 +
>  drivers/pinctrl/Makefile                          |    3 +
>  drivers/pinctrl/pinctrl-tegra.c                   |  559 +++
>  drivers/pinctrl/pinctrl-tegra.h                   |  163 +
>  drivers/pinctrl/pinctrl-tegra20.c                 | 2860 ++++++++++++++++
>  drivers/pinctrl/pinctrl-tegra30.c                 | 3726 +++++++++++++++++++++
>  21 files changed, 8482 insertions(+), 2960 deletions(-)
> 
> It's still pretty big, adding some 6000 lines in sum total, but you've made
> your case for having all information about the hardware in the driver
> quite clear so I've not got much more to say. Short story: the driver knows
> all about what the hardware can do, and the platform data or device
> tree will decide how these capabilities are employed on a certain
> system.
> 
> What is nice is to have this out of the ARM tree and under pinctrl
> subsystem control.
> 
> Olof, Arnd: please verify that this is a direction you accept for the Tegra.
> (Olof has already ACK:ed it, mainly thinking about Arnd.)

I would have liked to see a smaller pinctrl driver and one with fewer macros,
but I'm not going to complain about it -- drivers/pinctrl is definitely your
turf not mine and I assume that Olof's Ack was meant in his position as Tegra
maintainer instead of his position as arm-soc maintainer.

It's unfortunate that the number of lines in the board specific pinmux
files is actually growing, even though the contents seem to be smaller
and it seems to be done in a way that all the data will move into the
device tree eventually. What is holding up that move right now?
I guess if we could move the per-board pinmux data into dts files,
that would mean we could actually get rid of the per-board source
files in tegra, right?

One thing that worries me a bit is the object size of the tegra
pinctrl driver: There are now about 70kb pinmux driver binary in
each kernel that wants to run on tegra (about the same as the
remaining tegra platform code), which can become a bottleneck
in future multi-platform kernels that also want to run on a lot of
other things. 
Will it be possible to eventually put the pinmux driver into a loadable
module?

	Arnd
