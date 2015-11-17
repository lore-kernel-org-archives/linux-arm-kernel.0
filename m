From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 17 Nov 2015 12:21:54 +0100
Subject: [PATCH] crypto: atmel: fix 64-bit warnings
In-Reply-To: <4444008.DmhAgm3J77@wuerfel>
References: <4444008.DmhAgm3J77@wuerfel>
Message-ID: <564B0DD2.5040103@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I add my Acked-by to your patch.
By the way, I'm currently reworking this whole driver. So I take your
modifications into account for the new version as many parts of the source code
such as the part dealing with DMA transfers have changed a lot.

The new version fixes the 16 or 32bit counter overflow for the CTR mode,
adds support to the GCM mode and should increase the global performances
(the work is still in progress). For the GCM mode, it relies on the latest
updates from Herbert in linux-next to AEAD algorithms.
The tcrypt module was used to validate the new implementation of CTR and GCM
modes.


Updates in the Atmel SHA driver are also likely to follow.

Thanks for your contribution!

Best regards,

Cyrille

Le 17/11/2015 10:22, Arnd Bergmann a ?crit :
> The atmel AES driver assumes that 'int' and 'size_t' are the same
> type in multiple locations, which the compiler warns about when
> building it for 64-bit systems:
> 
> In file included from ../drivers/crypto/atmel-aes.c:17:0:
> drivers/crypto/atmel-aes.c: In function 'atmel_aes_sg_copy':
> include/linux/kernel.h:724:17: warning: comparison of distinct pointer types lacks a cast
> drivers/crypto/atmel-aes.c:448:11: note: in expansion of macro 'min'
> 
> drivers/crypto/atmel-aes.c: In function 'atmel_aes_crypt_dma_stop':
> include/linux/kern_levels.h:4:18: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'size_t {aka long unsigned int}' [-Wformat=]
> 
> This changes the format strings to use the %z modifier when printing
> a size_t, and makes sure that we use the correct size_t type where
> needed. In case of sg_dma_len(), the type of the result depends
> on CONFIG_NEED_SG_DMA_LENGTH, so we have to use min_t to get it to
> work in all configurations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> 
> diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
> index fb16d812c8f5..bfb1f799bf56 100644
> --- a/drivers/crypto/atmel-aes.c
> +++ b/drivers/crypto/atmel-aes.c
> @@ -184,7 +184,7 @@ static int atmel_aes_sg_length(struct ablkcipher_request *req,
>  static int atmel_aes_sg_copy(struct scatterlist **sg, size_t *offset,
>  			void *buf, size_t buflen, size_t total, int out)
>  {
> -	unsigned int count, off = 0;
> +	size_t count, off = 0;
>  
>  	while (buflen && total) {
>  		count = min((*sg)->length - *offset, total);
> @@ -444,8 +444,8 @@ static int atmel_aes_crypt_dma_start(struct atmel_aes_dev *dd)
>  
>  
>  	if (fast)  {
> -		count = min(dd->total, sg_dma_len(dd->in_sg));
> -		count = min(count, sg_dma_len(dd->out_sg));
> +		count = min_t(size_t, dd->total, sg_dma_len(dd->in_sg));
> +		count = min_t(size_t, count, sg_dma_len(dd->out_sg));
>  
>  		err = dma_map_sg(dd->dev, dd->in_sg, 1, DMA_TO_DEVICE);
>  		if (!err) {
> @@ -639,7 +639,7 @@ static int atmel_aes_crypt_dma_stop(struct atmel_aes_dev *dd)
>  				dd->buf_out, dd->buflen, dd->dma_size, 1);
>  			if (count != dd->dma_size) {
>  				err = -EINVAL;
> -				pr_err("not all data converted: %u\n", count);
> +				pr_err("not all data converted: %zu\n", count);
>  			}
>  		}
>  	}
> @@ -666,7 +666,7 @@ static int atmel_aes_buff_init(struct atmel_aes_dev *dd)
>  	dd->dma_addr_in = dma_map_single(dd->dev, dd->buf_in,
>  					dd->buflen, DMA_TO_DEVICE);
>  	if (dma_mapping_error(dd->dev, dd->dma_addr_in)) {
> -		dev_err(dd->dev, "dma %d bytes error\n", dd->buflen);
> +		dev_err(dd->dev, "dma %zd bytes error\n", dd->buflen);
>  		err = -EINVAL;
>  		goto err_map_in;
>  	}
> @@ -674,7 +674,7 @@ static int atmel_aes_buff_init(struct atmel_aes_dev *dd)
>  	dd->dma_addr_out = dma_map_single(dd->dev, dd->buf_out,
>  					dd->buflen, DMA_FROM_DEVICE);
>  	if (dma_mapping_error(dd->dev, dd->dma_addr_out)) {
> -		dev_err(dd->dev, "dma %d bytes error\n", dd->buflen);
> +		dev_err(dd->dev, "dma %zd bytes error\n", dd->buflen);
>  		err = -EINVAL;
>  		goto err_map_out;
>  	}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-crypto" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
