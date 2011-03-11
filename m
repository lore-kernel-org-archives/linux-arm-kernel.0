From: wg@grandegger.com (Wolfgang Grandegger)
Date: Fri, 11 Mar 2011 17:57:59 +0100
Subject: [PATCH] can : AM3517EVM : add platform specific init
In-Reply-To: <1299775153-16766-1-git-send-email-abhilash.kv@ti.com>
References: <1299775153-16766-1-git-send-email-abhilash.kv@ti.com>
Message-ID: <4D7A5497.4070801@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2011 05:39 PM, Abhilash K V wrote:
> CAN module on AM3517 requires programming of IO expander
> as part of init sequence. Added transceiver_switch
> callback to handle this.
> 
> Signed-off-by: Sriramakrishnan <srk@ti.com>
> Reviewed-by:  Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
> ---
>  arch/arm/mach-omap2/board-am3517evm.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
> index 2e4aad2..782d72d 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -734,6 +734,23 @@ static struct omap_board_mux board_mux[] __initdata = {
>  };
>  #endif
>  
> +/*
> + * HECC information
> + */
> +
> +#define CAN_STB         214
> +static void hecc_phy_control(int on)
> +{
> +        int r;
> +
> +        r = gpio_request(CAN_STB, "can_stb");
> +        if (r) {
> +                printk(KERN_ERR "failed to get can_stb \n");
> +                return;
> +        }
> +
> +        gpio_direction_output(CAN_STB, (on==1)?0:1);
> +}

This function is called ony *any* ifconfig up and down request. I would
expect gpio_request() will return -EBUSY when it's called more than once.

Wolfgang.
