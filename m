From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 20 Aug 2016 23:29:08 +0200
Subject: [PATCH v2 3/4] net: stmmac: add a glue driver for the Amlogic
 Meson 8b / GXBB DWMAC
In-Reply-To: <20160820093538.9707-4-martin.blumenstingl@googlemail.com>
References: <20160815164100.27766-1-martin.blumenstingl@googlemail.com>
 <20160820093538.9707-1-martin.blumenstingl@googlemail.com>
 <20160820093538.9707-4-martin.blumenstingl@googlemail.com>
Message-ID: <CAGhQ9VyWs=sYg7PVrt5r-fM-2t--qAnHyvNXAZXwjkYn5P196g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On 20 August 2016 at 11:35, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> The Ethernet controller available in Meson8b and GXBB SoCs is a Synopsys
> DesignWare MAC IP core which is already supported by the stmmac driver.
>
> In addition to the standard stmmac driver some Meson8b / GXBB specific
> registers have to be configured for the PHY clocks. These SoC specific
> registers are called PRG_ETHERNET_ADDR0 and PRG_ETHERNET_ADDR1 in the
> datasheet.
> These registers are not backwards compatible with those on Meson 6b,
> which is why a new glue driver is introduced. This worked for many
> boards because the bootloader programs the PRG_ETHERNET registers
> correctly. Additionally the meson6-dwmac driver only sets bit 1 of
> PRG_ETHERNET_ADDR0 which (according to the datasheet) is only used
> during reset.
>
> Currently all configuration values can be determined automatically,
> based on the configured phy-mode (which is mandatory for the stmmac
> driver). If required the tx-delay and the mux clock (so it supports
> the MPLL2 clock as well) can be made configurable in the future.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Makefile       |   2 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 329 +++++++++++++++++++++
>  2 files changed, 330 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c

<snip>

> +static int meson8b_dwmac_probe(struct platform_device *pdev)
> +{
> +       struct plat_stmmacenet_data *plat_dat;
> +       struct stmmac_resources stmmac_res;
> +       struct resource *res;
> +       struct meson8b_dwmac *dwmac;
> +       int ret;
> +
> +       ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +       if (ret)
> +               return ret;
> +
> +       plat_dat = stmmac_probe_config_dt(pdev, &stmmac_res.mac);
> +       if (IS_ERR(plat_dat))
> +               return PTR_ERR(plat_dat);
> +
> +       dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> +       if (!dwmac)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       if (!res)
> +               return -ENODEV;
> +
> +       dwmac->regs = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(dwmac->regs))
> +               return PTR_ERR(dwmac->regs);
> +
> +       dwmac->pdev = pdev;
> +       dwmac->phy_mode = of_get_phy_mode(pdev->dev.of_node);
> +       if (dwmac->phy_mode < 0) {
> +               dev_err(&pdev->dev, "missing phy-mode property\n");
> +               return -EINVAL;
> +       }
> +
> +       ret = meson8b_init_clk(dwmac);
> +       if (ret)
> +               return ret;
> +
> +       ret = meson8b_init_prg_eth(dwmac);
> +       if (ret)
> +               return ret;
> +
> +       plat_dat->bsp_priv = dwmac;
> +
> +       platform_set_drvdata(pdev, dwmac);

This will not work. The main stmmac driver already uses the driver_data field.
See: http://lxr.free-electrons.com/source/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c#L3218


> +       return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);

So calling stmmac_dvr_probe here will overwrite the driver_data field.


> +}
> +
> +static int meson8b_dwmac_remove(struct platform_device *pdev)
> +{
> +       struct meson8b_dwmac *dwmac = platform_get_drvdata(pdev);
> +
> +       clk_disable_unprepare(dwmac->m25_div_clk);

Did you test this code? I am pretty sure it will blow up given that
driver_data is not set to what you expect.

To get your meson8b_dwmac struct you must retrieve it from plat_dat->bsp_priv.


I have some code for a helper to retrieve bsp_priv that I have meant
to sent to the ML for a while now.
See: https://github.com/manabian/linux-lpc/commit/c3e155a6e38b9634e4e61aa4eeb4602ede7e44a6

Feel free to add it to your patch set if you want.

Alternatively take a look at the remove function from dwmac-stm32 here:
https://patchwork.ozlabs.org/patch/619816/


> +
> +       return stmmac_pltfr_remove(pdev);
> +}


regards,
Joachim Eastwood
