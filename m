From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 18 Oct 2011 14:43:27 +0530
Subject: [PATCH 2/3] spi/pl022: disable the PL022 block when unused
In-Reply-To: <1318857154-32160-1-git-send-email-linus.walleij@stericsson.com>
References: <1318857154-32160-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4E9D4337.3030700@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2011 6:42 PM, Linus WALLEIJ wrote:
> From: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> 
> Make sure we clear the enable bit when the block is not used.
> This will save some energy in certain hardware versions.
> 
> Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/spi/spi-pl022.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 91700bb..0a1d8ed 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -513,7 +513,12 @@ static void giveback(struct pl022 *pl022)
>  	msg->state = NULL;
>  	if (msg->complete)
>  		msg->complete(msg->context);
> -	/* This message is completed, so let's turn off the clocks & power */
> +
> +	/* disable the SPI/SSP operation */
> +	writew((readw(SSP_CR1(pl022->virtbase)) &
> +		(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
> +
> +	/* This message is completed, so let's turn off the clock! */
>  	clk_disable(pl022->clk);
>  	amba_pclk_disable(pl022->adev);
>  	amba_vcore_disable(pl022->adev);

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
