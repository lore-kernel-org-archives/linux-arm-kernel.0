From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Apr 2012 11:54:47 +0200
Subject: [PATCH] ARM: imx: Fix imx5 idle logic bug
In-Reply-To: <CAMXH7KH6rdaUCsJxdj2pU0HrJ5ash5em2PMfyZHKTw+01Z=5nQ@mail.gmail.com>
References: <1334619468-25680-1-git-send-email-rob.lee@linaro.org>
 <20120417081025.GN20478@pengutronix.de>
 <CAMXH7KH6rdaUCsJxdj2pU0HrJ5ash5em2PMfyZHKTw+01Z=5nQ@mail.gmail.com>
Message-ID: <20120418095447.GP3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 09:11:32AM -0500, Rob Lee wrote:
> On Tue, Apr 17, 2012 at 3:10 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Mon, Apr 16, 2012 at 06:37:48PM -0500, Robert Lee wrote:
> >> The imx5_idle() check of the tzic_eanble_wake() return value uses
> >> incorrect (inverted) logic causing all attempt to idle to fail.
> >>
> >
> > Does this have influence on current kernels or does this only trigger
> > with your cpuidle patches?
> 
> This influences non-cpuidle kernels also as imx5_idle is what
> arm_pm_idle points to for imx51.

Ok, Applied this one for -rc then

Sascha

> 
> >
> > Sascha
> >
> >> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> >> ---
> >> ?arch/arm/mach-imx/mm-imx5.c | ? ?2 +-
> >> ?1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
> >> index 05250ae..e10f391 100644
> >> --- a/arch/arm/mach-imx/mm-imx5.c
> >> +++ b/arch/arm/mach-imx/mm-imx5.c
> >> @@ -35,7 +35,7 @@ static void imx5_idle(void)
> >> ? ? ? }
> >> ? ? ? clk_enable(gpc_dvfs_clk);
> >> ? ? ? mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
> >> - ? ? if (tzic_enable_wake() != 0)
> >> + ? ? if (!tzic_enable_wake())
> >> ? ? ? ? ? ? ? cpu_do_idle();
> >> ? ? ? clk_disable(gpc_dvfs_clk);
> >> ?}
> >> --
> >> 1.7.10
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >>
> >
> > --
> > Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> > Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> > Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at ?http://www.tux.org/lkml/
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
