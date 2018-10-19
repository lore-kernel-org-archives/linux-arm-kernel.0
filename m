From: evgreen@chromium.org (Evan Green)
Date: Fri, 19 Oct 2018 10:37:35 -0700
Subject: [RFC] i2c: qup: Use the interconnect API
In-Reply-To: <20180920182903.19991-1-georgi.djakov@linaro.org>
References: <20180920182903.19991-1-georgi.djakov@linaro.org>
Message-ID: <CAE=gft4BCgrPCf5UuhxMh8ORCk40C4tnFxWy-QQJ4ag+yObwvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 11:29 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> The interconnect API provides an interface for consumer drivers to express
> their bandwidth needs in the SoC. This data is aggregated and the on-chip
> interconnect hardware is configured to the appropriate power/performance
> profile.
>
> Use the interconnect API to get() the path between the endpoints used for
> data transfers by the I2C QUP and report the needed bandwidth based on the
> i2c mode.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>
> This patch depends on the interconnect API: https://lkml.org/lkml/2018/8/31/444
>
> TODO: Use a macro for converting and rounding to icc units instead of
> converting between kilobits, kilobytes etc. in the consumer drivers.
>
>  drivers/i2c/busses/i2c-qup.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index c86c3ae1318f..436747a74dc6 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -14,6 +14,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> +#include <linux/interconnect.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -280,6 +281,11 @@ struct qup_i2c_dev {
>         void (*read_rx_fifo)(struct qup_i2c_dev *qup);
>         /* function to write tags in tx fifo for i2c read transfer */
>         void (*write_rx_tags)(struct qup_i2c_dev *qup);
> +
> +       /* frequency mode standard */
> +       u32                     clk_freq;
> +       /* interconnect path to scale according to bandwidth needs */
> +       struct icc_path         *path;
>  };
>
>  static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
> @@ -1657,6 +1663,16 @@ static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
>         clk_disable_unprepare(qup->pclk);
>  }
>
> +static void qup_i2c_enable_icc(struct qup_i2c_dev *qup)
> +{
> +       icc_set(qup->path, 0, qup->clk_freq / 8000);

So this specifies an average bandwidth of zero, and a peak bandwidth
of freq / 8000? Can you explain why that is the right choice?
Also, where is this 8000 coming from? Can that be a define, and
possibly explained?

> +}
> +
> +static void qup_i2c_disable_icc(struct qup_i2c_dev *qup)
> +{
> +       icc_set(qup->path, 0, 0);
> +}
> +
