From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 5 Mar 2015 14:51:02 +0100
Subject: [PATCH] mmc: sunxi: avoid invalid pointer calculation
In-Reply-To: <27509084.spYfayGTeo@wuerfel>
References: <27509084.spYfayGTeo@wuerfel>
Message-ID: <CAPDyKFq-V4egasTCgu3O7am_ur2Z8taq4VJHgqaMjAYOR7upLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 February 2015 at 10:47, Arnd Bergmann <arnd@arndb.de> wrote:
> The sunxi mmc driver tries to calculate a dma address by using pointer
> arithmetic, which causes a warning when dma_addr_t is wider than a pointer:
>
> drivers/mmc/host/sunxi-mmc.c: In function 'sunxi_mmc_init_idma_des':
> drivers/mmc/host/sunxi-mmc.c:296:35: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   struct sunxi_idma_des *pdes_pa = (struct sunxi_idma_des *)host->sg_dma;
>                                    ^
>
> To avoid this warning and to simplify the logic, this changes
> the code to avoid the cast and calculate the correct address
> manually. The behavior should be unchanged.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!

Kind regards
Uffe


>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index e8a4218b5726..c326ac965806 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -293,7 +293,7 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>                                     struct mmc_data *data)
>  {
>         struct sunxi_idma_des *pdes = (struct sunxi_idma_des *)host->sg_cpu;
> -       struct sunxi_idma_des *pdes_pa = (struct sunxi_idma_des *)host->sg_dma;
> +       dma_addr_t next_desc = host->sg_dma;
>         int i, max_len = (1 << host->idma_des_size_bits);
>
>         for (i = 0; i < data->sg_len; i++) {
> @@ -305,8 +305,9 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>                 else
>                         pdes[i].buf_size = data->sg[i].length;
>
> +               next_desc += sizeof(struct sunxi_idma_des);
>                 pdes[i].buf_addr_ptr1 = sg_dma_address(&data->sg[i]);
> -               pdes[i].buf_addr_ptr2 = (u32)&pdes_pa[i + 1];
> +               pdes[i].buf_addr_ptr2 = (u32)next_desc;
>         }
>
>         pdes[0].config |= SDXC_IDMAC_DES0_FD;
>
