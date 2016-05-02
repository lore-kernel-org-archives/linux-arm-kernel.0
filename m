From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 2 May 2016 15:55:53 +0200
Subject: [PATCH v2] nvmem/mxs-ocotp: fix buffer overflow in read
In-Reply-To: <1f26dfe5-c75f-39df-e21e-77aeea408258@meduna.org>
References: <1f26dfe5-c75f-39df-e21e-77aeea408258@meduna.org>
Message-ID: <57275C69.9060902@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,
hi Greg,

Am 27.04.2016 um 14:39 schrieb Stanislav Meduna:
> This patch fixes the issue where the mxs_ocotp_read is reading
> the ocotp in reg_size steps but decrements the remaining size
> by 1. The number of iterations is thus four times higher,
> overwriting the area behind the output buffer.
>
> Fixes: c01e9a11ab6f ("nvmem: add driver for ocotp in i.MX23 and i.MX28")
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Stanislav Meduna <stano@meduna.org>

any change to get this critical fix into 4.6?

Regards
Stefan

> ---
>  drivers/nvmem/mxs-ocotp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
> index 8ba19bb..2bb3c57 100644
> --- a/drivers/nvmem/mxs-ocotp.c
> +++ b/drivers/nvmem/mxs-ocotp.c
> @@ -94,7 +94,7 @@ static int mxs_ocotp_read(void *context, const void *reg, size_t reg_size,
>  	if (ret)
>  		goto close_banks;
>
> -	while (val_size) {
> +	while (val_size >= reg_size) {
>  		if ((offset < OCOTP_DATA_OFFSET) || (offset % 16)) {
>  			/* fill up non-data register */
>  			*buf = 0;
> @@ -103,7 +103,7 @@ static int mxs_ocotp_read(void *context, const void *reg, size_t reg_size,
>  		}
>
>  		buf++;
> -		val_size--;
> +		val_size -= reg_size;
>  		offset += reg_size;
>  	}
>
