From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 20 Jul 2012 08:45:41 +0200
Subject: [PATCH V2 1/7] ARM: SAMSUNG: add additional registers and SFR
 definitions for writeback
In-Reply-To: <CAL1wa8f0NOF+K4Z-6w6Aue_L2x_1-5HaXWu9t8QDaDY9SCW-Cw@mail.gmail.com>
References: <1342591053-7092-1-git-send-email-l.krishna@samsung.com>
 <1342591053-7092-2-git-send-email-l.krishna@samsung.com>
 <009c01cd64b1$bd3a8390$37af8ab0$%szyprowski@samsung.com>
 <CAL1wa8f0NOF+K4Z-6w6Aue_L2x_1-5HaXWu9t8QDaDY9SCW-Cw@mail.gmail.com>
Message-ID: <018d01cd6643$4af7fae0$e0e7f0a0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, July 19, 2012 2:44 PM Leela Krishna Amudala

> Hello Marek,
> 
> On Wed, Jul 18, 2012 at 12:21 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > Hello,
> >
> > On Wednesday, July 18, 2012 7:57 AM Leela Krishna Amudala wrote:
> >
> >> This patch updates the register address offsets and adds SFR definitions
> >> for writeback for Samsung's V8 display controller.
> >>
> >> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> >> ---
> >>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h |   10 ++++
> >>  arch/arm/plat-samsung/include/plat/regs-fb.h    |   51 +++++++++++++++++++++++
> >>  drivers/video/Kconfig                           |    6 +++
> >>  3 files changed, 67 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/plat-samsung/include/plat/regs-fb-v4.h b/arch/arm/plat-
> >> samsung/include/plat/regs-fb-v4.h
> >> index 4c3647f..1639c17 100644
> >> --- a/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
> >> +++ b/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
> >> @@ -30,9 +30,16 @@
> >>  #define VIDCON1_FSTATUS_EVEN (1 << 15)
> >>
> >>  /* Video timing controls */
> >> +#ifdef CONFIG_FB_EXYNOS_FIMD_V8
> >> +#define VIDTCON0                                (0x20010)
> >> +#define VIDTCON1                                (0x20014)
> >> +#define VIDTCON3                                (0x2001C)
> >> +#else
> >>  #define VIDTCON0                             (0x10)
> >>  #define VIDTCON1                             (0x14)
> >>  #define VIDTCON2                             (0x18)
> >> +#define VIDTCON3                             (0x1C)
> >> +#endif
> >>
> >>  /* Window position controls */
> >>
> >> @@ -43,9 +50,12 @@
> >>  #define VIDOSD_BASE                          (0x40)
> >>
> >>  #define VIDINTCON0                           (0x130)
> >> +#define VIDINTCON1                              (0x134)
> >>
> >>  /* WINCONx */
> >>
> >> +#define WINCONx_CSC_CON_EQ709                   (1 << 28)
> >> +#define WINCONx_CSC_CON_EQ601                   (0 << 28)
> >>  #define WINCONx_CSCWIDTH_MASK                        (0x3 << 26)
> >>  #define WINCONx_CSCWIDTH_SHIFT                       (26)
> >>  #define WINCONx_CSCWIDTH_WIDE                        (0x0 << 26)
> >> diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/arch/arm/plat-
> >> samsung/include/plat/regs-fb.h
> >> index 9a78012..6d2ee16 100644
> >> --- a/arch/arm/plat-samsung/include/plat/regs-fb.h
> >> +++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
> >> @@ -32,12 +32,28 @@
> >>
> >>  #define VIDCON0                                      (0x00)
> >>  #define VIDCON0_INTERLACE                    (1 << 29)
> >> +
> >> +#ifdef CONFIG_FB_EXYNOS_FIMD_V8
> >> +#define VIDOUT_CON                           (0x20000)
> >> +#define VIDOUT_CON_VIDOUT_UP_MASK            (0x1 << 16)
> >> +#define VIDOUT_CON_VIDOUT_UP_SHIFT           (16)
> >> +#define VIDOUT_CON_VIDOUT_UP_ALWAYS          (0x0 << 16)
> >> +#define VIDOUT_CON_VIDOUT_UP_START_FRAME     (0x1 << 16)
> >> +#define VIDOUT_CON_VIDOUT_F_MASK             (0x7 << 8)
> >> +#define VIDOUT_CON_VIDOUT_F_SHIFT            (8)
> >> +#define VIDOUT_CON_VIDOUT_F_RGB                      (0x0 << 8)
> >> +#define VIDOUT_CON_VIDOUT_F_I80_LDI0         (0x2 << 8)
> >> +#define VIDOUT_CON_VIDOUT_F_I80_LDI1         (0x3 << 8)
> >> +#define VIDOUT_CON_VIDOUT_F_WB                       (0x4 << 8)
> >> +#endif
> >> +
> >>  #define VIDCON0_VIDOUT_MASK                  (0x3 << 26)
> >>  #define VIDCON0_VIDOUT_SHIFT                 (26)
> >>  #define VIDCON0_VIDOUT_RGB                   (0x0 << 26)
> >>  #define VIDCON0_VIDOUT_TV                    (0x1 << 26)
> >>  #define VIDCON0_VIDOUT_I80_LDI0                      (0x2 << 26)
> >>  #define VIDCON0_VIDOUT_I80_LDI1                      (0x3 << 26)
> >> +#define VIDCON0_VIDOUT_WB                       (0x4 << 26)
> >>
> >>  #define VIDCON0_L1_DATA_MASK                 (0x7 << 23)
> >>  #define VIDCON0_L1_DATA_SHIFT                        (23)
> >> @@ -81,7 +97,13 @@
> >>  #define VIDCON0_ENVID                                (1 << 1)
> >>  #define VIDCON0_ENVID_F                              (1 << 0)
> >>
> >> +#ifdef CONFIG_FB_EXYNOS_FIMD_V8
> >> +#define VIDOUT_CON                              (0x20000)
> >> +#define VIDCON1                                 (0x20004)
> >> +#else
> >>  #define VIDCON1                                      (0x04)
> >> +#endif
> >> +
> >>  #define VIDCON1_LINECNT_MASK                 (0x7ff << 16)
> >>  #define VIDCON1_LINECNT_SHIFT                        (16)
> >>  #define VIDCON1_LINECNT_GET(_v)                      (((_v) >> 16) & 0x7ff)
> >> @@ -111,6 +133,14 @@
> >>  #define VIDCON2_TVFMTSEL1_RGB                        (0x0 << 12)
> >>  #define VIDCON2_TVFMTSEL1_YUV422             (0x1 << 12)
> >>  #define VIDCON2_TVFMTSEL1_YUV444             (0x2 << 12)
> >> +#define VIDCON2_TVFMTSEL1_SHIFT                      (12)
> >> +#define VIDCON2_TVFMTSEL_SW                  (1 << 14)
> >> +#define VIDCON2_TVFORMATSEL_YUV444           (0x2 << 12)
> >> +
> >> +#define VIDCON2_TVFMTSEL1_MASK                       (0x3 << 12)
> >> +#define VIDCON2_TVFMTSEL1_RGB                        (0x0 << 12)
> >> +#define VIDCON2_TVFMTSEL1_YUV422             (0x1 << 12)
> >> +#define VIDCON2_TVFMTSEL1_YUV444             (0x2 << 12)
> >>
> >>  #define VIDCON2_ORGYCbCr                     (1 << 8)
> >>  #define VIDCON2_YUVORDCrCb                   (1 << 7)
> >> @@ -165,8 +195,15 @@
> >>  #define VIDTCON1_HSPW_SHIFT                  (0)
> >>  #define VIDTCON1_HSPW_LIMIT                  (0xff)
> >>  #define VIDTCON1_HSPW(_x)                    ((_x) << 0)
> >> +#define VIDCON1_VCLK_MASK                       (0x3 << 9)
> >> +#define VIDCON1_VCLK_HOLD                       (0x0 << 9)
> >> +#define VIDCON1_VCLK_RUN                        (0x1 << 9)
> >>
> >> +#ifdef CONFIG_FB_EXYNOS_FIMD_V8
> >> +#define VIDTCON2                             (0x20018)
> >> +#else
> >>  #define VIDTCON2                             (0x18)
> >> +#endif
> >>  #define VIDTCON2_LINEVAL_E(_x)                       ((((_x) & 0x800) >> 11) << 23)
> >>  #define VIDTCON2_LINEVAL_MASK                        (0x7ff << 11)
> >>  #define VIDTCON2_LINEVAL_SHIFT                       (11)
> >> @@ -186,6 +223,9 @@
> >>  #define WINCONx_BYTSWP                               (1 << 17)
> >>  #define WINCONx_HAWSWP                               (1 << 16)
> >>  #define WINCONx_WSWP                         (1 << 15)
> >> +#define WINCONx_ENLOCAL_MASK                 (0xf << 15)
> >> +#define WINCONx_INRGB_RGB                    (0 << 13)
> >> +#define WINCONx_INRGB_YCBCR                  (1 << 13)
> >>  #define WINCONx_BURSTLEN_MASK                        (0x3 << 9)
> >>  #define WINCONx_BURSTLEN_SHIFT                       (9)
> >>  #define WINCONx_BURSTLEN_16WORD                      (0x0 << 9)
> >> @@ -205,6 +245,7 @@
> >>  #define WINCON0_BPPMODE_24BPP_888            (0xb << 2)
> >>
> >>  #define WINCON1_BLD_PIX                              (1 << 6)
> >> +#define WINCON1_BLD_PLANE                    (0 << 6)
> >>
> >>  #define WINCON1_ALPHA_SEL                    (1 << 1)
> >>  #define WINCON1_BPPMODE_MASK                 (0xf << 2)
> >> @@ -395,9 +436,19 @@
> >>  #define WPALCON_W0PAL_16BPP_A555             (0x5 << 0)
> >>  #define WPALCON_W0PAL_16BPP_565                      (0x6 << 0)
> >>
> >> +/* Clock gate mode control */
> >> +#define REG_CLKGATE_MODE                     (0x1b0)
> >> +#define REG_CLKGATE_MODE_AUTO_CLOCK_GATE     (0 << 0)
> >> +#define REG_CLKGATE_MODE_NON_CLOCK_GATE              (1 << 0)
> >> +
> >>  /* Blending equation control */
> >>  #define BLENDCON                             (0x260)
> >>  #define BLENDCON_NEW_MASK                    (1 << 0)
> >>  #define BLENDCON_NEW_8BIT_ALPHA_VALUE                (1 << 0)
> >>  #define BLENDCON_NEW_4BIT_ALPHA_VALUE                (0 << 0)
> >>
> >> +/* Window alpha control */
> >> +#define VIDW0ALPHA0                          (0x200)
> >> +#define VIDW0ALPHA1                          (0x204)
> >> +#define DPCLKCON                             (0x27c)
> >> +#define DPCLKCON_ENABLE                              (1 << 1)
> >> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> >> index 0217f74..f81bf55 100644
> >> --- a/drivers/video/Kconfig
> >> +++ b/drivers/video/Kconfig
> >> @@ -2053,6 +2053,12 @@ config FB_S3C
> >>
> >>         Currently the support is only for the S3C6400 and S3C6410 SoCs.
> >>
> >> +config FB_EXYNOS_FIMD_V8
> >> +     bool "register extensions for FIMD version 8"
> >> +     depends on ARCH_EXYNOS5
> >> +     ---help---
> >> +     This uses register extensions for FIMD version 8
> >> +
> >>  config FB_S3C_DEBUG_REGWRITE
> >>         bool "Debug register writes"
> >>         depends on FB_S3C
> >
> > Do we really need these defines in arch/arm/plat-samsung/include/plat/regs-fb* ?
> > IMHO they should be moved from arch/arm to drivers/video to live together with the driver.
> > They are not a part of core platform code. I thought that there have been some patches
> > cleaning up regs-fb mess a long time ago, but it looks they didn't get their way to
> > mainline.
> >
> 
> The defines I had given in these headers are specific to exynos5
> platform and are using by both drm-fimd and
> s3c-fb. I'm not understanding the need to move these defines from
> arch/arm to drivers/video. Can you please tell me why we have to do
> that.

These defines are not the part of the Samsung platform core, they are used only by the
device drivers. There is no point bloating arch/arm directory with the defines used
only by the device drivers. If they are shared between 2 drivers then /include/video
might be a good place for them.

I'm not really sure if we really need to add another Kconfig for adding support for
V8 of fimd device. There is already runtime support for different variants of the
fimd hw block varing from s3c-2443 to exynos4 based on the platform device name (see 
s3c_fb_driver_ids in drivers/video/s3c-fb.c). Another variant for exynos5 looks like 
a cleaner approach.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
