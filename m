From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 23 Mar 2012 08:13:28 +0100
Subject: [PATCH 1/1] ARM iMX28: incorrect frac/div calculation
In-Reply-To: <1332457501-8153-1-git-send-email-matt@grid-net.com>
References: <1332457501-8153-1-git-send-email-matt@grid-net.com>
Message-ID: <20332.8856.841320.610752@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Matt Burtch writes:
> The frac and div values in _CLK_SET_RATE are calculated incorrectly
> for some clock rates ie. CPU clk of 454.73MHz, 392.72MHz, 261.81Mhz,
> etc.
> 
> Now the frac and div values which result in the closest actual clock
> rate to that requested is selected.  Also there are no limitations
> on what frac values can be used, as long as they fall in the valid
> (18 < frac < 35) range.
> 
> Tested on custom iMX28 board.
> 
> Signed-off-by: Matt Burtch <matt@grid-net.com>
> ---
>  arch/arm/mach-mxs/clock-mx28.c |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 5d68e41..a058b99 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -354,19 +354,15 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
>  		}							\
>  		for (d = 1; d <= div_max; d++) {			\
>  			f = parent_rate * 18 / d / rate;		\
> -			if ((parent_rate * 18 / d) % rate)		\
> -				f++;					\
>  			if (f < 18 || f > 35)				\
>  				continue;				\
>  									\
>  			calc_rate = parent_rate * 18 / f / d;		\
> -			if (calc_rate > rate)				\
> -				continue;				\
>  									\
> -			if (rate - calc_rate < diff) {			\
> +			if (abs(rate - calc_rate) < diff) {		\
Shouldn't this actually be '<=' (also in the original code)?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
