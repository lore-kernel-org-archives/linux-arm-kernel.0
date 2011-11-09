From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 9 Nov 2011 16:23:24 +0530
Subject: [PATCH 3/6] spi/pl022: disable the PL022 block when unused
In-Reply-To: <1320835146-31268-1-git-send-email-linus.walleij@stericsson.com>
References: <1320835146-31268-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4EBA5BA4.8030504@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/9/2011 4:09 PM, Linus WALLEIJ wrote:
> From: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> 
> Make sure we clear the enable bit when the block is not used.
> This will save some energy in certain hardware versions.
> 
> Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/spi/spi-pl022.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 305f2ba..fa3eaae 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -512,6 +512,11 @@ static void giveback(struct pl022 *pl022)
>  	msg->state = NULL;
>  	if (msg->complete)
>  		msg->complete(msg->context);
> +
> +	/* disable the SPI/SSP operation */
> +	writew((readw(SSP_CR1(pl022->virtbase)) &
> +		(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
> +
>  	/* This message is completed, so let's turn off the clocks & power */
>  	pm_runtime_put(&pl022->adev->dev);
>  }

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
