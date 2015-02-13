From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 13 Feb 2015 19:35:10 +0800
Subject: Device tree /chosen/stdout-path not working as expected
In-Reply-To: <54DDDE44.30707@parkeon.com>
References: <54DDDE44.30707@parkeon.com>
Message-ID: <6FFCFFE5-319E-46FF-A4DE-7FDE8E4D115D@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	I?ve a patch to fix

	will send it next week

Best Regards,
J.
> On Feb 13, 2015, at 7:21 PM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:
> 
> Hi,
> 
> Commit a208ffd2  "of: Enable console on serial ports specified by /chosen/stdout-path" is not working as expected for me.
> All this is with 3.19 on an i.MX53 based board.
> 
> With the following DT fragment I expect the console to be enabled on the second UART but it is enabled on the first.
> 
> / {
>    aliases {
>        serial0 = &uart1;
>        serial1 = &uart2;
>        serial2 = &uart3;
>        serial3 = &uart4;
>        serial4 = &uart5;
>    };
>    chosen {
>        stdout-path = "serial1:115200";
>    };
> };
> 
> The problem appears to be that the ports are registered in address order which, on i.MX53, is uart3, uart1, uart2:
> 
> [    0.353954] 5000c000.serial: ttymxc2 at MMIO 0x5000c000 (irq = 49, base_baud = 4166666) is a IMX
> [    0.354576] 53fbc000.serial: ttymxc0 at MMIO 0x53fbc000 (irq = 47, base_baud = 4166666) is a IMX
> [    8.804354] console [ttymxc0] enabled
> [    9.071704] 53fc0000.serial: ttymxc1 at MMIO 0x53fc0000 (irq = 48, base_baud = 4166666) is a IMX
> 
> In addition to this (which was done without CONFIG_VT_CONSOLE), the behaviour with CONFIG_VT_CONSOLE is different between
> the device tree and command line cases.
> 
> When the console is set on the command line with console=ttymxc1 the framebuffer console is disactivated (because the preferred console is set very early in the boot sequence before the frambuffer console registers).
> 
> However, when the console is set from the device tree both the serial port and the framebuffer console are activated (since the serial port has not yet been set as the preferred console when the framebuffer console registers)
> 
> 
> Adding some extra logs (log patch below) shows this (without CONFIG_VT_CONSOLE)
> 
> [    0.352996] imx-uart 5000c000.serial: @MF@ probe
> [    0.353171] imx-uart 5000c000.serial: @MF@ probe setup line=2 about to add
> [    0.353188] @MF@ of_console_check dn=df45b764(serial) name=ttymxc index=2 cmd_line=0 stdout=df463288(serial)
> [    0.353197] @MF@ uart_configure_port: line=2 type=62 cons=c08ae6bc flags=1
> [    0.353208] 5000c000.serial: ttymxc2 at MMIO 0x5000c000 (irq = 49, base_baud = 4166666) is a IMX
> [    0.353218] @MF@ register console ttymxc boot=1 enabled=1 preferred=-1 selected=-1
> [    0.353224] @MF@ A preferred=-1
> [    0.353230] @MF@ imx_console_setup index=0
> [    0.353235] @MF@ no port for index 0
> [    0.353239] @MF@ B preferred=-1
> [    0.353732] imx-uart 53fbc000.serial: @MF@ probe
> [    0.353837] imx-uart 53fbc000.serial: @MF@ probe setup line=0 about to add
> [    0.353851] @MF@ of_console_check dn=df463034(serial) name=ttymxc index=0 cmd_line=0 stdout=df463288(serial)
> [    0.353859] @MF@ uart_configure_port: line=0 type=62 cons=c08ae6bc flags=1
> [    0.353869] 53fbc000.serial: ttymxc0 at MMIO 0x53fbc000 (irq = 47, base_baud = 4166666) is a IMX
> [    0.353878] @MF@ register console ttymxc boot=1 enabled=1 preferred=-1 selected=-1
> [    0.353883] @MF@ A preferred=-1
> [    0.353889] @MF@ imx_console_setup index=0
> [    0.353926] @MF@ imx_console_setup ret=0
> [    0.353931] @MF@  enabling as first reg
> [    0.353936] @MF@ B preferred=0
> [    9.430862] console [ttymxc0] enabled
> [    9.475116] imx-uart 53fc0000.serial: @MF@ probe
> [    9.530475] imx-uart 53fc0000.serial: @MF@ probe setup line=1 about to add
> [    9.612802] @MF@ of_console_check dn=df463288(serial) name=ttymxc index=1 cmd_line=0 stdout=df463288(serial)
> [    9.730537] @MF@ __add_preferred_console  ttymxc idx=1 count=0
> [    9.800348] @MF@ selected B 0
> [    9.835786] @MF@ uart_configure_port: line=1 type=62 cons=c08ae6bc flags=7
> [    9.918094] @MF@ console already enabled
> [    9.964994] 53fc0000.serial: ttymxc1 at MMIO 0x53fc0000 (irq = 48, base_baud = 4166666) is a IMX
> 
> 
> So, add_preferred_console() is being called for the correct port but too late?
> 
> 
> Note that register_console() isn't even called for the expected port (ttymxc1) because ttymxc0 has already been enabled as a console at that point.
> The console is given by struct uart_port -> cons but that is initialised by uart_add_one_port():
> int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
> {
> ...
>    uport->cons = drv->cons;
> }
> 
> 
> All the imx UARTS share the same struct uart_driver instance which means that only the first i.MX UART that registers can be the console??
> 
> So why isn't the first UART probed (ttymxc2) being registered as console?
> Because imx_console_setup() returns -ENODEV for that one:
> 
> 
> static int __init
> imx_console_setup(struct console *co, char *options)
> {
>    struct imx_port *sport;
>    int baud = 9600;
>    int bits = 8;
>    int parity = 'n';
>    int flow = 'n';
>    int retval;
> 
>    printk(KERN_INFO "@MF@ %s index=%d\n", __func__, co->index);
> 
>    /*
>     * Check whether an invalid uart number has been specified, and
>     * if so, search for the first available port that does have
>     * console support.
>     */
>    if (co->index == -1 || co->index >= ARRAY_SIZE(imx_ports))
>        co->index = 0;
>    sport = imx_ports[co->index];
>    if (sport == NULL) {
>        printk(KERN_INFO "@MF@ no port for index %d\n", co->index);
>        return -ENODEV;
>    }
> 
> 
> co->index is zero but imx_ports[] is initialised based on the line number in probe():
>    imx_ports[sport->port.line] = sport;
> 
> So port2 probes, initialises imx_ports[2] and then imx_console_setup() looks in imx_ports[0], finds nothing and exits.
> Then port0 probes, and registers..
> 
> 
> Also notice the very long (9s) delay.
> This does not occur when the console= command line parameter is used (with an identical kernel and DTB)
> The wait is occuring in console_unlock() called from register_console()
> 
> I'm not sure I really understand how this is supposed to work well enough to propose an intelligent fix patch.
> Sorry not to be more helpful.
> 
> Regards,
> 
> Martin
> 
> 
> Debug patch below (probably whitespace broken, just to understand my annotated logs above)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 36536b6..f571c2c 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -2010,6 +2010,11 @@ EXPORT_SYMBOL_GPL(of_prop_next_string);
>  */
> bool of_console_check(struct device_node *dn, char *name, int index)
> {
> +    if (dn)
> +        printk(KERN_INFO "@MF@ of_console_check dn=%p(%s) name=%s index=%d cmd_line=%d stdout=%p(%s)\n",
> +            dn, dn->name, name, index, console_set_on_cmdline,
> +            of_stdout, of_stdout ? of_stdout->name : "?");
> +
>     if (!dn || dn != of_stdout || console_set_on_cmdline)
>         return false;
>     return !add_preferred_console(name, index,
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 4c5e909..4dff86f 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1687,6 +1687,8 @@ imx_console_setup(struct console *co, char *options)
>     int flow = 'n';
>     int retval;
> 
> +    printk(KERN_INFO "@MF@ %s index=%d\n", __func__, co->index);
> +
>     /*
>      * Check whether an invalid uart number has been specified, and
>      * if so, search for the first available port that does have
> @@ -1695,8 +1697,10 @@ imx_console_setup(struct console *co, char *options)
>     if (co->index == -1 || co->index >= ARRAY_SIZE(imx_ports))
>         co->index = 0;
>     sport = imx_ports[co->index];
> -    if (sport == NULL)
> +    if (sport == NULL) {
> +        printk(KERN_INFO "@MF@ no port for index %d\n", co->index);
>         return -ENODEV;
> +    }
> 
>     /* For setting the registers, we only need to enable the ipg clock. */
>     retval = clk_prepare_enable(sport->clk_ipg);
> @@ -1723,6 +1727,7 @@ imx_console_setup(struct console *co, char *options)
>         clk_disable_unprepare(sport->clk_ipg);
> 
> error_console:
> +    printk(KERN_INFO "@MF@ %s ret=%d\n", __func__, retval);
>     return retval;
> }
> 
> @@ -1852,6 +1857,8 @@ static int serial_imx_probe(struct platform_device *pdev)
>     int ret = 0;
>     struct resource *res;
> 
> +    dev_info(&pdev->dev, "@MF@ probe\n");
> +
>     sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
>     if (!sport)
>         return -ENOMEM;
> @@ -1933,6 +1940,8 @@ static int serial_imx_probe(struct platform_device *pdev)
> 
>     platform_set_drvdata(pdev, sport);
> 
> +    dev_info(&pdev->dev, "@MF@ probe setup line=%d about to add\n", sport->port.line);
> +
>     return uart_add_one_port(&imx_reg, &sport->port);
> }
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 984605b..8ddaa8e 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2199,6 +2199,12 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>         port->ops->config_port(port, flags);
>     }
> 
> +    printk(KERN_INFO "@MF@ %s: line=%d type=%d cons=%p flags=%d\n",
> +        __func__, port->line, port->type, port->cons, port->cons ? port->cons->flags : -1);
> +    if (port->cons && port->cons->flags & CON_ENABLED)
> +        printk(KERN_INFO "@MF@ console already enabled\n");
> +
> +
>     if (port->type != PORT_UNKNOWN) {
>         unsigned long flags;
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 02d6b6d..e40b3aa 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1931,6 +1931,9 @@ static int __add_preferred_console(char *name, int idx, char *options,
>     struct console_cmdline *c;
>     int i;
> 
> +    static int count = 0;
> +    printk(KERN_INFO "@MF@ %s  %s idx=%d count=%d\n", __func__, name, idx, count++);
> +
>     /*
>      *    See if this tty is not yet registered, and
>      *    if we have a slot free.
> @@ -1938,9 +1941,11 @@ static int __add_preferred_console(char *name, int idx, char *options,
>     for (i = 0, c = console_cmdline;
>          i < MAX_CMDLINECONSOLES && c->name[0];
>          i++, c++) {
> +        printk(KERN_INFO "@MF@ try idx=%d name=%s\n", i, c->name);
>         if (strcmp(c->name, name) == 0 && c->index == idx) {
>             if (!brl_options)
>                 selected_console = i;
> +            printk(KERN_INFO "@MF@ selected A %d\n", selected_console);
>             return 0;
>         }
>     }
> @@ -1953,6 +1958,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
>     braille_set_options(c, brl_options);
> 
>     c->index = idx;
> +    printk(KERN_INFO "@MF@ selected B %d\n", selected_console);
>     return 0;
> }
> /*
> @@ -2408,6 +2414,12 @@ void register_console(struct console *newcon)
>     struct console *bcon = NULL;
>     struct console_cmdline *c;
> 
> +    printk(KERN_INFO "@MF@ register console %s boot=%d enabled=%d preferred=%d selected=%d\n",
> +        newcon->name,
> +        newcon->flags & CON_BOOT ? 0:1,
> +        newcon->flags& CON_ENABLED ? 0:1,
> +        preferred_console, selected_console);
> +
>     if (console_drivers)
>         for_each_console(bcon)
>             if (WARN(bcon == newcon,
> @@ -2439,6 +2451,7 @@ void register_console(struct console *newcon)
>     if (newcon->early_setup)
>         newcon->early_setup();
> 
> +    printk(KERN_INFO "@MF@ A preferred=%d\n", preferred_console);
>     /*
>      *    See if we want to use this console driver. If we
>      *    didn't select a console we take the first one
> @@ -2450,12 +2463,14 @@ void register_console(struct console *newcon)
>         if (newcon->setup == NULL ||
>             newcon->setup(newcon, NULL) == 0) {
>             newcon->flags |= CON_ENABLED;
> +            printk(KERN_INFO "@MF@  enabling as first reg\n");
>             if (newcon->device) {
>                 newcon->flags |= CON_CONSDEV;
>                 preferred_console = 0;
>             }
>         }
>     }
> +    printk(KERN_INFO "@MF@ B preferred=%d\n", preferred_console);
> 
>     /*
>      *    See if this console matches one we selected on
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
