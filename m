From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 May 2014 15:39:15 +0200
Subject: [RESEND PATCH v5 3/5] ARM: Conceal DEBUG_LL_UART_NONE from
 unsupported platforms
In-Reply-To: <5013253.K6sZTxep7b@wuerfel>
References: <1398355246-29571-1-git-send-email-daniel.thompson@linaro.org>
 <1400857819-7975-4-git-send-email-daniel.thompson@linaro.org>
 <5013253.K6sZTxep7b@wuerfel>
Message-ID: <6624276.NBS809VbNB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 May 2014 17:35:34 Arnd Bergmann wrote:
> On Friday 23 May 2014 16:10:17 Daniel Thompson wrote:
> > Only a small handful of platforms support DEBUG_LL_UART_NONE but it
> > lurks in the menus of every single platform config ready to break the
> > build. This is an especial problem for defconfigs since it is often
> > selected by default.
> > 
> > This patch limit this choice only to platforms capable of supporting it.
> > 
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  arch/arm/Kconfig.debug | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index eab8ecb..4c8d7db 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -842,7 +842,18 @@ choice
> >  
> >       config DEBUG_LL_UART_NONE
> >               bool "No low-level debugging UART"
> > -             depends on !ARCH_MULTIPLATFORM
> > +             depends on ARCH_AT91 || \
> > +                     ARCH_CLPS711X || \
> > +                     ARCH_FOOTBRIDGE || \
> > +                     ARCH_KS8695 || \
> > +                     ARCH_NETX || \
> > +                     ARCH_OMAP1 || \
> > +                     ARCH_SA1100 || \
> > +                     ARCH_S3C24XX || \
> > +                     ARCH_S3C64XX || \
> > +                     ARCH_S5P64X0 || \
> > +                     ARCH_S5PC100 || \
> > +                     ARCH_S5PV210
> >               help
> >                 Say Y here if your platform doesn't provide a UART option
> >                 above. This relies on your platform choosing the right UART
> 
> ARCH_S3C24XX has been moved over in linux-next to use debug/s3c24xx.S.
> A few others will likely move soon (AT91, CLPS711x, S5PV210), as the
> platforms get moved to ARCH_MULTIPLATFORM.
> 
> As an alternative to your patch, we could decide to move the remaining
> files as well.

Follow-up: I also noticed that AT91, CLPS711X, FOOTBRIDGE and all the SAMSUNG
platforms already have an entry in the list, so DEBUG_LL_UART_NONE is redundant
for them. The below change should be enough.

For AT91 this is actually better because the old AT91X40 support doesn't
have working DEBUG_LL support. This gets handled correctly by 
AT91_DEBUG_LL_DBGU0/AT91_DEBUG_LL_DBGU1, but not DEBUG_LL_UART_NONE.

	Arnd

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index fd127d6..cae828a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -864,7 +864,8 @@ choice
 
 	config DEBUG_LL_UART_NONE
 		bool "No low-level debugging UART"
-		depends on !ARCH_MULTIPLATFORM
+		depends on ARCH_KS8695 || ARCH_NETX || ARCH_OMAP1 || ARCH_SA1100
 		help
 		  Say Y here if your platform doesn't provide a UART option
 		  above. This relies on your platform choosing the right UART
