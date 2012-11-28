From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Nov 2012 14:23:09 +0900
Subject: [PATCH] ARM: EXYNOS: Avoid early use of of_machine_is_compatible()
In-Reply-To: <CAOesGMivs=NA6hcTYWO-MWUeUjVGZ0h258z1MpeexXGtVf9h-g@mail.gmail.com>
References: <1354045994-8977-1-git-send-email-dianders@chromium.org>
 <CAOesGMjyXZwKjycyVcEV0ty0LCM_i61QxykYPhAvXxx2rhgP+A@mail.gmail.com>
 <50B53E37.40303@samsung.com>
 <CAOesGMivs=NA6hcTYWO-MWUeUjVGZ0h258z1MpeexXGtVf9h-g@mail.gmail.com>
Message-ID: <18d701cdcd28$74198d70$5c4ca850$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Tue, Nov 27, 2012 at 2:27 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > On 11/28/12 07:11, Olof Johansson wrote:
> >>
> >> On Tue, Nov 27, 2012 at 11:53 AM, Doug Anderson<dianders@chromium.org>
> >> wrote:
> >>>
> >>> The recent commit "ARM: EXYNOS: add support for EXYNOS5440 SoC" broke
> >>> support for exynos5250 because of_machine_is_compatible() was used too
> >>> early in the boot process.  It also probably meant that the exynos5440
> >>> failed to use the proper iotable.  Switch to use
> >>> of_flat_dt_is_compatible() in both of these cases.
> >>>
> >>> The failure I was seeing in exynos5250 because of this was:
> >>>    Division by zero in kernel.
> >>>    [<80015ed4>] (unwind_backtrace+0x0/0xec) from [<8045c7a4>]
> >>> (dump_stack+0x20/0x24)
> >>>    [<8045c7a4>] (dump_stack+0x20/0x24) from [<80012990>]
> >>> (__div0+0x20/0x28)
> >>>    [<80012990>] (__div0+0x20/0x28) from [<8021ab04>]
(Ldiv0_64+0x8/0x18)
> >>>    [<8021ab04>] (Ldiv0_64+0x8/0x18) from [<80068560>]
> >>> (__clocksource_updatefreq_scale+0x54/0x134)
> >>>    [<80068560>] (__clocksource_updatefreq_scale+0x54/0x134) from
> >>> [<8006865c>] (__clocksource_register_scale+0x1c/0x54)
> >>>    [<8006865c>] (__clocksource_register_scale+0x1c/0x54) from
> >>> [<80612a18>] (exynos_timer_init+0x100/0x1e8)
> >>>    [<80612a18>] (exynos_timer_init+0x100/0x1e8) from [<8060d184>]
> >>> (time_init+0x28/0x38)
> >>>    [<8060d184>] (time_init+0x28/0x38) from [<8060a754>]
> >>> (start_kernel+0x1e0/0x3c8)
> >>>    [<8060a754>] (start_kernel+0x1e0/0x3c8) from [<40008078>]
> (0x40008078)
> >>>
> >>> Signed-off-by: Doug Anderson<dianders@chromium.org>
> >>
> >>
> >> Thanks Doug.
> >>
> >> Kukjin, I'll apply this directly on top of the previous branch in
> >> arm-soc, if that's OK with you.
> >>
> > Sure, go ahead with my ack if you want,
> >
> > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> >
> > Note, actually there was a fix which uses soc_is_exynos5440() in my
> local
> > :-) I'm not sure which one is better at this moment, but I'm OK on this.
> 
> Ok, applied. Thanks all.
> 
Olof, just note, happens build error with exynos4_defconfig because of
non-DT.

Following can resolve it or we should create null function for
of_get_flat_dt_root() and of_flat_dt_is_compatible()...

8<---------------------------------------
From: Kukjin Kim <kgene.kim@samsung.com>
Subject: ARM: EXYNOS: fix a build error with non-DT for exynos4

This fixes following in case of non-DT:
arch/arm/mach-exynos/common.c: In function 'exynos_init_io':
arch/arm/mach-exynos/common.c:339: error: implicit declaration of function
'of_get_flat_dt_root'
arch/arm/mach-exynos/common.c:342: error: implicit declaration of function
'of_flat_dt_is_compatible'
make[1]: *** [arch/arm/mach-exynos/common.o] Error 1

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index b919f5f..2110091 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -336,12 +336,14 @@ void __init exynos_init_late(void)

 void __init exynos_init_io(struct map_desc *mach_desc, int size)
 {
+#ifdef CONFIG_OF
 	unsigned long root = of_get_flat_dt_root();

 	/* initialize the io descriptors we need for initialization */
 	if (of_flat_dt_is_compatible(root, "samsung,exynos5440"))
 		iotable_init(exynos5440_iodesc,
ARRAY_SIZE(exynos5440_iodesc));
 	else
+#endif
 		iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));

 	if (mach_desc)
8<---------------------------------------

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
