From: julian.calaby@gmail.com (Julian Calaby)
Date: Fri, 27 May 2016 12:05:12 +1000
Subject: [linux-sunxi] [PATCH 1/5] spi: sunxi: fix transfer timeout
In-Reply-To: <cb90b922caa6ac07c1425d726ea19709ee5284f4.1464130597.git.hramrach@gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
 <cb90b922caa6ac07c1425d726ea19709ee5284f4.1464130597.git.hramrach@gmail.com>
Message-ID: <CAGRGNgWDrVHG26umTSHHAxFC3KXjwmpDejBAfKqvuik0_2-Jcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Fri, May 27, 2016 at 5:25 AM, Michal Suchanek <hramrach@gmail.com> wrote:
> The trasfer timeout is fixed at 1000 ms. Reading a 4Mbyte flash over
> 1MHz SPI bus takes way longer than that. Calculate the timeout from the
> actual time the transfer is supposed to take and multiply by 2 for good
> measure.
>
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>
> v2:
> - fix build error
> - use unsigned instead of int in max_t
> - use tfr->speed_hz instead of sspi->max_speed_hz
> ---
>  drivers/spi/spi-sun4i.c | 11 ++++++++++-
>  drivers/spi/spi-sun6i.c | 11 ++++++++++-
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 1ddd9e2..fe63bbd 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -173,6 +173,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  {
>         struct sun4i_spi *sspi = spi_master_get_devdata(master);
>         unsigned int mclk_rate, div, timeout;
> +       unsigned int start, end, tx_time;
>         unsigned int tx_len = 0;
>         int ret = 0;
>         u32 reg;
> @@ -279,9 +280,17 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>         reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
>         sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
>
> +       tx_time = max_t(unsigned, tfr->len * 8 * 2 / (tfr->speed_hz / 1000),

You should probably use "unsigned int" instead of just "unsigned" here.

> +                       100);
> +       start = jiffies;
>         timeout = wait_for_completion_timeout(&sspi->done,
> -                                             msecs_to_jiffies(1000));
> +                                             msecs_to_jiffies(tx_time));
> +       end = jiffies;
>         if (!timeout) {
> +               dev_warn(&master->dev,
> +                        "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
> +                        dev_name(&spi->dev), tfr->len, tfr->speed_hz,
> +                        jiffies_to_msecs(end - start), tx_time);

Should the debug changes be in a separate patch?

>                 ret = -ETIMEDOUT;
>                 goto out;
>         }
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 42e2c4b..8be5c5c 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -162,6 +162,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
>         unsigned int mclk_rate, div, timeout;
>         unsigned int tx_len = 0;
>         int ret = 0;
> +       unsigned int start, end, tx_time;
>         u32 reg;
>
>         /* We don't support transfer larger than the FIFO */
> @@ -269,9 +270,17 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
>         reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
>         sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
>
> +       tx_time = max_t(unsigned, tfr->len * 8 * 2 / (tfr->speed_hz / 1000),

Ditto, "unsigned int" instead of "unsigned"?

> +                       100);
> +       start = jiffies;
>         timeout = wait_for_completion_timeout(&sspi->done,
> -                                             msecs_to_jiffies(1000));
> +                                             msecs_to_jiffies(tx_time));
> +       end = jiffies;
>         if (!timeout) {
> +               dev_warn(&master->dev,
> +                        "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
> +                        dev_name(&spi->dev), tfr->len, tfr->speed_hz,
> +                        jiffies_to_msecs(end - start), tx_time);

Ditto, separate patch?

Also, should the changes for the drivers be in two separate patches also?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
