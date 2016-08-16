From: John.Youn@synopsys.com (John Youn)
Date: Mon, 15 Aug 2016 18:30:46 -0700
Subject: [PATCH V2 RFC 1/6] usb: dwc2: core: Avoid nonsense error in
 gadget mode
In-Reply-To: <1469559213-16160-2-git-send-email-stefan.wahren@i2se.com>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <1469559213-16160-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <92280b0f-4dd3-bcf5-57ed-277a9f91653d@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/26/2016 11:54 AM, Stefan Wahren wrote:
> In gadget mode On bcm2835 platform the host tx fifo size could be zero.
> So add zero to range and avoid such nonsense errors:
> 
> dwc2 20980000.usb: 0 invalid for host_nperio_tx_fifo_size.
> dwc2 20980000.usb: Setting host_nperio_tx_fifo_size to 0
> dwc2 20980000.usb: 0 invalid for host_perio_tx_fifo_size.
> dwc2 20980000.usb: Setting host_perio_tx_fifo_size to 0

Hi Stefan,

Are those the power on reset values of GNPTXFSIZ and HPTXFSIZ?

If these values can be 0, I think the patch is ok. But I'm not sure
about that. I can check with some hardware engineers to see under what
conditions this is possible.

Regards,
John


> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/usb/dwc2/core.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
> index 4135a5f..5645528 100644
> --- a/drivers/usb/dwc2/core.c
> +++ b/drivers/usb/dwc2/core.c
> @@ -819,7 +819,10 @@ void dwc2_set_param_host_nperio_tx_fifo_size(struct dwc2_hsotg *hsotg, int val)
>  {
>  	int valid = 1;
>  
> -	if (val < 16 || val > hsotg->hw_params.host_nperio_tx_fifo_size)
> +	if (val && (val < 16))
> +		valid = 0;
> +
> +	if (val > hsotg->hw_params.host_nperio_tx_fifo_size)
>  		valid = 0;
>  
>  	if (!valid) {
> @@ -839,7 +842,10 @@ void dwc2_set_param_host_perio_tx_fifo_size(struct dwc2_hsotg *hsotg, int val)
>  {
>  	int valid = 1;
>  
> -	if (val < 16 || val > hsotg->hw_params.host_perio_tx_fifo_size)
> +	if (val && (val < 16))
> +		valid = 0;
> +
> +	if (val > hsotg->hw_params.host_perio_tx_fifo_size)
>  		valid = 0;
>  
>  	if (!valid) {
> 
