From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 23 Sep 2011 13:58:44 +0800
Subject: [V3 4/4] ARM: mmp: support emmc on dkb board
In-Reply-To: <1316610446-24183-5-git-send-email-njun@marvell.com>
References: <1316610446-24183-1-git-send-email-njun@marvell.com>
	<1316610446-24183-5-git-send-email-njun@marvell.com>
Message-ID: <CAN1soZxKp_6q0r5j4Orq4E9NbRChxVref0=sNhWSeuJ_ZMYLNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 9:07 PM, Jun Nie <njun@marvell.com> wrote:
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> ?arch/arm/mach-mmp/ttc_dkb.c | ? 30 ++++++++++++++++++++++++++++++
> ?1 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> index f90e5db..0c05ecd 100644
> --- a/arch/arm/mach-mmp/ttc_dkb.c
> +++ b/arch/arm/mach-mmp/ttc_dkb.c
> @@ -50,6 +50,18 @@ static unsigned long ttc_dkb_pin_config[] __initdata = {
> ? ? ? ?GPIO47_UART2_RXD,
> ? ? ? ?GPIO48_UART2_TXD,
>
> +#ifdef DKB_EMMC
> + ? ? ? MFP_CFG(DF_IO0, AF1),
> + ? ? ? MFP_CFG(DF_IO1, AF1),
> + ? ? ? MFP_CFG(DF_IO2, AF1),
> + ? ? ? MFP_CFG(DF_IO3, AF1),
> + ? ? ? MFP_CFG(DF_IO4, AF1),
> + ? ? ? MFP_CFG(DF_IO5, AF1),
> + ? ? ? MFP_CFG(DF_IO6, AF1),
> + ? ? ? MFP_CFG(DF_IO7, AF1),
> + ? ? ? MFP_CFG(DF_CLE_SM_OEn, AF1),
> + ? ? ? MFP_CFG(SM_SCLK, AF1),
> +#else
> ? ? ? ?/* DFI */
> ? ? ? ?DF_IO0_ND_IO0,
> ? ? ? ?DF_IO1_ND_IO1,
> @@ -73,6 +85,7 @@ static unsigned long ttc_dkb_pin_config[] __initdata = {
> ? ? ? ?DF_WEn_DF_WEn,
> ? ? ? ?DF_REn_DF_REn,
> ? ? ? ?DF_RDY0_DF_RDY0,
> +#endif /* DKB_EMMC */
If the pin configurations are conflict for different types of one
platform, it's better
to use Kconfig. Since you can avoid to change your sourcecode.
>
> ? ? ? ?/*sdh MMC0*/
> ? ? ? ?MMC1_DAT3_MMC1_DAT3,
> @@ -96,6 +109,7 @@ static unsigned long ttc_dkb_pin_config[] __initdata = {
> ? ? ? ?GPIO15_GPIO,
> ?};
>
> +#ifndef DKB_EMMC
> ?static struct mtd_partition ttc_dkb_onenand_partitions[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.name ? ? ? ? ? = "bootloader",
> @@ -147,9 +161,12 @@ static struct platform_device ttc_dkb_device_onenand = {
> ? ? ? ? ? ? ? ?.platform_data ?= &ttc_dkb_onenand_info,
> ? ? ? ?},
> ?};
> +#endif /* DKB_EMMC */
>
> ?static struct platform_device *ttc_dkb_devices[] = {
> +#ifndef DKB_EMMC
> ? ? ? ?&ttc_dkb_device_onenand,
> +#endif
> ?};
>
> ?static struct pca953x_platform_data max7312_data[] = {
> @@ -203,6 +220,16 @@ static struct sdhci_pxa_platdata pxa910_sdh_platdata_mmc0 = {
> ? ? ? ?.clk_delay_cycles ? ? ? = 2,
> ?};
>
> +/* MMC2 controller for EMMC */
> +#ifdef DKB_EMMC
> +static struct sdhci_pxa_platdata pxa910_sdh_platdata_mmc2 = {
> + ? ? ? .flags ? ? ? ? ? ? ? ? ?= PXA_FLAG_CARD_PERMANENT
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
> + ? ? ? .clk_delay_sel ? ? ? ? ?= 1,
> + ? ? ? .clk_delay_cycles ? ? ? = 2,
> +};
> +#endif
> +
> ?/* MMC1 controller for SDIO */
> ?static struct sdhci_pxa_platdata pxa910_sdh_platdata_mmc1 = {
> ? ? ? ?.flags ? ? ? ? ? ? ? ? ?= PXA_FLAG_CARD_PERMANENT,
> @@ -216,6 +243,9 @@ static void __init ttc_dkb_init(void)
> ? ? ? ?pxa910_add_uart(1);
> ? ? ? ?pxa910_add_sdhost0(&pxa910_sdh_platdata_mmc0);
> ? ? ? ?pxa910_add_sdhost1(&pxa910_sdh_platdata_mmc1);
> +#ifdef DKB_EMMC
> + ? ? ? pxa910_add_sdhost2(&pxa910_sdh_platdata_mmc2);
> +#endif
>
> ? ? ? ?/* off-chip devices */
> ? ? ? ?pxa910_add_twsi(0, NULL, ARRAY_AND_SIZE(ttc_dkb_i2c_info));
> --
> 1.7.0.4
>
>
