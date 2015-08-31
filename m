From: drinkcat@chromium.org (Nicolas Boichat)
Date: Mon, 31 Aug 2015 15:54:13 +0800
Subject: [PATCH v2] spi: bitbang: Replace spinlock by mutex
In-Reply-To: <1439783574-5933-1-git-send-email-drinkcat@chromium.org>
References: <1439783574-5933-1-git-send-email-drinkcat@chromium.org>
Message-ID: <CANMq1KAOsyhT1w54dc1u6JRzUdrjo-RpCb7CQBD66OdrSyPh=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Aug 17, 2015 at 11:52 AM, Nicolas Boichat <drinkcat@chromium.org> wrote:
> chipselect (in the case of spi-gpio: spi_gpio_chipselect, which
> calls gpiod_set_raw_value_cansleep) can sleep, so we should not
> hold a spinlock while calling it from spi_bitbang_setup.
>
> This issue was introduced by this commit, which converted spi-gpio
> to cansleep variants:
> d9dda5a191 "spi: spi-gpio: Use 'cansleep' variants to access GPIO"
>
> Replacing the lock variable by a mutex fixes the issue: This is
> safe as all instances where the lock is used are called from
> contexts that can sleep.
>
> Finally, update spi-ppc4xx and and spi-s3c24xx to use mutex
> functions, as they directly hold the lock for similar purpose.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> Going the "safer" way and just replacing the spinlock by a
> mutex.
>
> Applies on top of broonie-sound/for-next, and compile-tested on
> x86-64/arm (allyesconfig) and ppc44x (defconfig+SPI driver),
> and runtime-tested on an arm platform.
>
> Thanks!

Any update on this patch? It still applies on for-next but happy to
resend if necessary (patchwork:
https://patchwork.kernel.org/patch/7023091/).

Best,

>  drivers/spi/spi-bitbang.c       | 17 +++++++----------
>  drivers/spi/spi-ppc4xx.c        |  4 ++--
>  drivers/spi/spi-s3c24xx.c       |  4 ++--
>  include/linux/spi/spi_bitbang.h |  2 +-
>  4 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
> index 840a498..ef43ef5 100644
> --- a/drivers/spi/spi-bitbang.c
> +++ b/drivers/spi/spi-bitbang.c
> @@ -180,7 +180,6 @@ int spi_bitbang_setup(struct spi_device *spi)
>  {
>         struct spi_bitbang_cs   *cs = spi->controller_state;
>         struct spi_bitbang      *bitbang;
> -       unsigned long           flags;
>
>         bitbang = spi_master_get_devdata(spi->master);
>
> @@ -210,12 +209,12 @@ int spi_bitbang_setup(struct spi_device *spi)
>          */
>
>         /* deselect chip (low or high) */
> -       spin_lock_irqsave(&bitbang->lock, flags);
> +       mutex_lock(&bitbang->lock);
>         if (!bitbang->busy) {
>                 bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
>                 ndelay(cs->nsecs);
>         }
> -       spin_unlock_irqrestore(&bitbang->lock, flags);
> +       mutex_unlock(&bitbang->lock);
>
>         return 0;
>  }
> @@ -255,13 +254,12 @@ static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
>  static int spi_bitbang_prepare_hardware(struct spi_master *spi)
>  {
>         struct spi_bitbang      *bitbang;
> -       unsigned long           flags;
>
>         bitbang = spi_master_get_devdata(spi);
>
> -       spin_lock_irqsave(&bitbang->lock, flags);
> +       mutex_lock(&bitbang->lock);
>         bitbang->busy = 1;
> -       spin_unlock_irqrestore(&bitbang->lock, flags);
> +       mutex_unlock(&bitbang->lock);
>
>         return 0;
>  }
> @@ -378,13 +376,12 @@ static int spi_bitbang_transfer_one(struct spi_master *master,
>  static int spi_bitbang_unprepare_hardware(struct spi_master *spi)
>  {
>         struct spi_bitbang      *bitbang;
> -       unsigned long           flags;
>
>         bitbang = spi_master_get_devdata(spi);
>
> -       spin_lock_irqsave(&bitbang->lock, flags);
> +       mutex_lock(&bitbang->lock);
>         bitbang->busy = 0;
> -       spin_unlock_irqrestore(&bitbang->lock, flags);
> +       mutex_unlock(&bitbang->lock);
>
>         return 0;
>  }
> @@ -427,7 +424,7 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
>         if (!master || !bitbang->chipselect)
>                 return -EINVAL;
>
> -       spin_lock_init(&bitbang->lock);
> +       mutex_init(&bitbang->lock);
>
>         if (!master->mode_bits)
>                 master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
> diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
> index 54fb984..dd3d0a2 100644
> --- a/drivers/spi/spi-ppc4xx.c
> +++ b/drivers/spi/spi-ppc4xx.c
> @@ -210,12 +210,12 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
>         if (in_8(&hw->regs->cdm) != cdm)
>                 out_8(&hw->regs->cdm, cdm);
>
> -       spin_lock(&hw->bitbang.lock);
> +       mutex_lock(&hw->bitbang.lock);
>         if (!hw->bitbang.busy) {
>                 hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
>                 /* Need to ndelay here? */
>         }
> -       spin_unlock(&hw->bitbang.lock);
> +       mutex_unlock(&hw->bitbang.lock);
>
>         return 0;
>  }
> diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
> index f36bc32..4e7d1bf 100644
> --- a/drivers/spi/spi-s3c24xx.c
> +++ b/drivers/spi/spi-s3c24xx.c
> @@ -198,12 +198,12 @@ static int s3c24xx_spi_setup(struct spi_device *spi)
>         if (ret)
>                 return ret;
>
> -       spin_lock(&hw->bitbang.lock);
> +       mutex_lock(&hw->bitbang.lock);
>         if (!hw->bitbang.busy) {
>                 hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
>                 /* need to ndelay for 0.5 clocktick ? */
>         }
> -       spin_unlock(&hw->bitbang.lock);
> +       mutex_unlock(&hw->bitbang.lock);
>
>         return 0;
>  }
> diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
> index 85578d4..154788e 100644
> --- a/include/linux/spi/spi_bitbang.h
> +++ b/include/linux/spi/spi_bitbang.h
> @@ -4,7 +4,7 @@
>  #include <linux/workqueue.h>
>
>  struct spi_bitbang {
> -       spinlock_t              lock;
> +       struct mutex            lock;
>         u8                      busy;
>         u8                      use_dma;
>         u8                      flags;          /* extra spi->mode support */
> --
> 2.5.0.276.gf5e568e
>
