From: viresh.kumar@linaro.org (viresh kumar)
Date: Fri, 13 Jul 2012 11:17:19 +0100
Subject: [PATCH V2 7/7] net: stmmac: Overwrite platform data if passed
 from auxdata
In-Reply-To: <d72fd8775e055a0788226f1a9c1fbe3e333f6bae.1342171151.git.vipulkumar.samar@st.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
 <d72fd8775e055a0788226f1a9c1fbe3e333f6bae.1342171151.git.vipulkumar.samar@st.com>
Message-ID: <CAOh2x=nn_Z6KkzW0cCtBDJnsNhAKLfEbkC0pJNK+OY9X0-XYjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 10:23 AM, Vipul Kumar Samar
<vipulkumar.samar@st.com> wrote:
> Platform data can be passed through either device tree or
> auxdata_lookup. Device tree still donot have any means to provide
> facility for passing platform callbacks to the driver.
>
> If any platform data is available through auxdata_lookup then overwrite
> the platform data passed through device tree.
>
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>

This one is part of wrong patchset, remove it from this one, when you send a
pull request to Arnd/Olof.

Send it to net dev list separately. Keep giuseppe and stefan Roese in CC.

> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 680d2b8..4651579 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -114,10 +114,11 @@ static int stmmac_pltfr_probe(struct platform_device *pdev)
>                         pr_err("%s: main dt probe failed", __func__);
>                         goto out_unmap;
>                 }
> -       } else {
> -               plat_dat = pdev->dev.platform_data;
>         }
>
> +       if (pdev->dev.platform_data)
> +               plat_dat = pdev->dev.platform_data;
> +

Even this looks wrong. You can't simply override plat_dat like this.
Better to add properties to stmmac driver, that you can pass via DT.

That's what Stefan also mentioned in his original patch:

static int __devinit stmmac_probe_config_dt(struct platform_device *pdev,
					    struct plat_stmmacenet_data *plat,
					    const char **mac)
{
	/*
	 * Currently only the properties needed on SPEAr600
	 * are provided. All other properties should be added
	 * once needed on other platforms.
	 */

--
viresh
