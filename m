From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 8 Jan 2017 19:46:29 -0200
Subject: imx: RS-485 problems during TX, maybe DMA related
In-Reply-To: <20170108180609.GB24155@archie.localdomain>
References: <20170106225026.GA3804@archie.localdomain>
 <CAOMZO5CywajwZEL8K2ATfS80WzqY69YVX+3S7hq9_HmNdNAwaw@mail.gmail.com>
 <20170107134557.GA12299@archie.localdomain>
 <CAOMZO5ALSQj3C6Yn-avMZdzTvtWCZPQ5+pNdzYi03G-GZB_t+w@mail.gmail.com>
 <20170107153434.GA13307@archie.localdomain>
 <CAOMZO5CY3ys6moE133LwSKcS4egv56JdmhPMRG0TmAnfD+ZBAw@mail.gmail.com>
 <20170107205930.GA12367@archie.localdomain>
 <CAOMZO5D00YFLS=pddAqPo_FUoP6MF-juAef2H71-Wx_NQArdpw@mail.gmail.com>
 <20170107230624.GA21729@archie.localdomain>
 <CAOMZO5DedNURGV_k5Y=nt1O98SojsvrOd69PEPEzi8F7N3dJuw@mail.gmail.com>
 <20170108180609.GB24155@archie.localdomain>
Message-ID: <CAOMZO5AYha+SwS4761XxOnUtT1DYhHH69UpXmQzcmEdfC++JKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 8, 2017 at 4:06 PM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:

> I just did the experiment with your configuration and the rs485conf tool
> you mentioned.
> But still, no luck :(
>
> What's the revision of the i.MX6Q on your board? Mine is 1.5 (TO 1.3)

Mine is a mx6solo rev1.1.

> Another example: If I run the following on the board..
>
> while true; do
>   echo ABCDEFGHIJKLM > /dev/ttymxc4
>   sleep 0.5
>   echo abc > /dev/ttymxc4 > /dev/ttymxc4

There is a typo here, this should be:
echo abc > /dev/ttymxc4

Fixed it locally.

>   sleep 0.5
> done
>
> Many transmits contain garbled (doubled and sometimes also extended to
> a length of 4096 bytes, containing zeros) data.
> I can see a few transmissions that are sent correctly, though.

This script runs correctly here and no issue is seen on the console.

Not sure why you get TXEN high for so long in your case.

> Interesting side note: With the following patch, the problems disappear:
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 451e50f6d77a..eb9f0ce6c34a 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1270,8 +1270,10 @@ static int imx_startup(struct uart_port *port)
>         writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
>
>         /* Can we enable the DMA support? */
> +#if 0
>         if (!uart_console(port) && !sport->dma_is_inited)
>                 imx_uart_dma_init(sport);
> +#endif

Looks like you disabled DMA.

Regards,

Fabio Estevam
