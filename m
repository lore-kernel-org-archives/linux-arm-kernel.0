From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 2 Mar 2015 17:03:38 +0000
Subject: [PATCH 3/3] ahci: st: st_configure_oob must be called after IP
 is clocked.
In-Reply-To: <1425300519-13747-4-git-send-email-peter.griffin@linaro.org>
References: <1425300519-13747-1-git-send-email-peter.griffin@linaro.org>
 <1425300519-13747-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150302170338.GC6976@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 02 Mar 2015, Peter Griffin wrote:

> Currently the ahci_st driver will hang the system on probe, as the
> st_configure_oob function does some register writes before the IP
> is clocked. This patch moves the function call to after
> ahci_platform_enable_resources (which enables the IP clock), and
> resolves the hang.
> 
> Addtionally st_ahci_configure_oob should be called in the st_ahci_resume
> function, so we also rectify that ensuring it is also called after
> the IP clock has been enabled.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/ata/ahci_st.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

I suspect we might find a few issues like this now we're not using
'clk_ignore_unused'.

Acked-by: Lee Jones <lee.jones@linaro.org>
 
> diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
> index bc971af..ea0ff00 100644
> --- a/drivers/ata/ahci_st.c
> +++ b/drivers/ata/ahci_st.c
> @@ -68,8 +68,6 @@ static int st_ahci_deassert_resets(struct device *dev)
>  		}
>  	}
>  
> -	st_ahci_configure_oob(drv_data->hpriv->mmio);
> -
>  	if (drv_data->sw_rst) {
>  		err = reset_control_deassert(drv_data->sw_rst);
>  		if (err) {
> @@ -172,6 +170,8 @@ static int st_ahci_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> +	st_ahci_configure_oob(drv_data->hpriv->mmio);
> +
>  	err = ahci_platform_init_host(pdev, hpriv, &st_ahci_port_info,
>  				      &ahci_platform_sht);
>  	if (err) {
> @@ -222,6 +222,8 @@ static int st_ahci_resume(struct device *dev)
>  		return err;
>  	}
>  
> +	st_ahci_configure_oob(drv_data->hpriv->mmio);
> +
>  	return ahci_platform_resume_host(dev);
>  }
>  #endif

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
