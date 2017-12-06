From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 6 Dec 2017 15:43:40 +0000
Subject: [PATCH 1/3] extcon: usbc-cros-ec: add support to notify USB type
 cables.
In-Reply-To: <20171206111008.3079-1-enric.balletbo@collabora.com>
References: <20171206111008.3079-1-enric.balletbo@collabora.com>
Message-ID: <20171206154340.nzvk4svwliqxjk5u@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 06 Dec 2017, Enric Balletbo i Serra wrote:

> From: Benson Leung <bleung@chromium.org>
> 
> Extend the driver to notify host and device type cables and the presence
> of power.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/extcon/extcon-usbc-cros-ec.c | 142 ++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/cros_ec_commands.h |  17 +++++
>  2 files changed, 155 insertions(+), 4 deletions(-)

[...]

> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index 2b16e95..c907353 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -2904,16 +2904,33 @@ enum usb_pd_control_mux {
>  	USB_PD_CTRL_MUX_AUTO = 5,
>  };
>  
> +enum usb_pd_control_swap {
> +	USB_PD_CTRL_SWAP_NONE = 0,
> +	USB_PD_CTRL_SWAP_DATA = 1,
> +	USB_PD_CTRL_SWAP_POWER = 2,
> +	USB_PD_CTRL_SWAP_VCONN = 3,
> +	USB_PD_CTRL_SWAP_COUNT
> +};
> +
>  struct ec_params_usb_pd_control {
>  	uint8_t port;
>  	uint8_t role;
>  	uint8_t mux;
> +	uint8_t swap;
>  } __packed;
>  
>  #define PD_CTRL_RESP_ENABLED_COMMS      (1 << 0) /* Communication enabled */
>  #define PD_CTRL_RESP_ENABLED_CONNECTED  (1 << 1) /* Device connected */
>  #define PD_CTRL_RESP_ENABLED_PD_CAPABLE (1 << 2) /* Partner is PD capable */
>  
> +#define PD_CTRL_RESP_ROLE_POWER         (1 << 0) /* 0=SNK/1=SRC */
> +#define PD_CTRL_RESP_ROLE_DATA          (1 << 1) /* 0=UFP/1=DFP */
> +#define PD_CTRL_RESP_ROLE_VCONN         (1 << 2) /* Vconn status */
> +#define PD_CTRL_RESP_ROLE_DR_POWER      (1 << 3) /* Partner is dualrole power */
> +#define PD_CTRL_RESP_ROLE_DR_DATA       (1 << 4) /* Partner is dualrole data */
> +#define PD_CTRL_RESP_ROLE_USB_COMM      (1 << 5) /* Partner USB comm capable */
> +#define PD_CTRL_RESP_ROLE_EXT_POWERED   (1 << 6) /* Partner externally powerd */

Looks like the BIT() macro would serve you well here.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
