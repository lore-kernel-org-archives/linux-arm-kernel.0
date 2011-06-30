From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Jun 2011 15:27:02 +0200
Subject: [PATCH] ARM: automatically select OMAP3_PMU if we try to use perf
	on OMAP3
In-Reply-To: <CAK5ve-LQcY6XQENBJw6JaarLffULA7EtjJMxCtpzhwPCfs2OuA@mail.gmail.com>
References: <1309268265-2685-1-git-send-email-bryan.wu@canonical.com>
	<20110628135706.GA28871@e102144-lin.cambridge.arm.com>
	<CAK5ve-LQcY6XQENBJw6JaarLffULA7EtjJMxCtpzhwPCfs2OuA@mail.gmail.com>
Message-ID: <201106301527.02528.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 June 2011, Bryan Wu wrote:
> On Tue, Jun 28, 2011 at 9:57 PM, Will Deacon <will.deacon@arm.com> wrote:

> >
> > This issue has been discussed on the list in the past and I still think that
> > it would be better for your config to select OMAP3_EMU explicitly. If we do
> > that here unconditionally then we end up also bringing in OC_ETM which isn't
> > something that sounds like a good idea (may have implications for power
> > consumption in production hardware?).
> >
> I quite understand your concern. How about this one?
> ----
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2fd0911..e53f9e4 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1084,10 +1084,10 @@ config XSCALE_PMU
>         default y
> 
>  config CPU_HAS_PMU
> -       depends on (CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU) && \
> -                  (!ARCH_OMAP3 || OMAP3_EMU)
> +       depends on CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU
>         default y
>         bool
> +       select OMAP3_EMU if (PERF_EVENTS && ARCH_OMAP3)
> 
>  config MULTI_IRQ_HANDLER
>         bool
> 

As far as I can tell, it still has the same issue. I think the existing
code is better. If you want to support HW_PERF_EVENTS on OMAP3, just
turn on OMAP3_EMU. Where's the problem with that?

In general, specifying clear dependencies is preferred over 'select'
statements, which are the equivalent to the 'comefrom' statement
in programming languages [1].

	Arnd

[1] http://en.wikipedia.org/wiki/COMEFROM
