From: yinghai@kernel.org (Yinghai Lu)
Date: Wed, 11 Jun 2014 16:44:48 -0700
Subject: [PATCH v2 3/7] tty/serial: convert 8250 to generic earlycon
In-Reply-To: <539898C3.8090903@gmail.com>
References: <1397859600-11507-1-git-send-email-robherring2@gmail.com>
 <1397859600-11507-4-git-send-email-robherring2@gmail.com>
 <CAE9FiQVrwypK4u5yTCt-AxMuBnOn7jv=V3d4Zb3cd9JDNEUVPw@mail.gmail.com>
 <CAL_JsqKux+BTHeYo6XEzzQMAFJZHVjbURM973oHT=t698GbJbA@mail.gmail.com>
 <20140503220731.GA10927@kroah.com>
 <20140503221658.GA13403@kroah.com>
 <CA+8MBb+7f1bOnJjJWj1vxa0UNuQwz7OGRDR_QFTxOT=9cynabQ@mail.gmail.com>
 <CA+8MBbKE1E2uq9LefiDAV9hv2Z8OTkjx9mkXjE6_--F_emRC8A@mail.gmail.com>
 <CAL_JsqKvoO9acX==-LdD6boO=B3xr=ijra_G0uqRZGzACZZUJg@mail.gmail.com>
 <CA+8MBbLooWm9xys+gYa5uL1eVTH-qzaR+RaZgsrqV-8XkqGadQ@mail.gmail.com>
 <539898C3.8090903@gmail.com>
Message-ID: <CAE9FiQWxghRU62OwGU6-nvxMdEakPKQY_yGWvcVa6vsQcA=-sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 10:58 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 06/10/2014 03:52 PM, Tony Luck wrote:
> I think I figured it out. The function
> serial8250_find_port_for_earlycon is failing to match 'uart' console to
> 'ttyS' console and transfer the options. It was also failing to create
> an option string when the baud rate is probed. Can you try out the
> below patch?
>
> Rob
>
> 8<-------------------------------------------------------------------
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index cfef801..4858b8a 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -144,8 +144,11 @@ static int __init early_serial8250_setup(struct earlycon_device *device,
>         if (!(device->port.membase || device->port.iobase))
>                 return 0;
>
> -       if (!device->baud)
> +       if (!device->baud) {
>                 device->baud = probe_baud(&device->port);
> +               snprintf(device->options, sizeof(device->options), "%u",
> +                        device->baud);
> +       }
>
>         init_port(device);
>
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index 5131b5e..d20e6d8 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -25,7 +25,7 @@
>  #include <asm/serial.h>
>
>  static struct console early_con = {
> -       .name =         "earlycon",
> +       .name =         "uart",
>         .flags =        CON_PRINTBUFFER | CON_BOOT,
>         .index =        -1,
>  };
>

Yes, that is right fix.

For the name in early_con with "uart", please add some comments that
serial8250_find_port_for_earlycon() will look for "uart"...

Thanks

Yinghai
