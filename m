From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 10 Jan 2011 13:58:12 -0700
Subject: [PATCH] spi: tegra: don't treat NULL clk as an error
In-Reply-To: <1294657506-27510-1-git-send-email-jamie@jamieiles.com>
References: <1294657506-27510-1-git-send-email-jamie@jamieiles.com>
Message-ID: <AANLkTikd7AZv+-aVf4=jwF+xjvq+1k_kAwLPz-+yP6=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 4:05 AM, Jamie Iles <jamie@jamieiles.com> wrote:
> Some platforms have been known to return NULL from clk_get() if they
> support only a single struct clk. ?Whilst tegra doesn't do this, make
> the drivers consistent with others.
>
> Cc: Erik Gilling <konkers@android.com>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Hi James,

If NULL does get returned, say due to a future change to the clock
code, then this change causes the driver to oops.  I'm not going to
apply this patch.

g.

> ---
>
> ?drivers/spi/spi_tegra.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/spi_tegra.c b/drivers/spi/spi_tegra.c
> index bb7df02..891e590 100644
> --- a/drivers/spi/spi_tegra.c
> +++ b/drivers/spi/spi_tegra.c
> @@ -513,7 +513,7 @@ static int __init spi_tegra_probe(struct platform_device *pdev)
> ? ? ? ?}
>
> ? ? ? ?tspi->clk = clk_get(&pdev->dev, NULL);
> - ? ? ? if (IS_ERR_OR_NULL(tspi->clk)) {
> + ? ? ? if (IS_ERR(tspi->clk)) {
> ? ? ? ? ? ? ? ?dev_err(&pdev->dev, "can not get clock\n");
> ? ? ? ? ? ? ? ?ret = PTR_ERR(tspi->clk);
> ? ? ? ? ? ? ? ?goto err2;
> --
> 1.7.3.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
