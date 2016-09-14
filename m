From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Sep 2016 13:29:04 +0200
Subject: [PATCH 10/33] pcmcia: soc_common: switch to using gpio_descs
In-Reply-To: <E1beJkO-0000mg-Lu@rmk-PC.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJkO-0000mg-Lu@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkdZvNnVG5U3XQPm5KJDLci76xFP7JOO78AZ3a8QVBs0ZQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 12:24 PM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> Switch to using the gpiod_* consumer API rather than the legacy API.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
(...)

> +int soc_pcmcia_request_gpiods(struct soc_pcmcia_socket *skt)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(skt->stat); i++) {
> +               struct gpio_desc *desc;
> +

Here I inserted:

        /* Skip over unnamed GPIOs, assume unused */
        if (!skt->stat[i].name)
            continue;

to get it working again on h3600.

> +               desc = gpiod_get(skt->socket.dev.parent,
> +                                skt->stat[i].name, GPIOD_IN);
> +               if (IS_ERR(desc)) {
> +                       dev_err(skt->socket.dev.parent,
> +                               "Failed to get GPIO for %s: %ld\n",
> +                               skt->stat[i].name, PTR_ERR(desc));
> +                       __soc_pcmcia_hw_shutdown(skt, i);
> +                       return PTR_ERR(desc);
> +               }


It bugs out for me on the legacy h3600, since it only defines
two of these pins not all of the ARRAY_SIZE(skt->stat) pins
will succeed and we get an error message like this:

sa11x0-pcmcia sa11x0-pcmcia: Failed to get GPIO for (null): -2
sa11x0-pcmcia: probe of sa11x0-pcmcia failed with error -2

With the patch above it goes away and the log is silent.
The debugfs gpio file looks like this:

cat gpio
gpiochip0: GPIOs 0-27, gpio:
 gpio-0   (                    |Power Button        ) in  hi
 gpio-10  (                    |pcmcia1-detect      ) in  hi
 gpio-11  (                    |pcmcia1-ready       ) in  hi
 gpio-17  (                    |pcmcia0-detect      ) in  hi
 gpio-18  (                    |Action button       ) in  hi
 gpio-21  (                    |pcmcia0-ready       ) in  hi
 gpio-23  (                    |dcd                 ) in  hi
 gpio-25  (                    |cts                 ) in  lo
 gpio-26  (                    |rts                 ) out lo

gpiochip1: GPIOs 28-43, parent: platform/htc-egpio, htc-egpio:
 gpio-28  (                    |Flash Vpp           ) out lo
 gpio-29  (                    |PCMCIA CARD RESET   ) out lo
 gpio-30  (                    |OPT RESET           ) out lo
 gpio-32  (                    |OPT NVRAM ON        ) out lo
 gpio-33  (                    |OPT ON              ) out lo
 gpio-34  (                    |LCD power           ) out lo
 gpio-36  (                    |LCD control         ) out lo
 gpio-42  (                    |LCD 5v              ) out lo
 gpio-43  (                    |LCD 9v/-6.5v        ) out lo

Which seems like before the patch series.

I still suspect the PCMCIA is not really working but I have
limited experience of the bus so I don't really know how
to test it deeply or have my PCMCIA ethernet or harddrive
probe properly.

There are no regressions however, so with something like
the above patch applied:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

For the whole patch series on H3600.

Yours,
Linus Walleij
