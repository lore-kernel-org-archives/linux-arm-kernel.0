From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 Dec 2017 16:20:56 +0100
Subject: [RFC] spi: sun6i: disable/unprepare clocks on remove
In-Reply-To: <20171206125028.fqzmy354tgf7afis@agrajag.zerfleddert.de>
References: <20171206125028.fqzmy354tgf7afis@agrajag.zerfleddert.de>
Message-ID: <20171206152056.wzhoiphql322mvqw@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tobias,

On Wed, Dec 06, 2017 at 01:50:29PM +0100, Tobias Jordan wrote:
> sun6i_spi_probe() uses sun6i_spi_runtime_resume() to prepare/enable clocks,
> so sun6i_spi_remove() should use sun6i_spi_runtime_suspend() to
> disable/unprepare them.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Fixes: 3558fe900e8af spi: sunxi: Add Allwinner A31 SPI controller driver
> Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> ---
> This was found by LDV, and it looks very suspicious to me, but I'm not
> sure if the fix is that easy. Is suspend() called automatically when the
> driver is removed? If not, is it correct to unconditionally call
> suspend(), or should there be a check for the PM state instead?
> 
>  drivers/spi/spi-sun6i.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index fb38234249a8..5e5df09e5d04 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -541,6 +541,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
>  
>  static int sun6i_spi_remove(struct platform_device *pdev)
>  {
> +	sun6i_spi_runtime_suspend(&pdev->dev);

Yeah, that's not ideal. The best solution would be to call
pm_runtime_force_suspend I guess.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171206/812de598/attachment.sig>
