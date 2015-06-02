From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Jun 2015 11:33:39 +0800
Subject: [GIT PULL 3/4] ARM: imx: device tree changes for 4.2
In-Reply-To: <CAOMZO5Co4w7AU7xLP1yq5gqkO0H8RdkxGSvoK-=62m62LEDkJg@mail.gmail.com>
References: <1433145206-2508-1-git-send-email-shawn.guo@linaro.org>
 <1433145206-2508-3-git-send-email-shawn.guo@linaro.org>
 <3918834.Y7ttkc5iBm@wuerfel>
 <CAOMZO5Co4w7AU7xLP1yq5gqkO0H8RdkxGSvoK-=62m62LEDkJg@mail.gmail.com>
Message-ID: <20150602033337.GA7571@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 01:52:53PM -0300, Fabio Estevam wrote:
> > Also, could you fold this change into the patch that moves the gpt driver?
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 3c15a49fdac9..fd43dbb5e47b 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -278,7 +278,7 @@ config CLKSRC_PXA
> >
> >  config CLKSRC_IMX_GPT
> >         bool "Clocksource using i.MX GPT" if COMPILE_TEST
> > -       depends on OF
> > +       depends on OF && COMMON_CLK
> >         select CLKSRC_MMIO
> >
> >  config H8300_TMR16
> >
> > Without this, we get build errors for COMPILE_TEST.
> 
> Shouldn't it be like this instead?
> 
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -278,7 +278,7 @@ config CLKSRC_PXA
> 
>  config CLKSRC_IMX_GPT
>         bool "Clocksource using i.MX GPT" if COMPILE_TEST
> -       depends on OF
> +       select CLKSRC_OF if OF
>         select CLKSRC_MMIO

I just received a message [1] from Stephen which reports the build
failures on powerpc allyesconfig.  Basically, the errors are around the
following 3 things.

 1) delay_timer
 2) clk_get_sys
 3) SZ_4K

The 1) is an ARM specific implementation, so we need to depend on ARM.
For 2), clk_get_sys() is only available with CLKDEV_LOOKUP.  I can
understand that Arnd's change can help fix it, as COMMON_CLK indirectly
selects CLKDEV_LOOKUP.  But I'm not sure how CLKSRC_OF selecting is
going to help.  From compile test point of view, CLKSRC_OF is not
mandatory, since there is a stub clocksource_of_init() in
include/linux/clocksource.h for !CONFIG_CLKSRC_OF.  For 3), we need
the header include/linux/sizes.h.  It doesn't expose on ARM, and should
be fixed by a separate patch anyway.

[1] https://lkml.org/lkml/2015/6/1/328

So here is my changes to fix all the errors reported by Stephen, except
'SZ_4K' one.  Let me know if it's preferred or we'd like to drop
COMPILE_TEST and simply depend on ARCH_MXC.

------8<--------------

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 139a20795073..618102e5aa2a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -261,7 +261,7 @@ config CLKSRC_PXA
 
 config CLKSRC_IMX_GPT
        bool "Clocksource using i.MX GPT" if COMPILE_TEST
-       depends on OF
+       depends on ARM && CLKDEV_LOOKUP
        select CLKSRC_MMIO
 
 endmenu
