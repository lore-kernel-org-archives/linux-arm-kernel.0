From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 20 Dec 2011 15:17:22 +0400
Subject: [PATCH] davinci: DA850 EVM: OHCI platform code
In-Reply-To: <1324363005-11320-1-git-send-email-prakash.pm@ti.com>
References: <1324363005-11320-1-git-send-email-prakash.pm@ti.com>
Message-ID: <4EF06EC2.3070907@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 20-12-2011 10:36, Manjunathappa, Prakash wrote:

> From: Ajay Kumar Gupta<ajay.gupta@ti.com>

> On this board the OHCI port's power control and over-current signals from
> TPS2065 power switch are connected via GPIO1[15] and GPIO2[1] respectively,
> so we can implement the DA8xx OHCI glue layer's hooks for overriding the
> root hub port's power and over-current status bits.

> We also have to properly set up the clocking mode in the CFGCHIP2 register,
> so that internal 24 MHz reference clock is fed to the USB 2.0 (MUSB) PHY and
> its output is used to clock the USB 1.1 (OHCI) PHY...

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

    BTW, Prakash, as you'r on the patch's disrtibution path, shouldn't you add 
your signoff as well?

> ---
>   arch/arm/mach-davinci/board-da850-evm.c |  126 +++++++++++++++++++++++++++++++
>   1 files changed, 126 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 6659a90..df74ba5 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
[...]
> +static __init void da850_evm_usb_init(void)
> +{
[...]
> +	ret = gpio_request(ON_BD_USB_DRV, "ON_BD_USB_DRV");
> +	if (ret) {
> +		printk(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
> +		       "power control: %d\n", __func__, ret);
> +		return;
> +	}
> +	gpio_direction_output(ON_BD_USB_DRV, 0);

    You should also use gpio_request_one() instead 
gpio_request()/gpio_direction_output() pair.

> +
> +	ret = gpio_request(ON_BD_USB_OVC, "ON_BD_USB_OVC");
> +	if (ret) {
> +		printk(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
> +		       "over-current indicator: %d\n", __func__, ret);
> +		return;
> +	}
> +	gpio_direction_input(ON_BD_USB_OVC);

    Same here.

WBR, Sergei
