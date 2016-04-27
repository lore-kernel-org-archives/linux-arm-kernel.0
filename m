From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 27 Apr 2016 14:24:33 +0200
Subject: [PATCH] nvmem/mxs-ocotp: fix buffer overflow in read
In-Reply-To: <201ccd58-8735-02d8-b4e4-9d2eda828fd8@meduna.org>
References: <201ccd58-8735-02d8-b4e4-9d2eda828fd8@meduna.org>
Message-ID: <5720AF81.2080402@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stano,

[add Srinivas and Maxime to CC]

Am 27.04.2016 um 13:53 schrieb Stanislav Meduna:
> This patch fixes the issue where the mxs_ocotp_read is reading
> the ocotp in reg_size steps but decrements the remaining size
> by 1. The number of iterations is thus four times higher,
> overwriting the area behind the output buffer.

please add your Signed-off-by here.

>
> Fixes: c01e9a11ab6f ("nvmem: add driver for ocotp in i.MX23 and i.MX28")

I tested the patch successful with i.MX23 and i.MX28.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

@Srinivas: I think this patch should go to stable.

Regards

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
