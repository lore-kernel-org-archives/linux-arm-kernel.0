From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Thu, 17 Dec 2009 08:16:34 +0100
Subject: [PATCH 04/20] imx/clock-imx27: use a macro to define registers
In-Reply-To: <1260990002-24168-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091216185046.GA16984@pengutronix.de>
	<1260990002-24168-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <19241.56018.432600.636616@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Uwe Kleine-K?nig writes:
> This way the base address isn't hard coded in each register definition
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Rabin Vincent <rabin@rab.in>
> Cc: Javier Martin <javier.martin@vista-silicon.com>
> Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
> ---
>  arch/arm/mach-mx2/clock_imx27.c |   30 ++++++++++++++++--------------
>  1 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
> index b010bf9..a533208 100644
> --- a/arch/arm/mach-mx2/clock_imx27.c
> +++ b/arch/arm/mach-mx2/clock_imx27.c
> @@ -29,21 +29,23 @@
>  #include <mach/common.h>
>  #include <mach/hardware.h>
>  
> +#define IO_ADDR_CCM(off)	(IO_ADDRESS(CCM_BASE_ADDR) + (off))
I would include the offset in the parameter for the IO_ADDRESS macro,
so that the macro would check the complete address (including the
offset) for validity:
| +#define IO_ADDR_CCM(off)	(IO_ADDRESS((CCM_BASE_ADDR) + (off)))
Otherwise e.g. a negative offset may lead to generation of bogus
addresses.

It may be unnecessary in this case, because the macro is only used
with constant offsets, but the code may be copied and used in a
different context.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
