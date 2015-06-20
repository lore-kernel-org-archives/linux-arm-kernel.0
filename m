From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 20 Jun 2015 17:34:21 +0000
Subject: [RFC PATCH] ARM: dts: Convert Linkstation Mini to Device Tree
In-Reply-To: <1434765234.5177.25.camel@dolka.fr>
References: <1434765234.5177.25.camel@dolka.fr>
Message-ID: <20150620173421.GJ2936@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benjamin, Andrew, other mvebu cats,

On Sat, Jun 20, 2015 at 03:53:54AM +0200, Benjamin Cama wrote:

>From here -----vvvv

> Hi,
> 
> This is my conversion patch to DT for my Linkstation Mini. The name of
> the file better reflects the manufacturer's device name (LS-WSGL), as
> there also exists a newer Linkstation Mini (LS-WSXL) based on Kirkwood
> (and as Andrew noted, a patch for it landed yesterday). I did not
> actually re-test it from clean build (it worked fine before, modulo
> some cosmetics fixes), as I had a problem with the hardware that I am
> going to fix soon, but I wanted some comments on it. I included
> Andrew's remarks, even though I do not know what to do about the
> buttons name for now: I don't know how the switch is wired exactly for
> now, and FYI the ???auto-power??? is an intermediate position between off
> and power that in the original firmware does some wake-up/sleep of the
> disks when the backup utility is run from the PC connected to the NAS.
> I never used it and do not know what to do with it, and what ???key???
> should be associated with it.

To here -----^^^^^

Is very conversational.  This should be a more technical description of
the changes being made as this is the block that 'git am' will use for
the commit message.  Then the conversational bits go ...

> 
> Signed-off-by: Benjamin Cama <benoar@dolka.fr>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

right here, below the '---'.

>  arch/arm/boot/dts/Makefile           |   3 +-
>  arch/arm/boot/dts/orion5x-lswsgl.dts | 241 ++++++++++++++++++++++++++++++
>  arch/arm/mach-orion5x/Kconfig        |   6 +-
>  arch/arm/mach-orion5x/lsmini-setup.c | 280 -----------------------------------
>  4 files changed, 246 insertions(+), 284 deletions(-)
>  create mode 100644 arch/arm/boot/dts/orion5x-lswsgl.dts
>  delete mode 100644 arch/arm/mach-orion5x/lsmini-setup.c

Ahhh, that's always refreshing to see...

> diff --git a/arch/arm/boot/dts/orion5x-lswsgl.dts b/arch/arm/boot/dts/orion5x-lswsgl.dts
> new file mode 100644
> index 0000000..c7537a6
> --- /dev/null
> +++ b/arch/arm/boot/dts/orion5x-lswsgl.dts
> @@ -0,0 +1,241 @@
> +/*
> + * Copyright (C) 2015 Benjamin Cama <benoar@dolka.fr>
> + * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + * Copyright (C) 2008 Alexey Kopytko <alexey@kopytko.ru>

It may be preferable to say "Based on the board file
arch/arm/mach-orion5x/lsmini-setup.c, Copyright (C) 2008 Alexey Kopytko
<alexey@kopytko.ru>"  But that's very nit-picky.  As long as Alexey is
recognized, it should be fine.

> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */

We're trying to move the dts{i} files to dual license.  Please take a
look at the current armada-*.dts{i} license blocks.  If you are ok with
it, please change the above to match.

> diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
> index 2412efb..08d2be2 100644
> --- a/arch/arm/mach-orion5x/Kconfig
> +++ b/arch/arm/mach-orion5x/Kconfig
> @@ -78,11 +78,11 @@ config MACH_LINKSTATION_LSCHL
>  	  Buffalo Linkstation Live v3 (LS-CHL) platform.
>  
>  config MACH_LINKSTATION_MINI
> -	bool "Buffalo Linkstation Mini"
> -	select I2C_BOARDINFO
> +	bool "Buffalo Linkstation Mini (Flattened Device Tree)"
> +	select ARCH_ORION5X_DT
>  	help
>  	  Say 'Y' here if you want your kernel to support the
> -	  Buffalo Linkstation Mini platform.
> +	  Buffalo Linkstation Mini (LS-WSGL) platform.

Hmmm, this question is for the other mvebu maintainers:  When we
originally converted kirkwood and dove, we put a lot of effort into
keeping the board files and the dts files around in parallel for a
while.  Do we need to do that here?  All the drivers are converted, so
we don't need to keep the legacy board files for that reason.

I'm not sure it's necessary myself, but I'm thinking it might be a good
idea on general principal to deprecate the board file over time.
Thoughts?

thx,

Jason.
