From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 10 Aug 2011 23:11:01 +0530
Subject: [PATCH 2/4] serial: s5pv210: Add device tree support
In-Reply-To: <20110803091249.GB28651@trinity.fluff.org>
References: <1312326509-2723-1-git-send-email-thomas.abraham@linaro.org>
	<1312326509-2723-3-git-send-email-thomas.abraham@linaro.org>
	<20110803091249.GB28651@trinity.fluff.org>
Message-ID: <CAJuYYwS8Wr38WPQsu7-EHEK5YFn0823eKjj-yTxyp7=c23KnPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On 3 August 2011 14:42, Ben Dooks <ben-linux@fluff.org> wrote:
> On Wed, Aug 03, 2011 at 12:08:27AM +0100, Thomas Abraham wrote:
>> For device tree based probe, the dependecy on pdev->id to attach a
>> corresponding default port info to the driver's private data is
>> removed. The fifosize parameter is obtained from the device tree
>> node and the next available instance of port info is updated
>> with the fifosize value and attached to the driver's private data.
>> The default platform data is selected based on the compatible property.
>>
>> CC: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?.../devicetree/bindings/serial/samsung_uart.txt ? ?| ? 16 +++++++
>> ?drivers/tty/serial/s5pv210.c ? ? ? ? ? ? ? ? ? ? ? | ? 43 +++++++++++++++++++-
>> ?drivers/tty/serial/samsung.c ? ? ? ? ? ? ? ? ? ? ? | ? ?5 ++-
>> ?3 files changed, 62 insertions(+), 2 deletions(-)
>> ?create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt
>>

[...]

>> ?/* device management */
>> ?static int s5p_serial_probe(struct platform_device *pdev)
>> ?{
>> - ? ? return s3c24xx_serial_probe(pdev, s5p_uart_inf[pdev->id]);
>> + ? ? static unsigned int probe_index;
>> + ? ? unsigned int port = pdev->id;
>> + ? ? const struct of_device_id *match;
>> + ? ? struct s3c2410_uartcfg *cfg;
>> +
>> + ? ? if (pdev->dev.of_node) {
>> + ? ? ? ? ? ? if (of_property_read_u32(pdev->dev.of_node,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? "samsung,uart-fifosize",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? &s5p_uart_inf[probe_index]->fifosize))
>> + ? ? ? ? ? ? ? ? ? ? return -EINVAL;
>
> I'd rather see the fifo size either being a property of the soc itself
> or being inferred by the compatible field.

When using the compatible field to infer the fifosize of the
controller, the code looks as listed below.

struct s3c24xx_uart_dt_compat_data {
        unsigned int fifosize;
        struct s3c2410_uartcfg *uartcfg;
};

static struct s3c2410_uartcfg s5pv310_uart_defcfg = {
        .ucon   = 0x3c5,
        .ufcon  = 0x111,
        .flags  = NO_NEED_CHECK_CLKSRC,
        .has_fracval = 1,
};

static struct s3c24xx_uart_dt_compat_data s5pv210_compat_fs256 = {
        .fifosize = 256;
        .uartcfg = &s5pv310_uart_defcfg;
};

static struct s3c24xx_uart_dt_compat_data s5pv210_compat_fs64 = {
        .fifosize = 64;
        .uartcfg = &s5pv310_uart_defcfg;
};

static struct s3c24xx_uart_dt_compat_data s5pv210_compat_fs16 = {
        .fifosize = 16;
        .uartcfg = &s5pv310_uart_defcfg;
};

static const struct of_device_id s5pv210_uart_dt_match[] = {
        { .compatible = "samsung,s5pv310-uart-fs256", .data =
&s5pv210_compat_fs256 },
        { .compatible = "samsung,s5pv310-uart-fs64", .data =
s5pv210_compat_fs64 },
        { .compatible = "samsung,s5pv310-uart-fs16", .data =
s5pv210_compat_fs16 },
        {},
};
MODULE_DEVICE_TABLE(of, s5pv210_uart_match);


This requires a new structure definition and additional data in the
driver. So I still prefer to use a property in the uart device node to
define the fifosize of the controller.

What would you be your preference? Or is there a better way to obtain
the fifosize?

Thanks,
Thomas.

>
>> ? ? ? .driver ? ? ? ? = {
>> ? ? ? ? ? ? ? .name ? = "s5pv210-uart",
>> ? ? ? ? ? ? ? .owner ?= THIS_MODULE,
>> + ? ? ? ? ? ? .of_match_table = s5pv210_uart_dt_match,
>
> I think maybe doing something like
>
> ? ? ? ? ? ? ? ?.of_match_table = of_match_ptr(5pv210_uart_dt_match),
>
> so we can avoid having the #else and #define 5pv210_uart_dt_match NULL
> in a number of places.
>
>> ? ? ? },
>> ?};
>
> --
> Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/
>
> Large Hadron Colada: A large Pina Colada that makes the universe disappear.
>
>
