From: gmbnomis@gmail.com (Simon Baatz)
Date: Fri, 11 Jan 2013 01:43:24 +0100
Subject: [PATCH] mmc: mvsdio: Replace IS_ERR_NULL() is with IS_ERR()
In-Reply-To: <1357849755-8168-1-git-send-email-andrew@lunn.ch>
References: <1357849755-8168-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130111004323.GA12257@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Thu, Jan 10, 2013 at 09:29:15PM +0100, Andrew Lunn wrote:
> A NULL is a valid clk cookie, so we should not be tested with
> IS_ERR_NULL(). Replace it with IS_ERR().
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/mmc/host/mvsdio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index de4c20b..d0050fa 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -839,7 +839,7 @@ out:
>  	if (r)
>  		release_resource(r);
>  	if (mmc)
> -		if (!IS_ERR_OR_NULL(host->clk)) {
> +		if (!IS_ERR(host->clk)) {
>  			clk_disable_unprepare(host->clk);
>  			clk_put(host->clk);
>  		}

Hmm. I think this check was originally intended to go under "if
(host)" above and not here.  Notice the indentation mismatch/missing
braces for "if (mmc)". My bad.

Additionally, host->clk == NULL is not necessarily the result of
clk_get() but it can also be NULL if the irq could not be assigned. 
Leading to unbalanced clk calls in this case.


- Simon
