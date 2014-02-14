From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 14 Feb 2014 12:39:00 +0100
Subject: [PATCH] ARM: imx6: fix !CONFIG_PM and !CONFIG_CPU_IDLE build
In-Reply-To: <20140213141944.GC20842@S2101-09.ap.freescale.net>
References: <1392201948-16311-1-git-send-email-l.stach@pengutronix.de>
 <20140213141944.GC20842@S2101-09.ap.freescale.net>
Message-ID: <1392377940.6153.34.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Donnerstag, den 13.02.2014, 22:19 +0800 schrieb Shawn Guo:
> Hi Lucas,
> 
> On Wed, Feb 12, 2014 at 11:45:48AM +0100, Lucas Stach wrote:
> > When building a kernel with only CONFIG_CPU_IDLE, but no
> > CONFIG_PM we still need the functions to set the lpm mode
> > and chicken bits.
> > 
> > Also if both options are unset, we have to stub out the
> > set_lpm function, as this one is called from the clk
> > driver directly.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > This fix depends on an earlier one by Philipp:
> > "ARM: imx6: Initialize low-power mode early again"
> > 
> > Both should go to stable after a sensible sinking time.
> > ---
> >  arch/arm/mach-imx/Makefile   |   9 +++-
> >  arch/arm/mach-imx/common.h   |  11 +++--
> >  arch/arm/mach-imx/pm-imx6q.c | 112 ++++++++++++++++++++++---------------------
> >  3 files changed, 72 insertions(+), 60 deletions(-)
> 
> Since we already have so many stuff in pm-imx6q.c needed by a !CONFIG_PM
> build, maybe we should build pm-imx6q.c without CONFIG_PM condition,
> something like the following?
> 
Yes, while thinking about this again it seems to make sense. I first was
a bit afraid of calling pm_init unconditionally, but aside from a bit
increased binary size it should be harmless and it simplifies things a
lot, compared with my patch.

So feel free to take yours.

Regards,
Lucas
> Shawn
> 
> ---8<-----------
> 
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index befcaf5..ec41964 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -101,11 +101,9 @@ obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
>  obj-$(CONFIG_SOC_IMX6Q) += clk-imx6q.o mach-imx6q.o
>  obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
> 
> -ifeq ($(CONFIG_PM),y)
>  obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o headsmp.o
>  # i.MX6SL reuses i.MX6Q code
>  obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o headsmp.o
> -endif
> 
>  # i.MX5 based machines
>  obj-$(CONFIG_MACH_MX51_BABBAGE) += mach-mx51_babbage.o
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index 59c3b9b..baf439d 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -144,13 +144,11 @@ void imx6q_set_chicken_bit(void);
>  void imx_cpu_die(unsigned int cpu);
>  int imx_cpu_kill(unsigned int cpu);
> 
> -#ifdef CONFIG_PM
>  void imx6q_pm_init(void);
>  void imx6q_pm_set_ccm_base(void __iomem *base);
> +#ifdef CONFIG_PM
>  void imx5_pm_init(void);
>  #else
> -static inline void imx6q_pm_init(void) {}
> -static inline void imx6q_pm_set_ccm_base(void __iomem *base) {}
>  static inline void imx5_pm_init(void) {}
>  #endif
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
