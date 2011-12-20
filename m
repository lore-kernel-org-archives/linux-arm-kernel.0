From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 20 Dec 2011 15:07:16 +0400
Subject: [PATCH] davinci: DA850 EVM: OHCI platform code
In-Reply-To: <1324363005-11320-1-git-send-email-prakash.pm@ti.com>
References: <1324363005-11320-1-git-send-email-prakash.pm@ti.com>
Message-ID: <4EF06C64.8000708@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 20.12.2011 10:36, Manjunathappa, Prakash wrote:

> From: Ajay Kumar Gupta <ajay.gupta@ti.com>

    It's a good practice to CC the original author of the patch -- which I'm 
doing now...

> On this board the OHCI port's power control and over-current signals from
> TPS2065 power switch are connected via GPIO1[15] and GPIO2[1] respectively,

    Ajay, your description seems to be copied unchganged from the analogous 
DA830 EVM patch, and thus doesn't match your patch: GPIO2[4] and GPIO6[13] are 
used apparently. Be more attentive to detail next time please.

> so we can implement the DA8xx OHCI glue layer's hooks for overriding the
> root hub port's power and over-current status bits.

> We also have to properly set up the clocking mode in the CFGCHIP2 register,
> so that internal 24 MHz reference clock is fed to the USB 2.0 (MUSB) PHY and
> its output is used to clock the USB 1.1 (OHCI) PHY...

> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
>   arch/arm/mach-davinci/board-da850-evm.c |  126 +++++++++++++++++++++++++++++++
>   1 files changed, 126 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 6659a90..df74ba5 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
[...]
> @@ -734,6 +736,127 @@ static struct davinci_i2c_platform_data da850_evm_i2c_0_pdata = {
[...]
> +static int da850_evm_usb_ocic_notify(da8xx_ocic_handler_t handler)
> +{
> +	int irq		= gpio_to_irq(ON_BD_USB_OVC);
> +	int error	= 0;
> +
> +	if (handler != NULL) {
> +		da850_evm_usb_ocic_handler = handler;
> +
> +		error = request_irq(irq, da850_evm_usb_ocic_irq, IRQF_DISABLED |

    IRQF_DISABLED is a nop now -- just remove it.

WBR, Sergei
