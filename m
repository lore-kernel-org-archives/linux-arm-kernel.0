From: svenkatr@ti.com (S, Venkatraman)
Date: Tue, 17 Apr 2012 12:13:53 +0530
Subject: [PATCH] mmc: omap_hsmmc: release correct resource
In-Reply-To: <20120414134125.GT24211@n2100.arm.linux.org.uk>
References: <20120414134125.GT24211@n2100.arm.linux.org.uk>
Message-ID: <CANfBPZ-ZyQ8Wk1OkR-sgs=OCyDOn7hWqnqNTkzbZyVx0sFXNtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 14, 2012 at 7:11 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> res can be one of several resources, as this variable is re-used several
> times during probe. ?This can cause the wrong resource parameters to be
> passed to release_mem_region().
>
> Get the original memory resource before calling release_mem_region().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?drivers/mmc/host/omap_hsmmc.c | ? ?4 +++-
> ?1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index d12bdbe..4b2e1f0 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2027,7 +2027,9 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
> ?err_alloc:
> ? ? ? ?omap_hsmmc_gpio_free(pdata);
> ?err:
> - ? ? ? release_mem_region(res->start, resource_size(res));
> + ? ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + ? ? ? if (res)
> + ? ? ? ? ? ? ? release_mem_region(res->start, resource_size(res));
> ? ? ? ?return ret;
> ?}
>
> --

Thanks Russell. I'll send it to Chris to be queued for 3.4-fixes.
