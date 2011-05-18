From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 18 May 2011 23:29:09 +0800
Subject: [PATCH] MAX1111: Fix race condition causing NULL pointer exception
In-Reply-To: <1305731918-20164-1-git-send-email-morpheus.ibis@gmail.com>
References: <1305731918-20164-1-git-send-email-morpheus.ibis@gmail.com>
Message-ID: <BANLkTikYUf7Bb9_2hDSYAOmRazJmcHzzWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2011 at 11:18 PM, Pavel Herrmann
<morpheus.ibis@gmail.com> wrote:
> spi_sync call uses its spi_message parameter to keep completion information,
> having this structure static is not thread-safe, potentially causing one
> thread having pointers to memory on or above other threads stack. use
> per-call spi_message on stack to fix this
>
> Signed-off-by: Pavel Herrmann <morpheus.ibis@gmail.com>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

OK

> ---
> ?drivers/hwmon/max1111.c | ? 86 +++++++++++++----------------------------------
> ?1 files changed, 24 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
> index 12a54aa..6422baf 100644
> --- a/drivers/hwmon/max1111.c
> +++ b/drivers/hwmon/max1111.c
> @@ -22,9 +22,6 @@
> ?#include <linux/spi/spi.h>
> ?#include <linux/slab.h>
>
> -#define MAX1111_TX_BUF_SIZE ? ?1
> -#define MAX1111_RX_BUF_SIZE ? ?2
> -
> ?/* MAX1111 Commands */
> ?#define MAX1111_CTRL_PD0 ? ? ?(1u << 0)
> ?#define MAX1111_CTRL_PD1 ? ? ?(1u << 1)
> @@ -36,35 +33,41 @@
> ?struct max1111_data {
> ? ? ? ?struct spi_device ? ? ? *spi;
> ? ? ? ?struct device ? ? ? ? ? *hwmon_dev;
> - ? ? ? struct spi_message ? ? ?msg;
> - ? ? ? struct spi_transfer ? ? xfer[2];
> - ? ? ? uint8_t *tx_buf;
> - ? ? ? uint8_t *rx_buf;
> ?};
>
> ?static int max1111_read(struct device *dev, int channel)
> ?{
> - ? ? ? struct max1111_data *data = dev_get_drvdata(dev);
> - ? ? ? uint8_t v1, v2;
> ? ? ? ?int err;
> -
> - ? ? ? data->tx_buf[0] = (channel << MAX1111_CTRL_SEL_SH) |
> - ? ? ? ? ? ? ? MAX1111_CTRL_PD0 | MAX1111_CTRL_PD1 |
> - ? ? ? ? ? ? ? MAX1111_CTRL_SGL | MAX1111_CTRL_UNI | MAX1111_CTRL_STR;
> -
> - ? ? ? err = spi_sync(data->spi, &data->msg);
> + ? ? ? struct max1111_data *data = dev_get_drvdata(dev);
> + ? ? ? struct spi_message m;
> + ? ? ? struct spi_transfer t[2];
> + ? ? ? uint8_t rx_buf[2] = {0, 0};
> + ? ? ? uint8_t tx_buf = (channel << MAX1111_CTRL_SEL_SH) |
> + ? ? ? ? ? ? ? ? ? ? ? MAX1111_CTRL_PD0 | MAX1111_CTRL_PD1 |
> + ? ? ? ? ? ? ? ? ? ? ? MAX1111_CTRL_SGL | MAX1111_CTRL_UNI |
> + ? ? ? ? ? ? ? ? ? ? ? MAX1111_CTRL_STR;
> +
> + ? ? ? spi_message_init(&m);
> + ? ? ? memset(t, 0, sizeof(t));
> +
> + ? ? ? t[0].tx_buf = &tx_buf;
> + ? ? ? t[0].len = 1;
> + ? ? ? spi_message_add_tail(&t[0], &m);
> +
> + ? ? ? t[1].rx_buf = rx_buf;
> + ? ? ? t[1].len = 2;
> + ? ? ? spi_message_add_tail(&t[1], &m);
> +
> + ? ? ? err = spi_sync(data->spi, &m);
> ? ? ? ?if (err < 0) {
> ? ? ? ? ? ? ? ?dev_err(dev, "spi_sync failed with %d\n", err);
> ? ? ? ? ? ? ? ?return err;
> ? ? ? ?}
>
> - ? ? ? v1 = data->rx_buf[0];
> - ? ? ? v2 = data->rx_buf[1];
> -
> - ? ? ? if ((v1 & 0xc0) || (v2 & 0x3f))
> + ? ? ? if ((rx_buf[0] & 0xc0) || (rx_buf[1] & 0x3f))
> ? ? ? ? ? ? ? ?return -EINVAL;
>
> - ? ? ? return (v1 << 2) | (v2 >> 6);
> + ? ? ? return (rx_buf[0] << 2) | (rx_buf[1] >> 6);
> ?}
>
> ?#ifdef CONFIG_SHARPSL_PM
> @@ -123,38 +126,6 @@ static const struct attribute_group max1111_attr_group = {
> ? ? ? ?.attrs ?= max1111_attributes,
> ?};
>
> -static int setup_transfer(struct max1111_data *data)
> -{
> - ? ? ? struct spi_message *m;
> - ? ? ? struct spi_transfer *x;
> -
> - ? ? ? data->tx_buf = kmalloc(MAX1111_TX_BUF_SIZE, GFP_KERNEL);
> - ? ? ? if (!data->tx_buf)
> - ? ? ? ? ? ? ? return -ENOMEM;
> -
> - ? ? ? data->rx_buf = kmalloc(MAX1111_RX_BUF_SIZE, GFP_KERNEL);
> - ? ? ? if (!data->rx_buf) {
> - ? ? ? ? ? ? ? kfree(data->tx_buf);
> - ? ? ? ? ? ? ? return -ENOMEM;
> - ? ? ? }
> -
> - ? ? ? m = &data->msg;
> - ? ? ? x = &data->xfer[0];
> -
> - ? ? ? spi_message_init(m);
> -
> - ? ? ? x->tx_buf = &data->tx_buf[0];
> - ? ? ? x->len = 1;
> - ? ? ? spi_message_add_tail(x, m);
> -
> - ? ? ? x++;
> - ? ? ? x->rx_buf = &data->rx_buf[0];
> - ? ? ? x->len = 2;
> - ? ? ? spi_message_add_tail(x, m);
> -
> - ? ? ? return 0;
> -}
> -
> ?static int __devinit max1111_probe(struct spi_device *spi)
> ?{
> ? ? ? ?struct max1111_data *data;
> @@ -172,17 +143,13 @@ static int __devinit max1111_probe(struct spi_device *spi)
> ? ? ? ? ? ? ? ?return -ENOMEM;
> ? ? ? ?}
>
> - ? ? ? err = setup_transfer(data);
> - ? ? ? if (err)
> - ? ? ? ? ? ? ? goto err_free_data;
> -
> ? ? ? ?data->spi = spi;
> ? ? ? ?spi_set_drvdata(spi, data);
>
> ? ? ? ?err = sysfs_create_group(&spi->dev.kobj, &max1111_attr_group);
> ? ? ? ?if (err) {
> ? ? ? ? ? ? ? ?dev_err(&spi->dev, "failed to create attribute group\n");
> - ? ? ? ? ? ? ? goto err_free_all;
> + ? ? ? ? ? ? ? goto err_free_data;
> ? ? ? ?}
>
> ? ? ? ?data->hwmon_dev = hwmon_device_register(&spi->dev);
> @@ -199,9 +166,6 @@ static int __devinit max1111_probe(struct spi_device *spi)
>
> ?err_remove:
> ? ? ? ?sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
> -err_free_all:
> - ? ? ? kfree(data->rx_buf);
> - ? ? ? kfree(data->tx_buf);
> ?err_free_data:
> ? ? ? ?kfree(data);
> ? ? ? ?return err;
> @@ -213,8 +177,6 @@ static int __devexit max1111_remove(struct spi_device *spi)
>
> ? ? ? ?hwmon_device_unregister(data->hwmon_dev);
> ? ? ? ?sysfs_remove_group(&spi->dev.kobj, &max1111_attr_group);
> - ? ? ? kfree(data->rx_buf);
> - ? ? ? kfree(data->tx_buf);
> ? ? ? ?kfree(data);
> ? ? ? ?return 0;
> ?}
> --
> 1.7.5.rc3
>
>
