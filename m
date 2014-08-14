From: addy.ke@rock-chips.com (Addy)
Date: Thu, 14 Aug 2014 09:57:15 +0800
Subject: [PATCH] ARM: dts: Add mmc0 and mmc1 aliases for rk3288
In-Reply-To: <1407974880-30626-1-git-send-email-dianders@chromium.org>
References: <1407974880-30626-1-git-send-email-dianders@chromium.org>
Message-ID: <53EC177B.1080706@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> It's convenient (and less confusing to people reading logs) if the
> eMMC port on rk3288 is consistenly marked with mmc0 and the sdmmc port
> on rk3288 is consistently marked with mmc1.  Add the appropriate
> aliases.
>
> These aliases only actually do something if a patch like
> (https://patchwork.kernel.org/patch/3925551/) lands, but they don't
> hurt even before that patch.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Sonny Rao <sonnyrao@chromium.org>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 36be7bb..0b54b0d 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -29,6 +29,8 @@
>  		i2c3 = &i2c3;
>  		i2c4 = &i2c4;
>  		i2c5 = &i2c5;
> +		mmc0 = &emmc;
> +		mmc1 = &sdmmc;
There are 8 registers can be configured for clock tunning(see chapter 3,
page 133):
sdmmc: CRU_SDMMC_CON0(offset: 0x200)
CRU_SDMMC_CON1(offset: 0x204)
sdio0: CRU_SDMMC_CON2(offset: 0x208)
CRU_SDMMC_CON3(offset: 0x20c)
sdio1: CRU_SDMMC_CON4(offset: 0x210)
CRU_SDMMC_CON5(offset: 0x214)
emmc: CRU_SDMMC_CON6(offset: 0x218)
CRU_SDMMC_CON7(offset: 0x21c)

I think maybe it is suitable as follows:
mmc0 = &sdmmc
mmc1 = &sdio0
mmc2 = &sdio1
mmc3 = &emmc

So we can get ctrl_id:
ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");

and can get offset of registers:
offset = 0x200 + ctrl_id * 8 + 4 * drive_or_sample

>  		serial0 = &uart0;
>  		serial1 = &uart1;
>  		serial2 = &uart2;
