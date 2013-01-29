From: pavel@denx.de (Pavel Machek)
Date: Tue, 29 Jan 2013 19:43:41 +0100
Subject: [PATCHv1 for soc 5/5] arm: socfpga: Add SMP support for actual
 socfpga harware
In-Reply-To: <1359075633-13502-6-git-send-email-dinguyen@altera.com>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-6-git-send-email-dinguyen@altera.com>
Message-ID: <20130129184340.GA1962@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> index 9941caa..5b76dd4 100644
> --- a/arch/arm/mach-socfpga/core.h
> +++ b/arch/arm/mach-socfpga/core.h
> @@ -20,7 +20,7 @@
>  #ifndef __MACH_CORE_H
>  #define __MACH_CORE_H
>  
> -extern void secondary_startup(void);
> +extern void v7_secondary_startup(void);
>  extern void __iomem *socfpga_scu_base_addr;
>  

One more thing. v7_secondary_startup() may be too generic name for a
symbol. mach-imx already uses that.

Plus, mach-imx also has the useless #ifdef.

---

Remove useless #ifdef; headsmp.S is only compiled in CONFIG_SMP
configuration.

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
index 7e49deb..4c9ec06 100644
--- a/arch/arm/mach-imx/headsmp.S
+++ b/arch/arm/mach-imx/headsmp.S
@@ -64,12 +64,10 @@ ENTRY(v7_invalidate_l1)
 	mov	pc, lr
 ENDPROC(v7_invalidate_l1)
 
-#ifdef CONFIG_SMP
 ENTRY(v7_secondary_startup)
 	bl	v7_invalidate_l1
 	b	secondary_startup
 ENDPROC(v7_secondary_startup)
-#endif
 
 #ifdef CONFIG_PM
 /*


Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
