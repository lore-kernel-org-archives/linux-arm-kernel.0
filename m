From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 27 Jan 2016 14:13:16 +0000
Subject: [PATCH 8/9] net: nb8800: avoid uninitialized variable warning
In-Reply-To: <1453903507-3427225-9-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Wed, 27 Jan 2016 15:04:58 +0100")
References: <1453903507-3427225-1-git-send-email-arnd@arndb.de>
 <1453903507-3427225-9-git-send-email-arnd@arndb.de>
Message-ID: <yw1xsi1jjekj.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The nb8800_poll() function initializes the 'next' variable in the
> loop looking for new input data. We know this will be called at
> least once because 'budget' is a guaranteed to be a positive number
> when we enter the function, but the compiler doesn't know that
> and warns when the variable is used later:
>
> drivers/net/ethernet/aurora/nb8800.c: In function 'nb8800_poll':
> drivers/net/ethernet/aurora/nb8800.c:350:21: warning: 'next' may be used uninitialized in this function [-Wmaybe-uninitialized]

Which gcc version is this?  4.9 doesn't warn here, presumably because
it's clever enough to notice that the offending use of 'next' is under a
condition that can only be true if the first one was.  Of course fixing
the code so older compilers don't warn is a good idea.

> Changing the 'while() {}' loop to 'do {} while()' makes it obvious
> to the compiler what is going on so it no longer warns.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Mans Rullgard <mans@mansr.com>

> ---
>  drivers/net/ethernet/aurora/nb8800.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
> index ecc4a334c507..f71ab2647a3b 100644
> --- a/drivers/net/ethernet/aurora/nb8800.c
> +++ b/drivers/net/ethernet/aurora/nb8800.c
> @@ -302,7 +302,7 @@ static int nb8800_poll(struct napi_struct *napi, int budget)
>  	nb8800_tx_done(dev);
>
>  again:
> -	while (work < budget) {
> +	do {
>  		struct nb8800_rx_buf *rxb;
>  		unsigned int len;
>
> @@ -330,7 +330,7 @@ again:
>  		rxd->report = 0;
>  		last = next;
>  		work++;
> -	}
> +	} while (work < budget);
>
>  	if (work) {
>  		priv->rx_descs[last].desc.config |= DESC_EOC;
> -- 
> 2.7.0
>

-- 
M?ns Rullg?rd
