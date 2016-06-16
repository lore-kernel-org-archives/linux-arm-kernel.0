From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 16 Jun 2016 11:03:30 +0200
Subject: [PATCH 7/7] usb: dwc3: st: Inform the reset framework that our
 reset line may be shared
In-Reply-To: <20160606155655.10860-8-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
 <20160606155655.10860-8-lee.jones@linaro.org>
Message-ID: <1466067810.3343.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 06.06.2016, 16:56 +0100 schrieb Lee Jones:
> On the STiH410 B2120 development board the MiPHY28lp shares its reset
> line with the Synopsys DWC3 SuperSpeed (SS) USB 3.0 Dual-Role-Device
> (DRD).  New functionality in the reset subsystems forces consumers to
> be explicit when requesting shared/exclusive reset lines.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/dwc3/dwc3-st.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
> index 5c0adb9..e77bacb 100644
> --- a/drivers/usb/dwc3/dwc3-st.c
> +++ b/drivers/usb/dwc3/dwc3-st.c
> @@ -227,7 +227,8 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  	dev_vdbg(&pdev->dev, "glue-logic addr 0x%p, syscfg-reg offset 0x%x\n",
>  		 dwc3_data->glue_base, dwc3_data->syscfg_reg_off);
>  
> -	dwc3_data->rstc_pwrdn = devm_reset_control_get(dev, "powerdown");
> +	dwc3_data->rstc_pwrdn =
> +		devm_reset_control_get_exclusive(dev, "powerdown");

This hunk is not critical. If you split it into a separate patch, this
one doesn't depend on patch 2. The same applies to patch 8.
That way I could take patches 1-5 through reset/next and you wouldn't
have to wait for them to be merged into arm-soc.

regards
Philipp
