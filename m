From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 Dec 2017 16:20:05 +0100
Subject: [PATCH] spi: sun4i: disable clocks in the remove function
In-Reply-To: <1512573752-13091-1-git-send-email-takuo.koguchi.sw@hitachi.com>
References: <1512573752-13091-1-git-send-email-takuo.koguchi.sw@hitachi.com>
Message-ID: <20171206152005.yfbyylu6tbe5gnnv@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 07, 2017 at 12:22:13AM +0900, Takuo Koguchi wrote:
> mclk and hclk need to be disabled explicitly since pm_runtime_disable does
> not disable the clocks.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
> ---
>  drivers/spi/spi-sun4i.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index c5cd635..9011c09 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -525,6 +525,11 @@ static int sun4i_spi_probe(struct platform_device *pdev)
>  
>  static int sun4i_spi_remove(struct platform_device *pdev)
>  {
> +	struct spi_master *master = dev_get_drvdata(&pdev->dev);
> +	struct sun4i_spi *sspi = spi_master_get_devdata(master);
> +
> +	clk_disable_unprepare(sspi->mclk);
> +	clk_disable_unprepare(sspi->hclk);

And that will in turn create an unbalanced disable call if suspend was
called before the remove, which is very likely.

Why are you not calling pm_runtime_force_suspend? How did you test
that patch?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171206/abb6347c/attachment.sig>
