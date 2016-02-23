From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 23 Feb 2016 17:30:47 +0100
Subject: [PATCH 46/61] gpio: tegra: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-47-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
 <1456150130-2668-47-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160223163047.GB13755@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 07:38:35PM +0530, Laxman Dewangan wrote:
> Use devm_gpiochip_add_data() for GPIO registration.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/gpio/gpio-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
> index 9a1a7e2..790bb11 100644
> --- a/drivers/gpio/gpio-tegra.c
> +++ b/drivers/gpio/gpio-tegra.c
> @@ -545,7 +545,7 @@ static int tegra_gpio_probe(struct platform_device *pdev)
>  
>  	tegra_gpio_chip.of_node = pdev->dev.of_node;
>  
> -	ret = gpiochip_add_data(&tegra_gpio_chip, NULL);
> +	ret = devm_gpiochip_add_data(&pdev->dev, &tegra_gpio_chip, NULL);
>  	if (ret < 0) {
>  		irq_domain_remove(irq_domain);
>  		return ret;

It's slightly redundant to do this because the driver probe will never
fail after this point and the driver can't be unloaded, so there's no
way that the GPIO chip would ever be removed.

But in the interest of consistency I have no objections to doing this.
It might also happen that, eventually, we might turn this into a proper
driver, at which point this would come in useful.

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160223/6b2ab1fd/attachment.sig>
