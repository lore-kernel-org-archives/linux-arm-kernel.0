From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 1 Jun 2011 15:07:18 +0800
Subject: [RFC 1/2] ARM:Tegra: Device Tree Support: Initialize the audio
	card from the device tree.
In-Reply-To: <20110527205706.21000.34832.stgit@riker>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205706.21000.34832.stgit@riker>
Message-ID: <BANLkTi=NMjBjWVv_o3PocejhgGr8TdG+1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/28 John Bonesio <bones@secretlab.ca>:
> This patch makes it so the top level audio card is initialized from the device
> tree. This is just the first step getting the audio complex of devices
> iniialized from device tree nodes.
>
> Signed-off-by: John Bonesio<bones@secretlab.ca>
> ---
>
> ?arch/arm/boot/dts/tegra-harmony.dts | ? ?4 +++
> ?arch/arm/mach-tegra/board-dt.c ? ? ?| ? ?3 ++
> ?sound/soc/tegra/harmony.c ? ? ? ? ? | ? 45 ++++++++++++++++++++++++++++++++---
> ?3 files changed, 48 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
> index 05521a5..217a7f0 100644
> --- a/arch/arm/boot/dts/tegra-harmony.dts
> +++ b/arch/arm/boot/dts/tegra-harmony.dts
> @@ -53,6 +53,10 @@
> ? ? ? ? ? ? ? ?clock-frequency = <400000>;
> ? ? ? ?};
>
> + ? ? ? harmony_audio: audio_card {
> + ? ? ? ? ? ? ? compatible = "nvidia,harmony-audio";
> + ? ? ? };
> +
> ? ? ? ?serial at 70006300 {
> ? ? ? ? ? ? ? ?status = "ok";
> ? ? ? ? ? ? ? ?clock-frequency = < 216000000 >;
> diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
> index c498e84..a569ad9 100644
> --- a/arch/arm/mach-tegra/board-dt.c
> +++ b/arch/arm/mach-tegra/board-dt.c
> @@ -56,6 +56,9 @@ static struct platform_device *tegra250_devices[] __initdata = {
> ? ? ? ?&tegra_i2c_device2,
> ? ? ? ?&tegra_i2c_device3,
> ? ? ? ?&tegra_i2c_device4,
> + ? ? ? &tegra_i2s_device1,
> + ? ? ? &tegra_das_device,
> + ? ? ? &tegra_pcm_device,

i am thinking whether platform_device should be created by
of_platform_device_create after scanning device tree, but not by
hard-code? looks like the two patches are only trying to let device
tree deliver gpio to drivers?

> ?};
>
> ?static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
> diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
> index f225087..faeec14 100644
> --- a/sound/soc/tegra/harmony.c
> +++ b/sound/soc/tegra/harmony.c
> @@ -52,6 +52,18 @@
>
> ?#define DRV_NAME "tegra-snd-harmony"
>
> +/* temporary - info will go into device tree */
> +#define TEGRA_GPIO_PW2 ? ? ? ? ?178
> +#define TEGRA_GPIO_PX0 ? ? ? ? ?184
> +#define TEGRA_GPIO_PX1 ? ? ? ? ?185
> +
> +#define HARMONY_GPIO_WM8903(_x_) ? ? ? (TEGRA_NR_GPIOS + (_x_))
> +#define TEGRA_GPIO_SPKR_EN ? ? ? ? ? ? HARMONY_GPIO_WM8903(2)
> +#define TEGRA_GPIO_HP_DET ? ? ? ? ? ? ?TEGRA_GPIO_PW2
> +#define TEGRA_GPIO_INT_MIC_EN ? ? ? ? ?TEGRA_GPIO_PX0
> +#define TEGRA_GPIO_EXT_MIC_EN ? ? ? ? ?TEGRA_GPIO_PX1
> +/* end temporary */
> +
> ?#define GPIO_SPKR_EN ? ?BIT(0)
> ?#define GPIO_INT_MIC_EN BIT(1)
> ?#define GPIO_EXT_MIC_EN BIT(2)
> @@ -287,6 +299,14 @@ static struct snd_soc_card snd_soc_harmony = {
> ? ? ? ?.num_links = 1,
> ?};
>
> +/* temporary - put this into the device tree */
> +static struct harmony_audio_platform_data harmony_audio_pdata = {
> + ? ? ? .gpio_spkr_en ? ? ? ? ? = TEGRA_GPIO_SPKR_EN,
> + ? ? ? .gpio_hp_det ? ? ? ? ? ?= TEGRA_GPIO_HP_DET,
> + ? ? ? .gpio_int_mic_en ? ? ? ?= TEGRA_GPIO_INT_MIC_EN,
> + ? ? ? .gpio_ext_mic_en ? ? ? ?= TEGRA_GPIO_EXT_MIC_EN,
> +};
> +
> ?static __devinit int tegra_snd_harmony_probe(struct platform_device *pdev)
> ?{
> ? ? ? ?struct snd_soc_card *card = &snd_soc_harmony;
> @@ -307,10 +327,15 @@ static __devinit int tegra_snd_harmony_probe(struct platform_device *pdev)
> ? ? ? ?}
> ?#endif
>
> - ? ? ? pdata = pdev->dev.platform_data;
> - ? ? ? if (!pdata) {
> - ? ? ? ? ? ? ? dev_err(&pdev->dev, "no platform data supplied\n");
> - ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? if (pdev->dev.of_node) {
> + ? ? ? ? ? ? ? pdev->dev.platform_data = &harmony_audio_pdata; /* temporary */
> + ? ? ? ? ? ? ? pdata = pdev->dev.platform_data;
> + ? ? ? } else {
> + ? ? ? ? ? ? ? pdata = pdev->dev.platform_data;
> + ? ? ? ? ? ? ? if (!pdata) {
> + ? ? ? ? ? ? ? ? ? ? ? dev_err(&pdev->dev, "no platform data supplied\n");
> + ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? ? ? ? ? }
> ? ? ? ?}
>
> ? ? ? ?harmony = kzalloc(sizeof(struct tegra_harmony), GFP_KERNEL);
> @@ -374,11 +399,23 @@ static int __devexit tegra_snd_harmony_remove(struct platform_device *pdev)
> ? ? ? ?return 0;
> ?}
>
> +#if defined(CONFIG_OF)
> +/* Match table for of_platform binding */
> +static const struct of_device_id harmony_of_match[] __devinitconst = {
> + ? ? ? { .compatible = "nvidia,harmony-audio", },
> + ? ? ? {},
> +};
> +MODULE_DEVICE_TABLE(of, harmony_of_match);
> +#endif
> +
> ?static struct platform_driver tegra_snd_harmony_driver = {
> ? ? ? ?.driver = {
> ? ? ? ? ? ? ? ?.name = DRV_NAME,
> ? ? ? ? ? ? ? ?.owner = THIS_MODULE,
> ? ? ? ? ? ? ? ?.pm = &snd_soc_pm_ops,
> +#if defined(CONFIG_OF)
> + ? ? ? ? ? ? ? .of_match_table = harmony_of_match,
> +#endif
> ? ? ? ?},
> ? ? ? ?.probe = tegra_snd_harmony_probe,
> ? ? ? ?.remove = __devexit_p(tegra_snd_harmony_remove),
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
