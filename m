From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 19 Nov 2010 19:25:58 +0300
Subject: [PATCH v6 05/12] davinci: add spi devices on tnetv107x evm
In-Reply-To: <1290182156-20104-6-git-send-email-cyril@ti.com>
References: <1290182156-20104-1-git-send-email-cyril@ti.com>
	<1290182156-20104-6-git-send-email-cyril@ti.com>
Message-ID: <4CE6A516.402@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Cyril Chemparathy wrote:

> This patch adds definitions for spi devices on the tnetv107x evm platform.

> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> ---
>  arch/arm/mach-davinci/board-tnetv107x-evm.c |   43 +++++++++++++++++++++++++++
>  1 files changed, 43 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
> index ef526b1..1a656e8 100644
> --- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
> +++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
[...]
> @@ -202,9 +204,45 @@ static struct matrix_keypad_platform_data keypad_config = {
>  	.no_autorepeat	= 0,
>  };
>  
> +static void spi_select_device(int cs)
> +{
> +	static int gpio;
> +
> +	if (!gpio) {
> +		int ret;
> +		ret = gpio_request(EVM_SPI_CS_GPIO, "spi chipsel");

    Why not just:

		int ret = gpio_request(EVM_SPI_CS_GPIO, "spi chipsel");

    Also, and empty line after declaration wouldn't hurt.

> +		if (ret < 0) {
> +			pr_err("cannot open spi chipsel gpio\n");
> +			gpio = -ENOSYS;
> +			return;
> +		} else {
> +			gpio = EVM_SPI_CS_GPIO;
> +			gpio_direction_output(gpio, 0);
> +		}
> +	}
> +
> +	if (gpio < 0)
> +		return;
> +
> +	return gpio_set_value(gpio, cs ? 1 : 0);

    Why not do it right with gpio_direction_output() call?

WBR, Sergei
