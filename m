From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 7 Oct 2011 14:19:01 +0800
Subject: [PATCH 11/26] ARM: pxa: allow building palm27x without pxafb
In-Reply-To: <1317499438-14058-12-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-12-git-send-email-arnd@arndb.de>
Message-ID: <CAMPhdO_bKPxEEmBzSKvgYooG5YwweSYJVMdCxwYtQKJMyiWggg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 2, 2011 at 4:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The frame buffer device is defined conditionally on whether the
> driver is configured. However, the #ifdef guard around the
> declaration of palm27x_lcd_init also removes the visibility
> of the lcd mode declarations, which need to be available in
> order to build correctly, even if they are not defined in the
> end.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> ?arch/arm/mach-pxa/include/mach/palm27x.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/include/mach/palm27x.h b/arch/arm/mach-pxa/include/mach/palm27x.h
> index 0a5e5ea..030a916 100644
> --- a/arch/arm/mach-pxa/include/mach/palm27x.h
> +++ b/arch/arm/mach-pxa/include/mach/palm27x.h
> @@ -27,10 +27,10 @@ extern void __init palm27x_pm_init(unsigned long str_base);
> ?static inline void palm27x_pm_init(unsigned long str_base) {}
> ?#endif
>
> -#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
> ?extern struct pxafb_mode_info palm_320x480_lcd_mode;
> ?extern struct pxafb_mode_info palm_320x320_lcd_mode;
> ?extern struct pxafb_mode_info palm_320x320_new_lcd_mode;
> +#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
> ?extern void __init palm27x_lcd_init(int power,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct pxafb_mode_info *mode);
> ?#else
> --
> 1.7.5.4

Marek and I actually came up with a patch to fix this as below, this
way to cover the declarations of those modes in the CONFIG_FB_PXA
as well.

commit e227e88ae46e921f608b056e27e1d8704b7d12fa
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Sun Sep 11 16:56:58 2011 +0800

    ARM: pxa: fix building error by palm27x_lcd_init() when FB_PXA not defined

    Cc: Marek Vasut <marek.vasut@gmail.com>
    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/include/mach/palm27x.h
b/arch/arm/mach-pxa/include/mach/palm27x.h
index 0a5e5ea..f80bbe2 100644
--- a/arch/arm/mach-pxa/include/mach/palm27x.h
+++ b/arch/arm/mach-pxa/include/mach/palm27x.h
@@ -34,7 +34,7 @@ extern struct pxafb_mode_info palm_320x320_new_lcd_mode;
 extern void __init palm27x_lcd_init(int power,
 					struct pxafb_mode_info *mode);
 #else
-static inline void palm27x_lcd_init(int power, struct pxafb_mode_info *mode) {}
+#define palm27x_lcd_init(power, mode)	do {} while (0)
 #endif

 #if	defined(CONFIG_USB_GADGET_PXA27X) || \

>
>
