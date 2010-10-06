From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 6 Oct 2010 17:48:21 +0900
Subject: [PATCH V2 2/3] ARM: S5PV310: Add HSMMC platform data
In-Reply-To: <1286344846-21244-3-git-send-email-jeongbae.seo@samsung.com>
References: <1286344846-21244-1-git-send-email-jeongbae.seo@samsung.com>
	<1286344846-21244-3-git-send-email-jeongbae.seo@samsung.com>
Message-ID: <AANLkTinj96jr4LWfqcQSZGSjw_az_z+-f9EBY8COdEXm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 6, 2010 at 3:00 PM, Jeongbae Seo <jeongbae.seo@samsung.com> wrote:
> From: Hyuk Lee <hyuk1.lee@samsung.com>
>
> This patch adds initialization HSMMC device information.
> And HSMMC platform data like card detect, data bus width
> and capability is configured.
>
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> ---
> Changes since v1:
> - Separated to board specific and common changes
> ?(This is for common part)
>
> ?arch/arm/mach-s5pv310/cpu.c ? ? ? ? ? ? ? ?| ? ?7 +++
> ?arch/arm/plat-samsung/include/plat/sdhci.h | ? 57 ++++++++++++++++++++++++++++
> ?2 files changed, 64 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
> index 225ca53..3345cf6 100644
> --- a/arch/arm/mach-s5pv310/cpu.c
> +++ b/arch/arm/mach-s5pv310/cpu.c
> @@ -19,6 +19,7 @@
> ?#include <plat/cpu.h>
> ?#include <plat/clock.h>
> ?#include <plat/s5pv310.h>
> +#include <plat/sdhci.h>
>
> ?#include <mach/regs-irq.h>
>
> @@ -88,6 +89,12 @@ static void s5pv310_idle(void)
> ?void __init s5pv310_map_io(void)
> ?{
> ? ? ? ?iotable_init(s5pv310_iodesc, ARRAY_SIZE(s5pv310_iodesc));
> +
> + ? ? ? /* initialize device information early */
> + ? ? ? s5pv310_default_sdhci0();
> + ? ? ? s5pv310_default_sdhci1();
> + ? ? ? s5pv310_default_sdhci2();
> + ? ? ? s5pv310_default_sdhci3();
> ?}
>
> ?void __init s5pv310_init_clocks(int xtal)
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
> index 30844c2..d92670a 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -110,6 +110,10 @@ extern void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
> ?extern void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
> ?extern void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
> ?extern void s5pv210_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
> +extern void s5pv310_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
> +extern void s5pv310_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
> +extern void s5pv310_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
> +extern void s5pv310_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
>
> ?/* S3C64XX SDHCI setup */
>
> @@ -288,4 +292,57 @@ static inline void s5pv210_default_sdhci3(void) { }
>
> ?#endif /* CONFIG_S5PV210_SETUP_SDHCI */
>
> +/* S5PV310 SDHCI setup */
> +#ifdef CONFIG_S5PV310_SETUP_SDHCI
> +extern char *s5pv310_hsmmc_clksrcs[4];
> +
> +extern void s5pv310_setup_sdhci_cfg_card(struct platform_device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?void __iomem *r,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct mmc_ios *ios,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct mmc_card *card);
> +
> +static inline void s5pv310_default_sdhci0(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC
> + ? ? ? s3c_hsmmc0_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
> + ? ? ? s3c_hsmmc0_def_platdata.cfg_gpio = s5pv310_setup_sdhci0_cfg_gpio;
> + ? ? ? s3c_hsmmc0_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
> +#endif
> +}
> +
> +static inline void s5pv310_default_sdhci1(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC1
> + ? ? ? s3c_hsmmc1_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
> + ? ? ? s3c_hsmmc1_def_platdata.cfg_gpio = s5pv310_setup_sdhci1_cfg_gpio;
> + ? ? ? s3c_hsmmc1_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
> +#endif
> +}
> +
> +static inline void s5pv310_default_sdhci2(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC2
> + ? ? ? s3c_hsmmc2_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
> + ? ? ? s3c_hsmmc2_def_platdata.cfg_gpio = s5pv310_setup_sdhci2_cfg_gpio;
> + ? ? ? s3c_hsmmc2_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
> +#endif
> +}
> +
> +static inline void s5pv310_default_sdhci3(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC3
> + ? ? ? s3c_hsmmc3_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
> + ? ? ? s3c_hsmmc3_def_platdata.cfg_gpio = s5pv310_setup_sdhci3_cfg_gpio;
> + ? ? ? s3c_hsmmc3_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
> +#endif
> +}
> +
> +#else
> +static inline void s5pv310_default_sdhci0(void) { }
> +static inline void s5pv310_default_sdhci1(void) { }
> +static inline void s5pv310_default_sdhci2(void) { }
> +static inline void s5pv310_default_sdhci3(void) { }
> +
> +#endif /* CONFIG_S5PV310_SETUP_SDHCI */
> +
> ?#endif /* __PLAT_S3C_SDHCI_H */

Why don't we have s5pv310_default_sdhci(int cont_num) ?
