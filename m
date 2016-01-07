From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 7 Jan 2016 11:20:45 -0600
Subject: [PATCH] ARM64: tegra: Add support for Google Pixel C
In-Reply-To: <568E9804.5020503@nvidia.com>
References: <1452073222-2956-1-git-send-email-jonathanh@nvidia.com>
 <568D0D70.4020309@nvidia.com> <568E65F0.2070201@nvidia.com>
 <4442990.rM1mk43t6M@wuerfel> <568E9804.5020503@nvidia.com>
Message-ID: <CAL_Jsq++DkgJA--40YBqGZd5BJFkzXfKt_st1kN+ZiVY7yb8OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2016 at 10:53 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 07/01/16 14:11, Arnd Bergmann wrote:
>> On Thursday 07 January 2016 13:19:44 Jon Hunter wrote:

[...]

> Ok so something like this ...
>
> diff --git a/drivers/tty/serial/8250/8250_early.c
> b/drivers/tty/serial/8250/8250_early.c
> index af62131af21e..4ce6e2b57534 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -141,7 +141,18 @@ int __init early_serial8250_setup(struct
> earlycon_device *device,
>         device->con->write = early_serial8250_write;
>         return 0;
>  }
> +
> +int __init early_serial8250_mem32_setup(struct earlycon_device *device,
> +                                       const char *options)
> +{
> +       device->port.iotype = UPIO_MEM32;
> +       device->port.regshift = 2;
> +
> +       return early_serial8250_setup(device, options);
> +}
>  EARLYCON_DECLARE(uart8250, early_serial8250_setup);
>  EARLYCON_DECLARE(uart, early_serial8250_setup);
>  OF_EARLYCON_DECLARE(ns16550, "ns16550", early_serial8250_setup);
>  OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
> +OF_EARLYCON_DECLARE(tegra20_uart, "nvidia,tegra20-uart",
> +                   early_serial8250_mem32_setup);
>
>> Would it be possible to handle the "reg-io-width" parsing in
>> early_serial8250_setup instead of keying it off the string?
>
> Good point. I spent a bit of time looking at this, but I cannot see an
> easy way to do this unless we check for "reg-io-width" and "reg-shift"
> in early_init_dt_scan_chosen_serial() and pass to of_setup_earlycon(),
> however, I am guessing that this would not be ideal as this would happen
> for non-8250 devices. May be that would be ok, but I am not sure.

There's been one attempt[1] already. It had a few issues easily
solved, but I haven't seen a follow-up.

Rob

[1] https://lkml.org/lkml/2015/11/30/513
