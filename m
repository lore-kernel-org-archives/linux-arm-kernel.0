From: clabbe.montjoie@gmail.com (Corentin LABBE)
Date: Wed, 27 Jan 2016 20:42:26 +0100
Subject: [PATCH v2 1/2] crypto: sunxi - don't print confusing data
In-Reply-To: <1453815902-3070323-1-git-send-email-arnd@arndb.de>
References: <1453815902-3070323-1-git-send-email-arnd@arndb.de>
Message-ID: <56A91DA2.5040608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 26/01/2016 14:44, Arnd Bergmann a ?crit :
> gcc correctly warns that the printk output contains a variable that
> it thinks is not initialized in some cases:
> 
> drivers/crypto/sunxi-ss/sun4i-ss-cipher.c: In function 'sun4i_ss_cipher_poll':
> drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:254:76: warning: 'todo' may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:144:15: note: 'todo' was declared here
> 
> A closer look at the function reveals that the variable is always
> initialized at this point (ileft is guaranteed to be positive at the
> start), but its contents are not well-defined:
> Depending on some other variables, it might be either a count in
> words or bytes, and it could refer to either input or output.
> 
> The easiest solution apparently is to remove the confusing output
> and let the reader figure out the state from the other variables.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/crypto/sunxi-ss/sun4i-ss-cipher.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
> index a19ee127edca..7be3fbcd8d78 100644
> --- a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
> +++ b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
> @@ -251,11 +251,10 @@ static int sun4i_ss_cipher_poll(struct ablkcipher_request *areq)
>  		spaces = readl(ss->base + SS_FCSR);
>  		rx_cnt = SS_RXFIFO_SPACES(spaces);
>  		tx_cnt = SS_TXFIFO_SPACES(spaces);
> -		dev_dbg(ss->dev, "%x %u/%u %u/%u cnt=%u %u/%u %u/%u cnt=%u %u %u\n",
> +		dev_dbg(ss->dev, "%x %u/%u %u/%u cnt=%u %u/%u %u/%u cnt=%u %u\n",
>  			mode,
>  			oi, mi.length, ileft, areq->nbytes, rx_cnt,
> -			oo, mo.length, oleft, areq->nbytes, tx_cnt,
> -			todo, ob);
> +			oo, mo.length, oleft, areq->nbytes, tx_cnt, ob);
>  
>  		if (tx_cnt == 0)
>  			continue;
> 

Hello

A bit late but Acked-by: LABBE Corentin <clabbe.montjoie@gmail.com>

Thanks
