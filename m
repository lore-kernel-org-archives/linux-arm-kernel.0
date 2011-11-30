From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 30 Nov 2011 12:08:18 +0000
Subject: [PATCH v3 0/5] Versatile Express DT support
In-Reply-To: <1322651640.3164.135.camel@hornet.cambridge.arm.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <20111129170013.GD2829@localhost.localdomain>
 <1322587019.3164.111.camel@hornet.cambridge.arm.com>
 <20111130104842.GA2045@localhost.localdomain>
 <1322651640.3164.135.camel@hornet.cambridge.arm.com>
Message-ID: <20111130120818.GB2045@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 11:14:00AM +0000, Pawel Moll wrote:
> On Wed, 2011-11-30 at 10:48 +0000, Dave Martin wrote:
> > Attached.  It's just vexpress_defconfig, plus ARCH_VEXPRESS_V2P_CA5S_CA9=y
> 
> Could you try that?
> 
> 8<----------------------------------------------
> diff --git a/arch/arm/mach-vexpress/Kconfig
> b/arch/arm/mach-vexpress/Kconfig
> index 9eb8161..ded66d0 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -11,7 +11,7 @@ config ARCH_VEXPRESS_CA9X4
>  
>  config ARCH_VEXPRESS_DT
>         bool
> -       select OF
> +       select USE_OF
>         help
>           VE platform *requiring* Flattened Device Tree to boot.
> 8<----------------------------------------------
> 
> The OF is an effect of the USE_OF, not the other way round, sorry about
> the mistake.
> 
> Of course I could go the "classic way" and make the
> ARCH_VEXPRESS_V2P_CA5S_CA9 dependant on the OF, but this means that the
> DT-powered tile would be invisible till one enables USE_OF. Any
> opinions?

Your suggestion fixes it -- I suggest we keep the config this way round;
this means that OF gets turned on when enabling a coretile which requires
it, and those coretiles are offered as choices even before OF is turned
on.  That feels like a sensible behaviour for the config.


While we're about this, building of the applicable dtbs is not currently
enabled.

Can we add this, so that "make dtbs" works?

diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
index 05b77a5..b89ffde 100644
--- a/arch/arm/mach-vexpress/Makefile.boot
+++ b/arch/arm/mach-vexpress/Makefile.boot
@@ -7,3 +7,7 @@ else
 params_phys-y	:= 0x60000100
 initrd_phys-y	:= 0x60800000
 endif
+
+dtb-$(CONFIG_ARCH_VEXPRESS_V2P_CA5S_CA9) += \
+					vexpress-v2p-ca5s.dtb \
+					vexpress-v2p-ca9.dtb

Cheers
---Dave
