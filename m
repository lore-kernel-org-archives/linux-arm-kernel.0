From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 23 Feb 2011 17:17:06 +0900
Subject: [PATCH] ARM: EXYNOS4: Fix wrong constants in the hotplug assembly
	code.
In-Reply-To: <AANLkTinpjGwd+pFr1oKQb1jiaih2h81Wp9G7Df8J1LLk@mail.gmail.com>
References: <1298444621-3739-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTinpjGwd+pFr1oKQb1jiaih2h81Wp9G7Df8J1LLk@mail.gmail.com>
Message-ID: <01e901cbd332$12a09350$37e1b9f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> Hi,
> 
Hi :)

> At that time Russell modified the s5cv310, tegra, and realview also. I
> think you also modify it.
> 
Maybe you mean commit 30b99d07 (ARM: fix wrongly patched constants).
It was due to his patch commit e3d9c625 (ARM: CPU hotplug: fix hard-coded
control register constants) but this is different with that.
Firstly this patch fixes wrong constants in the hotplug assembly code.
Then secondly, fixes hard-coded control register constants.

Of course, first reason is more important on this.
And I'm not sure whether need to fix on tegra also.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> On Wed, Feb 23, 2011 at 4:03 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > This patch fixes wrong constants in the hotplug assembly code for
> > Exynos4 such as Russell's changing in vexpress hotplug and fixes
> > hard-coded control register constatns also.
> >
> > Reported-by: Changhwan Youn <chaos.youn@samsung.com>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > ?arch/arm/mach-exynos4/hotplug.c | ? ?8 ++++----
> > ?1 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos4/hotplug.c b/arch/arm/mach-
> exynos4/hotplug.c
> > index 4c42f9c..2b5909e 100644
> > --- a/arch/arm/mach-exynos4/hotplug.c
> > +++ b/arch/arm/mach-exynos4/hotplug.c
> > @@ -30,13 +30,13 @@ static inline void cpu_enter_lowpower(void)
> > ? ? ? ? * Turn off coherency
> > ? ? ? ? */
> > ? ? ? ?" ? ? ? mrc ? ? p15, 0, %0, c1, c0, 1\n"
> > - ? ? ? " ? ? ? bic ? ? %0, %0, #0x20\n"
> > + ? ? ? " ? ? ? bic ? ? %0, %0, %3\n"
> > ? ? ? ?" ? ? ? mcr ? ? p15, 0, %0, c1, c0, 1\n"
> > ? ? ? ?" ? ? ? mrc ? ? p15, 0, %0, c1, c0, 0\n"
> > ? ? ? ?" ? ? ? bic ? ? %0, %0, %2\n"
> > ? ? ? ?" ? ? ? mcr ? ? p15, 0, %0, c1, c0, 0\n"
> > ? ? ? ? ?: "=&r" (v)
> > - ? ? ? ? : "r" (0), "Ir" (CR_C)
> > + ? ? ? ? : "r" (0), "Ir" (CR_C), "Ir" (0x40)
> > ? ? ? ? ?: "cc");
> > ?}
> >
> > @@ -49,10 +49,10 @@ static inline void cpu_leave_lowpower(void)
> > ? ? ? ?" ? ? ? orr ? ? %0, %0, %1\n"
> > ? ? ? ?" ? ? ? mcr ? ? p15, 0, %0, c1, c0, 0\n"
> > ? ? ? ?" ? ? ? mrc ? ? p15, 0, %0, c1, c0, 1\n"
> > - ? ? ? " ? ? ? orr ? ? %0, %0, #0x20\n"
> > + ? ? ? " ? ? ? orr ? ? %0, %0, %2\n"
> > ? ? ? ?" ? ? ? mcr ? ? p15, 0, %0, c1, c0, 1\n"
> > ? ? ? ? ?: "=&r" (v)
> > - ? ? ? ? : "Ir" (CR_C)
> > + ? ? ? ? : "Ir" (CR_C), "Ir" (0x40)
> > ? ? ? ? ?: "cc");
> > ?}
> >
> > --
> > 1.7.1
