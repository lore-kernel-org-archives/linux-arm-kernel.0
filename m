From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Aug 2011 09:54:31 +0100
Subject: [PATCH V2 3/6] spi/spi-pl022: Don't allocate more sg than
	required.
In-Reply-To: <94a975df64a78bb533c85774a5bbd052c73fa5ba.1312965741.git.viresh.kumar@st.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<94a975df64a78bb533c85774a5bbd052c73fa5ba.1312965741.git.viresh.kumar@st.com>
Message-ID: <20110810085431.GD1831@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 02:20:56PM +0530, Viresh Kumar wrote:
> In routine configure_dma(), if transfer->len = PAGE_SIZE, then pages is one more
> than required. While leads to one more sg getting allocated.
> 
> This is wrong. Correct this to allocate correct number of sg.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/spi/spi-pl022.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 80116be..1c8b9ec 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -1016,7 +1016,8 @@ static int configure_dma(struct pl022 *pl022)
>  	dmaengine_slave_config(txchan, &tx_conf);
>  
>  	/* Create sglists for the transfers */
> -	pages = (pl022->cur_transfer->len >> PAGE_SHIFT) + 1;
> +	pages = ((pl022->cur_transfer->len + (1 << PAGE_SHIFT) - 1)
> +			>> PAGE_SHIFT);

It would be far better for this to be:

	pages = DIV_ROUND_UP(pl022->cur_transfer->len, PAGE_SIZE);

The compiler will probably optimize it to the same code anyway.
