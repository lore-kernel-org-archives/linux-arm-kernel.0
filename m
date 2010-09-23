From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 23 Sep 2010 12:08:03 -0700
Subject: [PATCH] sdhci-s3c: fix NULL ptr access in sdhci_s3c_remove
In-Reply-To: <1285251725-6210-1-git-send-email-m.szyprowski@samsung.com>
References: <1285251725-6210-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100923120803.832975f6.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Sep 2010 16:22:05 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> If not all clocks has been defined in platform data, driver will cause
> a null pointer dereference when it is being removed. This patch fixes
> this issue.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 71ad416..757d92c 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -481,8 +481,10 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>  	sdhci_remove_host(host, 1);
>  
>  	for (ptr = 0; ptr < 3; ptr++) {
> -		clk_disable(sc->clk_bus[ptr]);
> -		clk_put(sc->clk_bus[ptr]);
> +		if (sc->clk_bus[ptr]) {
> +			clk_disable(sc->clk_bus[ptr]);
> +			clk_put(sc->clk_bus[ptr]);
> +		}
>  	}
>  	clk_disable(sc->clk_io);
>  	clk_put(sc->clk_io);

The patch applies OK to 2.6.35.  Is the bug present there as well?  If
so, should we fix it in earlier kernels?  If so then the way in which
we indicate this is by adding

	Cc: <stable@kernel.org>

to the changelog.
