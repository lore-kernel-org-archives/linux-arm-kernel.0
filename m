From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 17 Sep 2010 09:57:16 +0900
Subject: [PATCH 1/5] ARM: S5PV310: Add HSMMC support and SDHCI
	configuration
In-Reply-To: <AANLkTi=Vx42siGBno7sLrirCRSiMvEr=2-toHHYU7405@mail.gmail.com>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
	<1284626223-18944-2-git-send-email-jeongbae.seo@samsung.com>
	<AANLkTi=Vx42siGBno7sLrirCRSiMvEr=2-toHHYU7405@mail.gmail.com>
Message-ID: <039f01cb5603$49205f20$db611d60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Thu, Sep 16, 2010 at 5:36 PM, Jeongbae Seo <jeongbae.seo@samsung.com>
> wrote:
> > From: Hyuk Lee <hyuk1.lee@samsung.com>
> >
> > This patch adds to support HSMMC for S5PV310 and S5PC210 and setup for
> > HSMMC host controller and also related GPIO.
> > At most 4 channel can be used at the same time.
> > A user can configure SDHCI data bus as 8bit or 4bit.
> >
> > Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> > Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> > ---
> > ?arch/arm/mach-s5pv310/Kconfig ? ? ? ? ? ?| ? 39 ++++++++
> > ?arch/arm/mach-s5pv310/Makefile ? ? ? ? ? | ? ?2 +
> > ?arch/arm/mach-s5pv310/setup-sdhci-gpio.c | ?156
> ++++++++++++++++++++++++++++++
> > ?arch/arm/mach-s5pv310/setup-sdhci.c ? ? ?| ? 69 +++++++++++++
> > ?4 files changed, 266 insertions(+), 0 deletions(-)
> > ?create mode 100644 arch/arm/mach-s5pv310/setup-sdhci-gpio.c
> > ?create mode 100644 arch/arm/mach-s5pv310/setup-sdhci.c
> >
> > diff --git a/arch/arm/mach-s5pv310/Kconfig
b/arch/arm/mach-s5pv310/Kconfig
> > index 9ac29fe..6a07968 100644
> > --- a/arch/arm/mach-s5pv310/Kconfig
> > +++ b/arch/arm/mach-s5pv310/Kconfig
> > @@ -25,6 +25,17 @@ config S5PV310_SETUP_I2C2
> > ? ? ? ?help
> > ? ? ? ? ?Common setup code for i2c bus 2.
> >
> > +config S5PV310_SETUP_SDHCI
> > + ? ? ? bool
> > + ? ? ? select S5PV310_SETUP_SDHCI_GPIO
> > + ? ? ? help
> > + ? ? ? ? Internal helper functions for S5PV310 based SDHCI systems.
> > +
> > +config S5PV310_SETUP_SDHCI_GPIO
> > + ? ? ? bool
> > + ? ? ? help
> > + ? ? ? ? Common setup code for SDHCI gpio.
> > +
> > ?# machine support
> >
> > ?menu "S5PC210 Machines"
> > @@ -33,6 +44,11 @@ config MACH_SMDKC210
> > ? ? ? ?bool "SMDKC210"
> > ? ? ? ?select CPU_S5PV310
> > ? ? ? ?select ARCH_SPARSEMEM_ENABLE
> > + ? ? ? select S3C_DEV_HSMMC
> > + ? ? ? select S3C_DEV_HSMMC1
> > + ? ? ? select S3C_DEV_HSMMC2
> > + ? ? ? select S3C_DEV_HSMMC3
> > + ? ? ? select S5PV310_SETUP_SDHCI
> > ? ? ? ?help
> > ? ? ? ? ?Machine support for Samsung SMDKC210
> > ? ? ? ? ?S5PC210(MCP) is one of package option of S5PV310
> > @@ -53,9 +69,32 @@ config MACH_SMDKV310
> > ? ? ? ?bool "SMDKV310"
> > ? ? ? ?select CPU_S5PV310
> > ? ? ? ?select ARCH_SPARSEMEM_ENABLE
> > + ? ? ? select S3C_DEV_HSMMC
> > + ? ? ? select S3C_DEV_HSMMC1
> > + ? ? ? select S3C_DEV_HSMMC2
> > + ? ? ? select S3C_DEV_HSMMC3
> > + ? ? ? select S5PV310_SETUP_SDHCI
> > ? ? ? ?help
> > ? ? ? ? ?Machine support for Samsung SMDKV310
> >
> > ?endmenu
> >
> > +comment "Configuration for HSMMC bus width"
> > +
> > +menu "Use 8-bit bus width"
> > +
> > +config S5PV310_SDHCI_CH0_8BIT
> > + ? ? ? bool "Channel 0 with 8-bit bus"
> > + ? ? ? help
> > + ? ? ? ? Support HSMMC Channel 0 8-bit bus.
> > + ? ? ? ? If selected, Channel 1 is disabled.
> > +
> > +config S5PV310_SDHCI_CH2_8BIT
> > + ? ? ? bool "Channel 2 with 8-bit bus"
> > + ? ? ? help
> > + ? ? ? ? Support HSMMC Channel 2 8-bit bus.
> > + ? ? ? ? If selected, Channel 3 is disabled.
> 
> I think it's not needed since most boards have fixed bandwith and
> cfg_gpio handle it regardless these configuration.
> Also we use the select state if needed, e.g., when MMC0 uses
> 8-buswidth then don't select MMC1.
> I saw the SMDK board use this configuration. but just choose bandwidth 4
or 8.
> 
Hmm...

If it can be supported 4bit or 8bit option on each board, should be added
above configuration for selecting it.

Mr. Seo, it would be nice if you could add un-selection CH1 or CH3 when
selecting 8bit support later.

Anyway, looks ok to me now..will apply.

> Others good.
> 
(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
