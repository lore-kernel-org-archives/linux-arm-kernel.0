From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 3 Jul 2018 16:54:52 +0200
Subject: [PATCH 1/1] mmc: sunxi: Disable irq during pm_suspend
In-Reply-To: <1530602925-7714-1-git-send-email-stefan@olimex.com>
References: <1530602925-7714-1-git-send-email-stefan@olimex.com>
Message-ID: <20180703145452.o2zbchnnvncpvwfj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Tue, Jul 03, 2018 at 10:28:43AM +0300, Stefan Mavrodiev wrote:
> When mmc host controller enters suspend state, the clocks are
> disabled, but irqs are not. For some reason the irqchip emmits
> false interrupts, which causes system lock loop.
> 
> Debug log is:
>   ...
>   sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 51200000
>   sunxi-mmc 1c11000.mmc: enabling the clock
>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   sunxi-mmc 1c11000.mmc: cmd 6(80000146) arg 3210101 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   mmc1: new DDR MMC card at address 0001
>   mmcblk1: mmc1:0001 AGND3R 14.6 GiB
>   mmcblk1boot0: mmc1:0001 AGND3R partition 1 4.00 MiB
>   mmcblk1boot1: mmc1:0001 AGND3R partition 2 4.00 MiB
>   sunxi-mmc 1c11000.mmc: cmd 18(80003352) arg 0 ie 0x0000fbc2 len 409
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00004000 idi 00000002
>    mmcblk1: p1
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
> and so on...
> 
> This issue apears on eMMC cards, routed on MMC2 slot. The patch is
> tested with A20-OLinuXino-MICRO/LIME/LIME2 boards.
> 
> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>

Thanks a lot for figuring this out, I have a (very) minor comment though..

> ---
>  drivers/mmc/host/sunxi-mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index e747259..acae7a8 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1446,6 +1446,7 @@ static int sunxi_mmc_runtime_resume(struct device *dev)
>  	sunxi_mmc_init_host(host);
>  	sunxi_mmc_set_bus_width(host, mmc->ios.bus_width);
>  	sunxi_mmc_set_clk(host, &mmc->ios);
> +	enable_irq(host->irq);
>  
>  	return 0;
>  }
> @@ -1455,6 +1456,7 @@ static int sunxi_mmc_runtime_suspend(struct device *dev)
>  	struct mmc_host	*mmc = dev_get_drvdata(dev);
>  	struct sunxi_mmc_host *host = mmc_priv(mmc);
>  
> +	disable_irq(host->irq);

Can you add a comment there stating why we need them in the first
place (which is basically what you described) so that it's obvious for
anyone editing it.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180703/1fd0b70d/attachment-0001.sig>
