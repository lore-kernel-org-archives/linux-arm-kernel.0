From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 20 Jun 2011 10:43:50 -0600
Subject: [PATCH 2/6] serial: samsung: Add device tree support for s5pv210
	uart driver
In-Reply-To: <1308567752-13451-3-git-send-email-thomas.abraham@linaro.org>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
	<1308567752-13451-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <BANLkTi=+FKz-uPtSv572y5ORorMeGR8Anw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 5:02 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> For device tree based probe, the dependecy on pdev->id to attach a
> corresponding default port info to the driver's private data is
> removed. The fifosize parameter is obtained from the device tree
> node and the next available instance of port info is updated
> with the fifosize value and attached to the driver's private data.
>
> The samsung uart core driver is also modified to parse the device
> tree node and pick up the platform data from the node.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> ?.../bindings/tty/serial/samsung_uart.txt ? ? ? ? ? | ? 50 +++++++++++
> ?drivers/tty/serial/s5pv210.c ? ? ? ? ? ? ? ? ? ? ? | ? 27 ++++++-
> ?drivers/tty/serial/samsung.c ? ? ? ? ? ? ? ? ? ? ? | ? 90 ++++++++++++++++++++
> ?3 files changed, 166 insertions(+), 1 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/tty/serial/samsung_uart.txt
>
> diff --git a/Documentation/devicetree/bindings/tty/serial/samsung_uart.txt b/Documentation/devicetree/bindings/tty/serial/samsung_uart.txt
> new file mode 100644
> index 0000000..4c0783d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tty/serial/samsung_uart.txt
> @@ -0,0 +1,50 @@
> +* Samsung's UART Controller
> +
> +The Samsung's UART controller is used for serial communications on all of
> +Samsung's s3c24xx, s3c64xx and s5p series application processors.
> +
> +Required properties:
> +- compatible : should be specific to the application processor
> + ? ? ? - "samsung,s5pv210-uart" , for s5pc110, s5pv210 and Exynos4 family.
> + ? ? ? - "samsung,s3c6400-uart", for s3c64xx, s5p64xx and s5pc100.
> + ? ? ? - "samsung,s3c2410-uart", for s3c2410.
> + ? ? ? - "samsung,s3c2412-uart", for s3c2412.
> + ? ? ? - "samsung,s3c2440-uart", for s3c244x.
> +
> +- reg : ? ? ? ?base physical address of the controller and length of memory mapped
> + ? ? ? region.
> +
> +- interrupts : Three interrupt numbers should be specified in the following
> + ? ? ? order - TX interrupt, RX interrupt, Error Interrupt.
> +
> +- hwport : Instance number of the UART controller in the processor.
> + ? ? ? (ToDo: Remove this from the driver).
> +
> +- flags : Not used, but set value as 0. (ToDo: Remove this flag from driver).

If they are to be removed, then you should drop them from the documentation.

> +
> +- uart_flags : Additional serial core flags to passed to the serial core
> + ? ? ? when the driver is registred. For example: UPF_CONS_FLOW.

Underscores are discouraged in property and node names.  Use '-' instead.

For custom properties, you should prefix the property name with 'samsung,'.

This looks very much like directly encoding the Linux flags into the
device tree.  The binding should be completely contained within
itself, and not refer to OS implementation details.  It is fine to use
the same values that Linux happens to use, but they need to still be
explicitly documented as to what they mean.  Also, a 'flags' property
usually isn't very friendly to mere-mortals when the explicit
behaviour can be enabled with the presence of a named property.  For
example; something like a "samsung,uart-has-rtscts" to enable rts/cts.

> +
> +- has_fracval : Set to 1, if the controller supports fractional part of
> + ? ? ? for the baud divisor, otherwise, set to 0.

Boolean stuff often doesn't need a value.  If the property is present,
it is a '1'.  If it isn't, then it is a '0'.

> +
> +- ucon_default : Default board specific setting of UCON register.
> +
> +- ulcon_default : Default board specific setting of ULCON register.
> +
> +- ufcon_default : Default board specific setting of UFCON register.

I think I've commented on this before, but I do try to avoid direct
coding registers into the DT.  That said, sometimes there really isn't
a nice human-friendly way of encoding things and direct register
values is the best approach.

> +
> +- uart_clksrc : One or more child nodes representing the clock sources that
> + ? ? ? could be used to derive the buad rate. Each of these child nodes
> + ? ? ? has four required properties.
> +
> + ? ? ? - name : Name of the parent clock.
> + ? ? ? - divisor : divisor from the clock to the uart controller.
> + ? ? ? - min_baud : Minimum baud rate for which this clock can be used.
> + ? ? ? ? ? ? ? ? ? ? ? Set to zero, if there is no limitation.
> + ? ? ? - max_buad : Maximum baud rate for which this clock can be used.

typo: s/buad/baud/

> + ? ? ? ? ? ? ? ? ? ? ? Set to zero, if there is no limitation.

This looks to be directly encoding the current Linux implementation
details into the device tree (it is a direct copy of the config
structure members), and it doesn't use the common clock binding.  It's
fine to use sub nodes for each clock attachment, particularly because
it looks like the uart is able to apply it's own divisor to the clock
input, but I would definitely encode the data using the existing
struct clock binding.

> +
> +Optional properties:
> +- fifosize: Size of the tx/rx fifo used in the controller. If not specified,
> + ? ? ? the default value of the fifosize is 16.
> diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
> index 3b2021a..9aacbda 100644
> --- a/drivers/tty/serial/s5pv210.c
> +++ b/drivers/tty/serial/s5pv210.c
> @@ -18,6 +18,7 @@
> ?#include <linux/init.h>
> ?#include <linux/serial_core.h>
> ?#include <linux/serial.h>
> +#include <linux/of.h>
>
> ?#include <asm/irq.h>
> ?#include <mach/hardware.h>
> @@ -131,15 +132,39 @@ static struct s3c24xx_uart_info *s5p_uart_inf[] = {
> ?/* device management */
> ?static int s5p_serial_probe(struct platform_device *pdev)
> ?{
> - ? ? ? return s3c24xx_serial_probe(pdev, s5p_uart_inf[pdev->id]);
> + ? ? ? const void *prop;
> + ? ? ? unsigned int port = pdev->id;
> + ? ? ? unsigned int fifosize = 16;
> + ? ? ? static unsigned int probe_index;
> +
> + ? ? ? if (pdev->dev.of_node) {
> + ? ? ? ? ? ? ? prop = of_get_property(pdev->dev.of_node, "fifosize", NULL);
> + ? ? ? ? ? ? ? if (prop)
> + ? ? ? ? ? ? ? ? ? ? ? fifosize = be32_to_cpu(*(u32 *)prop);

Okay, this is getting ugly (not your fault, but this pattern has
become too common.  Can you craft and post a patch that adds the
following functions to drivers/of/base.c and include/linux/of.h

/* offset in cells, not bytes */
int dt_decode_u32(struct *property, int offset, u32 *out_val)
{
        if (!property || !property->value)
                return -EINVAL;
        if ((offset + 1) * 4 > property->length)
                return -EINVAL;
        *out_val = of_read_number(property->value + (offset * 4), 1);
        return 0;
}
int dt_decode_u64(struct *property, int offset, u64 *out_val)
{
...
}
int dt_decode_string(struct *property, int index, char **out_string);
{
...
}

Plus a set of companion functions:
int dt_getprop_u32(struct device_node *np, char *propname, int offset,
u32 *out_val)
{
        return dt_decode_u32(of_find_property(np, propname, NULL),
offset, out_val);
}
int dt_getprop_u64(struct *device_node, char *propname, int offset,
u64 *out_val);
{
...
}
int dt_getprop_string(struct *device_node, char *propname, int index,
char **out_string);
{
...
}

Then you'll be able to simply do the following to decode each
property, with fifosize being left alone if the property cannot be
found or decoded:

dt_getprop_u32(pdev->dev.of_node, "samsung,fifosize", &fifosize);

> +#ifdef CONFIG_OF
> +static const struct of_device_id s5pv210_uart_match[] = {
> + ? ? ? { .compatible = "samsung,s5pv210-uart" },
> + ? ? ? {},
> +};
> +MODULE_DEVICE_TABLE(of, s5pv210_uart_match);
> +#else
> +#define s5pv210_uart_match NULL
> +#endif
> +
> ?static struct platform_driver s5p_serial_driver = {
> ? ? ? ?.probe ? ? ? ? ?= s5p_serial_probe,
> ? ? ? ?.remove ? ? ? ? = __devexit_p(s3c24xx_serial_remove),
> ? ? ? ?.driver ? ? ? ? = {
> ? ? ? ? ? ? ? ?.name ? = "s5pv210-uart",
> ? ? ? ? ? ? ? ?.owner ?= THIS_MODULE,
> + ? ? ? ? ? ? ? .of_match_table = s5pv210_uart_match,
> ? ? ? ?},
> ?};
>
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 77d900f..1e58a7b 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -43,6 +43,7 @@
> ?#include <linux/clk.h>
> ?#include <linux/cpufreq.h>
> ?#include <linux/slab.h>
> +#include <linux/of.h>
>
> ?#include <asm/irq.h>
>
> @@ -1047,6 +1048,91 @@ static inline void s3c24xx_serial_cpufreq_deregister(struct s3c24xx_uart_port *p
> ?}
> ?#endif
>
> +/*
> + * s3c24xx_serial_parse_dt
> + *
> + * Parse the platform data from the device tree and keep a copy of it.
> + */
> +
> +static int s3c24xx_serial_parse_dt(struct device_node *np,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct s3c2410_uartcfg *cfg)
> +{
> + ? ? ? struct s3c24xx_uart_clksrc *clksrc = NULL;
> + ? ? ? struct device_node *child = NULL;
> + ? ? ? unsigned int len;
> + ? ? ? const void *prop;
> +
> + ? ? ? if (!np)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? prop = of_get_property(np, "hwport", &len);
> + ? ? ? if (prop && len)
> + ? ? ? ? ? ? ? cfg->hwport = be32_to_cpu(*(u32 *)prop);
> +
> + ? ? ? prop = of_get_property(np, "flags", &len);
> + ? ? ? if (prop && len)
> + ? ? ? ? ? ? ? cfg->flags = be32_to_cpu(*(u32 *)prop);
> +
> + ? ? ? prop = of_get_property(np, "uart_flags", &len);
> + ? ? ? if (prop && len)
> + ? ? ? ? ? ? ? cfg->uart_flags = be32_to_cpu(*(u32 *)prop);
> +
> + ? ? ? prop = of_get_property(np, "has_fracval", &len);
> + ? ? ? if (prop && len)
> + ? ? ? ? ? ? ? cfg->has_fracval = be32_to_cpu(*(u32 *)prop);
> +
> + ? ? ? prop = of_get_property(np, "ucon_default", &len);
> + ? ? ? if (prop && len)
> + ? ? ? ? ? ? ? cfg->ucon = be32_to_cpu(*(u32 *)prop);
> +
> + ? ? ? prop = of_get_property(np, "ulcon_default", &len);
> + ? ? ? if (prop && len)
> + ? ? ? ? ? ? ? cfg->ulcon = be32_to_cpu(*(u32 *)prop);
> +
> + ? ? ? prop = of_get_property(np, "ufcon_default", &len);
> + ? ? ? if (prop && len)
> + ? ? ? ? ? ? ? cfg->ufcon = be32_to_cpu(*(u32 *)prop);
> +
> + ? ? ? /* Count the number of clock source options available */
> + ? ? ? len = 0;
> +
> + ? ? ? while ((child = of_get_next_child(np, child)))
> + ? ? ? ? ? ? ? len++;
> +
> + ? ? ? if (len) {
> + ? ? ? ? ? ? ? clksrc = kzalloc(sizeof(struct s3c24xx_uart_clksrc) * len,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? GFP_KERNEL);
> + ? ? ? ? ? ? ? if (!clksrc)
> + ? ? ? ? ? ? ? ? ? ? ? return -ENOMEM;
> + ? ? ? }
> +
> + ? ? ? cfg->clocks = clksrc;
> + ? ? ? cfg->clocks_size = len;
> +
> + ? ? ? /* Read the information about all clock sources */
> + ? ? ? for_each_child_of_node(np, child) {
> + ? ? ? ? ? ? ? prop = of_get_property(child, "clk_name", &len);
> + ? ? ? ? ? ? ? if (prop && len)
> + ? ? ? ? ? ? ? ? ? ? ? clksrc->name = (const char *)prop;
> +
> + ? ? ? ? ? ? ? prop = of_get_property(child, "divisor", &len);
> + ? ? ? ? ? ? ? if (prop && len)
> + ? ? ? ? ? ? ? ? ? ? ? clksrc->divisor = be32_to_cpu(*(u32 *)prop);
> +
> + ? ? ? ? ? ? ? prop = of_get_property(child, "min_baud", &len);
> + ? ? ? ? ? ? ? if (prop && len)
> + ? ? ? ? ? ? ? ? ? ? ? clksrc->min_baud = be32_to_cpu(*(u32 *)prop);
> +
> + ? ? ? ? ? ? ? prop = of_get_property(child, "max_baud", &len);
> + ? ? ? ? ? ? ? if (prop && len)
> + ? ? ? ? ? ? ? ? ? ? ? clksrc->max_baud = be32_to_cpu(*(u32 *)prop);
> +
> + ? ? ? ? ? ? ? clksrc++;
> + ? ? ? }
> +
> + ? ? ? return 0;
> +}
> +
> ?/* s3c24xx_serial_init_port
> ?*
> ?* initialise a single serial port from the platform device given
> @@ -1077,6 +1163,10 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
> ? ? ? ? ? ? ? ? ? ? ? ?return -ENOMEM;
> ? ? ? ? ? ? ? ?memcpy(info->cfg.clocks, cfg->clocks,
> ? ? ? ? ? ? ? ? ? ? ? ?sizeof(struct s3c24xx_uart_clksrc) * cfg->clocks_size);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? ret = s3c24xx_serial_parse_dt(platdev->dev.of_node, &info->cfg);
> + ? ? ? ? ? ? ? if (ret)
> + ? ? ? ? ? ? ? ? ? ? ? return ret;
> ? ? ? ?}
>
> ? ? ? ?cfg = &info->cfg;
> --
> 1.6.6.rc2
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
