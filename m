From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 13 Mar 2016 23:26:28 +0100
Subject: [v6,
 5/5] mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
In-Reply-To: <1457518131-11339-6-git-send-email-yangbo.lu@nxp.com>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-6-git-send-email-yangbo.lu@nxp.com>
Message-ID: <4947024.WeMycs2fID@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 March 2016 18:08:51 Yangbo Lu wrote:
> @@ -567,10 +580,20 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_esdhc *esdhc;
>         u16 host_ver;
> +       u32 svr;
>  
>         pltfm_host = sdhci_priv(host);
>         esdhc = sdhci_pltfm_priv(pltfm_host);
>  
> +       fsl_guts_init();
> +       svr = fsl_guts_get_svr();
> +       if (svr) {
> +               esdhc->soc_ver = SVR_SOC_VER(svr);
> +               esdhc->soc_rev = SVR_REV(svr);
> +       } else {
> +               dev_err(&pdev->dev, "Failed to get SVR value!\n");
> +       }
> +

This makes the driver non-portable. Better identify the specific workarounds
based on the compatible string for this device, or add a boolean DT property
for the quirk.

	Arnd
