From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 14:33:50 +0200
Subject: [PATCH v6 2/8] ARM: sunxi: Split out the various machines into
 separate files
In-Reply-To: <1397724379-15398-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1397724379-15398-1-git-send-email-maxime.ripard@free-electrons.com>
 <1397724379-15398-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201404231433.51129.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 April 2014, Maxime Ripard wrote:
> This will allow to add per-SoC hooks more easily.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-sunxi/Makefile  |   6 +-
>  arch/arm/mach-sunxi/restart.c | 104 +++++++++++++++++++++++++++
>  arch/arm/mach-sunxi/restart.h |  20 ++++++
>  arch/arm/mach-sunxi/sun4i.c   |  36 ++++++++++
>  arch/arm/mach-sunxi/sun5i.c   |  37 ++++++++++
>  arch/arm/mach-sunxi/sun6i.c   |  49 +++++++++++++
>  arch/arm/mach-sunxi/sun7i.c   |  36 ++++++++++
>  arch/arm/mach-sunxi/sunxi.c   | 164 ------------------------------------------
>  8 files changed, 287 insertions(+), 165 deletions(-)

This doesn't look like a move in the right direction, and I don't see
the connection with the DMA driver.

> diff --git a/arch/arm/mach-sunxi/restart.c b/arch/arm/mach-sunxi/restart.c
> new file mode 100644
> index 000000000000..3b89727ee943
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/restart.c

Splitting out the restart code is good, but please complete this by
moving it into a driver directory. My preferred location would be
within the watchdog driver, since it's really the same registers.
You can turn on the watchdog driver as built-in in the defconfig.
While it's not ideal that you can end up without a restart function
if the driver does not get loaded, I would still prefer that over
having the driver in the mach-sunxi directory.

An alternative would be to move the restart code into
drivers/power/reset.

> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> deleted file mode 100644
> index 460b5a4962ef..000000000000
> --- a/arch/arm/mach-sunxi/sunxi.c

Instead of splitting up this file, I think it would be better to
reduce the number of special hacks required per machine. Note that
for arm64 we require platforms not to have any code outside of
the drivers directory, and I'd like to get to the same situation
for much of arch/arm/mach-* as well.

	Arnd
