From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 13 Aug 2015 13:05:02 +0200
Subject: [RFC] sh-sci: Add CONFIG_SERIAL_EARLYCON support
In-Reply-To: <1433669307-19478-1-git-send-email-ysato@users.sourceforge.jp>
References: <1433669307-19478-1-git-send-email-ysato@users.sourceforge.jp>
Message-ID: <CAMuHMdVRjsN5TixjMnnwp4JvRPHqv2iJOGpSvrk7p4-Dd1MHUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sato-san, Arnd,

On Sun, Jun 7, 2015 at 11:28 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> "earlyprintk" is architecture specific option.
> I think general "earlycon" option support more better.

Thanks for your patch!

I finally gave it a try on shmobile. Sorry for taking that long...

Despite claims from a few months ago:

On Sun, Mar 22, 2015 at 8:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> I think a number of people have expressed that they'd rather get rid of the
> DEBUG_LL list in the long run, now that we have earlycon working. If we

earlycon doesn't seem to be ready on arm.

Without "[PATCH v5] ARM: early fixmap support for earlycon"
(https://lkml.org/lkml/2015/8/11/532), it hangs in ioremap(), as called from
earlycon_map().

> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 95772cf..6eb82e1 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c

> -#ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
> +#if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || defined(CONFIG_SERIAL_EARLYCON)
>  static void serial_console_putchar(struct uart_port *port, int ch)
>  {
>         sci_poll_put_char(port, ch);
> @@ -2359,9 +2360,12 @@ static void serial_console_write(struct console *co, const char *s,
>         int locked = 1;
>
>         local_irq_save(flags);
> +#if defined(SUPPORT_SYSRQ)
>         if (port->sysrq)
>                 locked = 0;
> -       else if (oops_in_progress)
> +       else
> +#endif
> +       if (oops_in_progress)
>                 locked = spin_trylock(&port->lock);
>         else
>                 spin_lock(&port->lock);
> @@ -2719,6 +2723,66 @@ static void __exit sci_exit(void)
>  early_platform_init_buffer("earlyprintk", &sci_driver,
>                            early_serial_buf, ARRAY_SIZE(early_serial_buf));
>  #endif
> +#ifdef CONFIG_SERIAL_EARLYCON
> +static struct __init plat_sci_port port_cfg;
> +
> +static int __init early_console_setup(struct earlycon_device *device,
> +                                     int type)
> +{
> +       if (!device->port.membase)
> +               return -ENODEV;
> +
> +       device->port.serial_in = sci_serial_in;
> +       device->port.serial_out = sci_serial_out;
> +       device->port.type = type;
> +       memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
> +       sci_ports[0].cfg = &port_cfg;
> +       sci_ports[0].cfg->type = type;
> +       sci_probe_regmap(sci_ports[0].cfg);
> +       port_cfg.scscr = SCSCR_RE | SCSCR_TE;
> +       sci_serial_out(&sci_ports[0].port, SCSCR, port_cfg.scscr);
> +
> +       device->con->write = serial_console_write;
> +       return 0;
> +}

Earlycon cannot use serial_console_write(), as it takes an
uninitialized spinlock():

BUG: spinlock bad magic on CPU#0, swapper/0
 lock: sci_ports+0x0/0x35c0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
CPU: 0 PID: 0 Comm: swapper Not tainted
4.2.0-rc6-koelsch-04464-g15cd6b1126aee571 #1525
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c00138b4>] (dump_backtrace) from [<c0013aac>] (show_stack+0x18/0x1c)
 r6:600001d3 r5:c0e6d268 r4:00000000 r3:00200000
[<c0013a94>] (show_stack) from [<c045fe3c>] (dump_stack+0x78/0x94)
[<c045fdc4>] (dump_stack) from [<c006f61c>] (spin_dump+0x80/0x94)
 r4:00000000 r3:00000000
[<c006f59c>] (spin_dump) from [<c006f65c>] (spin_bug+0x2c/0x30)
 r5:c0e6d268 r4:c057cfe7
[<c006f630>] (spin_bug) from [<c006f6e8>] (do_raw_spin_lock+0x28/0x198)
 r5:c0e6d268 r4:c0e6d268
[<c006f6c0>] (do_raw_spin_lock) from [<c0465654>] (_raw_spin_lock+0x3c/0x44)
 r9:00000000 r8:00000022 r7:00000000 r6:600001d3 r5:c0e6d268 r4:c0e6d268
[<c0465618>] (_raw_spin_lock) from [<c02636cc>]
(serial_console_write+0x58/0x134)
 r4:c0e6d268
[<c0263674>] (serial_console_write) from [<c0072aec>]
(call_console_drivers.constprop.25+0xd0/0xf4)
 r10:c0e4e2c8 r9:c0646010 r8:00000022 r7:00000000 r6:c0e4e2dc r5:c0e2d988
 r4:c066a2f0
[<c0072a1c>] (call_console_drivers.constprop.25) from [<c00747a4>]
(console_unlock+0x370/0x44c)
 r9:00000000 r8:00000022 r7:00000006 r6:200001d3 r5:c0e4d908 r4:c0e2e2a4
[<c0074434>] (console_unlock) from [<c00754a4>] (register_console+0x2ac/0x39c)
 r10:00000001 r9:00000000 r8:c06502d4 r7:c0e2d988 r6:00000000 r5:c0e2d9b8
 r4:c066a2f0
[<c00751f8>] (register_console) from [<c061f150>] (of_setup_earlycon+0x9c/0xb0)
 r9:00000080 r8:c0634039 r7:c061f240 r6:00000000 r5:c066a2f0 r4:ffeff000
[<c061f0b4>] (of_setup_earlycon) from [<c0623668>]
(setup_of_earlycon+0x100/0x124)
 r7:00004288 r6:c063f42c r5:00000000 r4:c0fec000

Fortunately it continues, so I saw the BUG()...

Most drivers seem to fix this by having an early_serial_console_write()
that only performs the core functionality of serial_console_write().

Alternatively, (sci-specific) early_console_setup() or (generic)
register_earlycon() could call

        spin_lock_init(&device->port.lock);

I tried both approaches, and then the kernel doesn't crash anymore.
Still, I don't think anything is printed by earlycon: I just see a long delay of
a few seconds, presumable until ttySC0 takes over.

Calling serial_console_write() explicitly with a test message makes the
kernel lock up. Oops...

Does FIX_EARLYCON_MEM work?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
