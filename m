From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 10 Aug 2017 00:08:34 +0200
Subject: [PATCH] misc: atmel_tclib: fix error return code in tc_probe()
In-Reply-To: <20170809164250.GA7229@embeddedgus>
References: <20170809164250.GA7229@embeddedgus>
Message-ID: <20170809220834.sjol4cufvjqa6rde@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2017 at 11:42:50 -0500, Gustavo A. R. Silva wrote:
> platform_get_irq() returns an error code, but the atmel_tclib driver
> ignores it and always returns -EINVAL. This is not correct and,
> prevents -EPROBE_DEFER from being propagated properly.
> 

Which will never happen because the kernel would not reach that point if
the irqchip driver was not present. I would really love people to stop
littering perfectly working drivers with unused error strings.

> Print error message and propagate the return value of platform_get_irq
> on failure.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/misc/atmel_tclib.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
> index ac24a4b..c5d3449 100644
> --- a/drivers/misc/atmel_tclib.c
> +++ b/drivers/misc/atmel_tclib.c
> @@ -112,8 +112,10 @@ static int __init tc_probe(struct platform_device *pdev)
>  	unsigned int	i;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return -EINVAL;
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
> +		return irq;
> +	}
>  
>  	tc = devm_kzalloc(&pdev->dev, sizeof(struct atmel_tc), GFP_KERNEL);
>  	if (!tc)
> -- 
> 2.5.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
