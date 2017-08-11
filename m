From: rui.zhang@intel.com (Zhang Rui)
Date: Fri, 11 Aug 2017 11:08:27 +0800
Subject: [PATCH] thermal: rockchip: fix error return code in
 rockchip_thermal_probe()
In-Reply-To: <20170808043517.GA13356@embeddedgus>
References: <20170808043517.GA13356@embeddedgus>
Message-ID: <1502420907.2598.9.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-08-07 at 23:35 -0500, Gustavo A. R. Silva wrote:
> platform_get_irq() returns an error code, but the rockchip_thermal
> driver
> ignores it and always returns -EINVAL. This is not correct and,
> prevents
> -EPROBE_DEFER from being propagated properly.
> 
> Notice that platform_get_irq() no longer returns 0 on error:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co
> mmit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af
> 
> Print and propagate the return value of platform_get_irq on failure.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.

thanks,
rui
> ---
> ?drivers/thermal/rockchip_thermal.c | 4 ++--
> ?1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c
> b/drivers/thermal/rockchip_thermal.c
> index 4c77965..6ca9747 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1068,8 +1068,8 @@ static int rockchip_thermal_probe(struct
> platform_device *pdev)
> ?
> ?	irq = platform_get_irq(pdev, 0);
> ?	if (irq < 0) {
> -		dev_err(&pdev->dev, "no irq resource?\n");
> -		return -EINVAL;
> +		dev_err(&pdev->dev, "no irq resource: %d\n", irq);
> +		return irq;
> ?	}
> ?
> ?	thermal = devm_kzalloc(&pdev->dev, sizeof(struct
> rockchip_thermal_data),
