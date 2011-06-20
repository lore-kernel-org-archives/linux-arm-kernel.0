From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 20 Jun 2011 09:54:58 -0600
Subject: [PATCH 1/6] serial: samsung: Keep a copy of platform data in
	driver's private data
In-Reply-To: <1308567752-13451-2-git-send-email-thomas.abraham@linaro.org>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
	<1308567752-13451-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <BANLkTikLfbiL0ZpLiysA6qUxv8sj-AVS+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 5:02 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> The driver depends on pdev->dev.platform_data to retrive information
> about the platform data even after the initialization. To add device
> tree support, this has to be changed in way that the platform data
> is avialable from driver's private data. This patch adds support
> for keeping a copy of the plaform data in s3c24xx_uart_info and using
> it when needed after the initialization.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> ?drivers/tty/serial/s5pv210.c | ? 12 ++++++++++--
> ?drivers/tty/serial/samsung.c | ? 24 ++++++++++++++++++++----
> ?drivers/tty/serial/samsung.h | ? ?4 +++-
> ?3 files changed, 33 insertions(+), 7 deletions(-)

Hi Thomas.

Don't forget you need to cc Alan Cox and the linux-serial mailing list
for tty driver patches.

Comments below...

>
> diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
> index d6b2423..3b2021a 100644
> --- a/drivers/tty/serial/s5pv210.c
> +++ b/drivers/tty/serial/s5pv210.c
> @@ -27,9 +27,13 @@
> ?static int s5pv210_serial_setsource(struct uart_port *port,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct s3c24xx_uart_clksrc *clk)
> ?{
> - ? ? ? struct s3c2410_uartcfg *cfg = port->dev->platform_data;
> + ? ? ? struct s3c24xx_uart_port *ourport;
> + ? ? ? struct s3c2410_uartcfg *cfg;
> ? ? ? ?unsigned long ucon = rd_regl(port, S3C2410_UCON);
>
> + ? ? ? ourport = container_of(port, struct s3c24xx_uart_port, port);
> + ? ? ? cfg = &ourport->info->cfg;
> +
> ? ? ? ?if ((cfg->clocks_size) == 1)
> ? ? ? ? ? ? ? ?return 0;
>
> @@ -50,9 +54,13 @@ static int s5pv210_serial_setsource(struct uart_port *port,
> ?static int s5pv210_serial_getsource(struct uart_port *port,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct s3c24xx_uart_clksrc *clk)
> ?{
> - ? ? ? struct s3c2410_uartcfg *cfg = port->dev->platform_data;
> + ? ? ? struct s3c24xx_uart_port *ourport;
> + ? ? ? struct s3c2410_uartcfg *cfg;
> ? ? ? ?u32 ucon = rd_regl(port, S3C2410_UCON);
>
> + ? ? ? ourport = container_of(port, struct s3c24xx_uart_port, port);
> + ? ? ? cfg = &ourport->info->cfg;
> +
> ? ? ? ?clk->divisor = 1;
>
> ? ? ? ?if ((cfg->clocks_size) == 1)
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 7ead421..77d900f 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -42,6 +42,7 @@
> ?#include <linux/delay.h>
> ?#include <linux/clk.h>
> ?#include <linux/cpufreq.h>
> +#include <linux/slab.h>
>
> ?#include <asm/irq.h>
>
> @@ -169,10 +170,13 @@ static inline struct s3c24xx_uart_info *s3c24xx_port_to_info(struct uart_port *p
>
> ?static inline struct s3c2410_uartcfg *s3c24xx_port_to_cfg(struct uart_port *port)
> ?{
> + ? ? ? struct s3c24xx_uart_port *ourport;
> +
> ? ? ? ?if (port->dev == NULL)
> ? ? ? ? ? ? ? ?return NULL;
>
> - ? ? ? return (struct s3c2410_uartcfg *)port->dev->platform_data;
> + ? ? ? ourport = container_of(port, struct s3c24xx_uart_port, port);
> + ? ? ? return &ourport->info->cfg;
> ?}
>
> ?static int s3c24xx_serial_rx_fifocnt(struct s3c24xx_uart_port *ourport,
> @@ -1053,7 +1057,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct platform_device *platdev)
> ?{
> ? ? ? ?struct uart_port *port = &ourport->port;
> - ? ? ? struct s3c2410_uartcfg *cfg;
> + ? ? ? struct s3c2410_uartcfg *cfg = platdev->dev.platform_data;
> ? ? ? ?struct resource *res;
> ? ? ? ?int ret;
>
> @@ -1062,14 +1066,24 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
> ? ? ? ?if (platdev == NULL)
> ? ? ? ? ? ? ? ?return -ENODEV;
>
> - ? ? ? cfg = s3c24xx_dev_to_cfg(&platdev->dev);
> -
> ? ? ? ?if (port->mapbase != 0)
> ? ? ? ? ? ? ? ?return 0;
>
> + ? ? ? if (cfg) {
> + ? ? ? ? ? ? ? memcpy((void *)&info->cfg, cfg, sizeof(struct s3c2410_uartcfg));

"info->cfg = *cfg;" should be sufficient.

> + ? ? ? ? ? ? ? info->cfg.clocks = kzalloc(sizeof(struct s3c24xx_uart_clksrc) *
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? cfg->clocks_size, GFP_KERNEL);
> + ? ? ? ? ? ? ? if (!info->cfg.clocks)
> + ? ? ? ? ? ? ? ? ? ? ? return -ENOMEM;
> + ? ? ? ? ? ? ? memcpy(info->cfg.clocks, cfg->clocks,
> + ? ? ? ? ? ? ? ? ? ? ? sizeof(struct s3c24xx_uart_clksrc) * cfg->clocks_size);
> + ? ? ? }

ewwh. There has to be a better way to do this.  Part of the point of
putting a copy of pdata into the private data structure is to simplify
the driver so that kzallocing wouldn't be necessary.  With that clock
table, the driver actually gets more complex because both DT and
non-DT paths now need to kzalloc a clock array.


>From bogus@does.not.exist.com  Wed Jun  1 12:03:18 2011
From: bogus@does.not.exist.com ()
Date: Wed, 01 Jun 2011 16:03:18 -0000
Subject: No subject
Message-ID: <mailman.30.1308585324.24103.linux-arm-kernel@lists.infradead.org>

a static array of one or two entries; min & max baud are always set to
0, and names are one of:
- uclk & pclk
- uclk
- uclk1
- fclk (with divisor either 10 or 0)
- pclk_low & uclk1

You could also make the clock structure a static array of 2 elements
in the private data structure.  That would simplify both this code and
the followon DT patch.

Also, peaking forward at what the 2nd patch does, I think that it
might just be a little premature to try and decode the clock info from
the DT.  But I'll address that issue when replying to the second
patch.

> +
> + =A0 =A0 =A0 cfg =3D &info->cfg;
> =A0 =A0 =A0 =A0if (cfg->hwport > CONFIG_SERIAL_SAMSUNG_UARTS) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: port %d bigger than %=
d\n", __func__,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg->hwport, CONFIG_SERIAL_SA=
MSUNG_UARTS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(info->cfg.clocks);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ERANGE;
> =A0 =A0 =A0 =A0}
>
> @@ -1181,11 +1195,13 @@ EXPORT_SYMBOL_GPL(s3c24xx_serial_probe);
> =A0int __devexit s3c24xx_serial_remove(struct platform_device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct uart_port *port =3D s3c24xx_dev_to_port(&dev->dev);
> + =A0 =A0 =A0 struct s3c24xx_uart_info *info =3D s3c24xx_port_to_info(por=
t);
>
> =A0 =A0 =A0 =A0if (port) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s3c24xx_serial_cpufreq_deregister(to_ourpo=
rt(port));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_remove_file(&dev->dev, &dev_attr_cl=
ock_source);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_remove_one_port(&s3c24xx_uart_drv, po=
rt);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(info->cfg.clocks);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
> index a69d9a5..4f2f6f5 100644
> --- a/drivers/tty/serial/samsung.h
> +++ b/drivers/tty/serial/samsung.h
> @@ -24,6 +24,9 @@ struct s3c24xx_uart_info {
>
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0has_divslot:1;
>
> + =A0 =A0 =A0 /* copy of platform data */

I'd change this to "copy of /configuration/ data" since the data
doesn't necessarily come from the platform_data pointer anymore.

> + =A0 =A0 =A0 struct s3c2410_uartcfg =A0cfg;
> +
> =A0 =A0 =A0 =A0/* clock source control */
>
> =A0 =A0 =A0 =A0int (*get_clksrc)(struct uart_port *, struct s3c24xx_uart_=
clksrc *clk);
> @@ -56,7 +59,6 @@ struct s3c24xx_uart_port {
> =A0/* conversion functions */
>
> =A0#define s3c24xx_dev_to_port(__dev) (struct uart_port *)dev_get_drvdata=
(__dev)
> -#define s3c24xx_dev_to_cfg(__dev) (struct s3c2410_uartcfg *)((__dev)->pl=
atform_data)
>
> =A0/* register access controls */
>
> --
> 1.6.6.rc2
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
