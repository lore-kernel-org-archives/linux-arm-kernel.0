From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Sep 2017 16:24:14 +0200
Subject: [PATCH] soc: bcm: brcmstb: fix ARM build errors
In-Reply-To: <20170907135136.2923775-1-arnd@arndb.de>
References: <20170907135136.2923775-1-arnd@arndb.de>
Message-ID: <CAK8P3a3M+fOkr7nfPOu7wPR77-9r=TTSXYqeKtmT7HQx7gV1Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 7, 2017 at 3:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> When building the new PM driver on older ARM architectures, we can
> run into one of two build errors:
>
> drivers/soc/bcm/brcmstb/pm/pm-arm.c: In function 'brcmstb_do_pmsm_power_down':
> drivers/soc/bcm/brcmstb/pm/pm-arm.c:334:2: error: implicit declaration of function 'wfi' [-Werror=implicit-function-declaration]
>
> drivers/soc/bcm/brcmstb/pm/pm-arm.o: In function `brcmstb_pm_s3_finish':
> pm-arm.c:(.text+0x860): undefined reference to `cpu_resume'
>
> The first one requires at least ARMv6K, the second one requires the CPU
> suspend/resume logic which is not available on some of the older CPUs,
> and needs to be selected explicitly.
>
> This adds the extra Kconfig statements to enforce this, limiting
> compilation on ARM to the STB platform that is guaranteed to be
> ARMv7. We could enable compile-testing for other ARMv7 platforms,
> but there seems to be little value as an allmodconfig kernel
> already includes it.
>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

It seems we always compile the pm/ subdirectory regardless of CONFIG_BRCMSTB_PM,
so we also needs this change:

--- a/drivers/soc/bcm/brcmstb/Makefile
+++ b/drivers/soc/bcm/brcmstb/Makefile
@@ -1,2 +1,2 @@
 obj-y                          += common.o biuctrl.o
-obj-y                          += pm/
+obj-$(CONFIG_BRCMSTB_PM)       += pm/

I'll resubmit the combined patch after some more testing.

        Arnd
