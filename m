From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 28 Jan 2016 16:00:13 +0000
Subject: [PATCH] spi: atmel: fix gpio chip-select in case of non-DT
 platform
In-Reply-To: <1453913312-18108-1-git-send-email-nicolas.ferre@atmel.com>
 (Nicolas Ferre's message of "Wed, 27 Jan 2016 17:48:32 +0100")
References: <1453913312-18108-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <yw1x37thk836.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>
> The non-DT platform that uses this driver (actually the AVR32) was taking a bad
> branch for determining if the IP would use gpio for CS.
> Adding the presence of DT as a condition fixes this issue.
>
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> [nicolas.ferre at atmel.com: extract from ml discussion]
> Reported-by: Mans Rullgard <mans@mansr.com>
> Fixes: 4820303480a1 ("spi: atmel: add support for the internal chip-select of the spi controller")
> Cc: <stable@vger.kernel.org> # 4.2+
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Tested-by: Mans Rullgard <mans@mansr.com>

> ---
>  drivers/spi/spi-atmel.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index aebad36391c9..8feac599e9ab 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1571,6 +1571,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
>
>  	as->use_cs_gpios = true;
>  	if (atmel_spi_is_v2(as) &&
> +	    pdev->dev.of_node &&
>  	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
>  		as->use_cs_gpios = false;
>  		master->num_chipselect = 4;
> -- 
> 2.1.3
>

-- 
M?ns Rullg?rd
