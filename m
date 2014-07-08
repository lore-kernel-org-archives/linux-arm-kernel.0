From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 8 Jul 2014 19:31:41 +0200
Subject: [PATCH v2 00/18] AT91: cleanup of the reset and poweroff code
In-Reply-To: <1404743131-24569-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1404743131-24569-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <53BC2AFD.2010408@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2014 16:25, Maxime Ripard :
> Hi,
> 
> This patchset is an attempt to further cleanup mach-at91 by removing
> code that can be put into a driver nowadays.
> 
> This time, the target is the reset and poweroff code, that can now be
> put in drivers/power/reset.
> 
> Maxime
> 
> Changes from v1:
>   - Added the missing copyrights in the new reset and poweroff drivers
>   - Renamed the platform names for the reset driver to match the name
>     of the first SoC that introduced them
>   - Fixed a few typos in the commit logs
>   - Added missing comments in the assembly code in the reset driver
>   - Splitted the reset probe to handle the DT and platform probe in
>     separate functions.
> 
> Maxime Ripard (18):
>   power: reset: Add if statement isntead of multiple depends on
>   AT91: setup: Switch to pr_fmt

Beware: the subject prefix shall be "ARM: at91:" or "ARM: at91/<topic>:"

Thanks to re-spin the series with this before sending your pull-request.


>   AT91: G45: DT: Declare a second ram controller
>   AT91: Rework ramc mapping code
>   AT91: SAMA5D3: DT: Add shutdown controller
>   power: reset: Add AT91 reset driver
>   AT91: DT: Remove the old-style reset probing
>   AT91: soc: Introduce register_devices callback
>   AT91: Probe the reset driver
>   AT91: Call at91_register_devices in the board files
>   AT91: Remove reset code from the machine code
>   power: reset: Add AT91 poweroff driver
>   AT91: DT: Remove poweroff DT probing
>   AT91: Register the poweroff driver
>   AT91: Remove poweroff code
>   AT91: pm: Remove show_reset_status function
>   AT91: Remove rstc and shdwnc global base addresses
>   AT91: Remove rstc and shdwc headers
> 
>  arch/arm/boot/dts/at91sam9g45.dtsi      |   8 +-
>  arch/arm/boot/dts/sama5d3.dtsi          |   5 +
>  arch/arm/mach-at91/Kconfig              |   8 --
>  arch/arm/mach-at91/Makefile             |   2 -
>  arch/arm/mach-at91/at91_rstc.h          |  53 -------
>  arch/arm/mach-at91/at91_shdwc.h         |  50 -------
>  arch/arm/mach-at91/at91sam9260.c        |  45 +++++-
>  arch/arm/mach-at91/at91sam9261.c        |  45 +++++-
>  arch/arm/mach-at91/at91sam9263.c        |  45 +++++-
>  arch/arm/mach-at91/at91sam9_alt_reset.S |  40 ------
>  arch/arm/mach-at91/at91sam9g45.c        |  49 ++++++-
>  arch/arm/mach-at91/at91sam9g45_reset.S  |  45 ------
>  arch/arm/mach-at91/at91sam9rl.c         |  45 +++++-
>  arch/arm/mach-at91/board-afeb-9260v1.c  |   2 +
>  arch/arm/mach-at91/board-cam60.c        |   2 +
>  arch/arm/mach-at91/board-cpu9krea.c     |   2 +
>  arch/arm/mach-at91/board-flexibity.c    |   2 +
>  arch/arm/mach-at91/board-sam9-l9260.c   |   2 +
>  arch/arm/mach-at91/board-sam9260ek.c    |   3 +-
>  arch/arm/mach-at91/board-sam9261ek.c    |   3 +-
>  arch/arm/mach-at91/board-sam9263ek.c    |   3 +-
>  arch/arm/mach-at91/board-sam9m10g45ek.c |   3 +-
>  arch/arm/mach-at91/board-sam9rlek.c     |   3 +-
>  arch/arm/mach-at91/board-snapper9260.c  |   2 +
>  arch/arm/mach-at91/generic.h            |  10 +-
>  arch/arm/mach-at91/pm.c                 |  72 ----------
>  arch/arm/mach-at91/setup.c              | 178 ++++-------------------
>  arch/arm/mach-at91/soc.h                |   1 +
>  drivers/power/reset/Kconfig             |  31 ++--
>  drivers/power/reset/Makefile            |   2 +
>  drivers/power/reset/at91-poweroff.c     | 156 ++++++++++++++++++++
>  drivers/power/reset/at91-reset.c        | 246 ++++++++++++++++++++++++++++++++
>  32 files changed, 701 insertions(+), 462 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/at91_rstc.h
>  delete mode 100644 arch/arm/mach-at91/at91_shdwc.h
>  delete mode 100644 arch/arm/mach-at91/at91sam9_alt_reset.S
>  delete mode 100644 arch/arm/mach-at91/at91sam9g45_reset.S
>  create mode 100644 drivers/power/reset/at91-poweroff.c
>  create mode 100644 drivers/power/reset/at91-reset.c

Hi,

Even if we plan to remove board files, I agree that we do have to move:
so I support this initiative.

I have no particular remark concerning inline assembly and I agree with
the move to a more consistent driver scheme.

The whole series is clean and after having addressed the comments by
Alexandre and myself, you can add my:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

As I said to Alexandre, you can build a pull-request and send it to me.

Best regards,
-- 
Nicolas Ferre
