From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Sep 2011 15:01:30 +0900
Subject: [PATCH 2/5] ARM: SAMSUNG: Make the sleep code common for S3C64XX
	and newer SoCs
In-Reply-To: <CAM4voak5ArO4YW-bfLDoUFtMndV58thnr2Z4oCbPhD3fRPS1Cw@mail.gmail.com>
References: <1313144787-30666-1-git-send-email-a.kesavan@samsung.com>
	<1313144787-30666-3-git-send-email-a.kesavan@samsung.com>
	<073501cc6391$31569f70$9403de50$%kim@samsung.com>
	<CAM4voak5ArO4YW-bfLDoUFtMndV58thnr2Z4oCbPhD3fRPS1Cw@mail.gmail.com>
Message-ID: <000201cc6d23$973508e0$c59f1aa0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash Kesavan wrote:
> 
> Hi Mr Kim,
> 
> Thanks for your comments. Please find my reply below:
> 
> Regards,
> Abhilash
> 
> On Fri, Aug 26, 2011 at 7:10 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Abhilash Kesavan wrote:
> >>
> >> The sleep code for S5PV210 and EXYNOS4 is identical; moreover it is
quite
> >> similar
> >> to that for S3C64XX except for some SoC specific debug logic. S5P64X0
and
> >> S5PC100,
> >> for which support will be added soon, can also use the same procedure.
> > Create a
> >> common sleep code in the plat-samsung directory so that it can be
re-used.
> >>
> >> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> >> ---
> >> ?arch/arm/mach-exynos4/Kconfig ?| ? ?1 +
> >> ?arch/arm/mach-exynos4/Makefile | ? ?2 +-
> >> ?arch/arm/mach-exynos4/sleep.S ?| ? 54 ---------------------------
> >> ?arch/arm/mach-s3c64xx/Kconfig ?| ? ?1 +
> >> ?arch/arm/mach-s3c64xx/Makefile | ? ?1 -
> >> ?arch/arm/mach-s3c64xx/sleep.S ?| ? 72
> > ------------------------------------
> >> ?arch/arm/mach-s5pv210/Kconfig ?| ? ?1 +
> >> ?arch/arm/mach-s5pv210/Makefile | ? ?2 +-
> >> ?arch/arm/mach-s5pv210/sleep.S ?| ? 52 --------------------------
> >> ?arch/arm/plat-samsung/Kconfig ?| ? ?7 +++
> >> ?arch/arm/plat-samsung/Makefile | ? ?1 +
> >> ?arch/arm/plat-samsung/sleep.S ?| ? 80
> >> ++++++++++++++++++++++++++++++++++++++++
> >> ?12 files changed, 93 insertions(+), 181 deletions(-)
> >> ?delete mode 100644 arch/arm/mach-exynos4/sleep.S
> >> ?delete mode 100644 arch/arm/mach-s3c64xx/sleep.S
> >> ?delete mode 100644 arch/arm/mach-s5pv210/sleep.S
> >> ?create mode 100644 arch/arm/plat-samsung/sleep.S
> >>
> >
> > (snip)
> >
> >> +ENTRY(s3c_cpu_resume)
> >> +#if defined(CONFIG_S3C_PM_DEBUG_LED_SMDK)
> >> +
> >
> > Hi Abhilash,
> >
> > Yes, would be nice if each sleep.S can be handled in plat-samsung for
> > Samsung SoCs.
> >
> > Hmm...but the CONFIG_S3C_PM_DEBUG_LED_SMDK can be used on other
> SoCs for
> > same reason even though it is available only on S3C64XX now. I think, we
> > need to add SoC detecting here.
> Quite right, it is possible to use this for other SoCs. But as of now,
> my patch just intends
> to move all the sleep code to a common place. The S3C64XX sleep code
> has this feature
> and I didn't want to disturb it in anyway, hence it has been added to
> the common file.
> Perhaps, generalizing it for other SoCs can be done later on top of this

Hmm, this codes should be cleaned for all Samsung SoCs because this can
break one kernel image...

> >
> >> +#undef S3C64XX_VA_GPIO
> >> +#define S3C64XX_VA_GPIO (0x0)
> >
> > Please let me know why this is needed here.
> The code is trying to access the registers at a stage where the MMU is
> not enabled.
> Hence, the VA_GPIO is being re-defined as 0 reducing S3C64XX_GPIOREG(reg)
> to
> reg.
> It has been moved as is from the existing s3c64xx sleep code.


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
