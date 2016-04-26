From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 26 Apr 2016 14:59:41 +0200
Subject: nvmem: mxs-ocotp read problem
In-Reply-To: <571F54DF.9020902@meduna.org>
References: <571F54DF.9020902@meduna.org>
Message-ID: <571F663D.5080703@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stano,

Am 26.04.2016 um 13:45 schrieb Stanislav Meduna:
> Hi,
>
> the mxs_ocotp_read seems to incorrectly iterate through
> the memory to be read, resulting in a buffer overflow/off-area
> access and sometimes oops. 

could you please provide me scenario, so i can test it.

Regards
Stefan

> The following patch seems to fix
> the problem
>
> Regards
>                                Stano
>
>
> diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
> index 8ba19bb..914a4fa 100644
> --- a/drivers/nvmem/mxs-ocotp.c
> +++ b/drivers/nvmem/mxs-ocotp.c
> @@ -94,7 +94,7 @@ static int mxs_ocotp_read(void *context, const void *reg, size_t reg_size,
>         if (ret)
>                 goto close_banks;
>
> -       while (val_size) {
> +       while (val_size >= reg_size) {
>                 if ((offset < OCOTP_DATA_OFFSET) || (offset % 16)) {
>                         /* fill up non-data register */
>                         *buf = 0;
> @@ -103,7 +103,7 @@ static int mxs_ocotp_read(void *context, const void *reg, size_t reg_size,
>                 }
>
>                 buf++;
> -               val_size--;
> +               val_size -= reg_size;
>                 offset += reg_size;
>         }
