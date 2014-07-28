From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 28 Jul 2014 18:28:54 +0200
Subject: [PATCH v3 4/4] can: flexcan: add vf610 support for FlexCAN
In-Reply-To: <e88108c655e2c16dc9cf6c4194547e73@agner.ch>
References: <cover.1405428166.git.stefan@agner.ch>
 <ff2ea1726b13dc2ffa3519ce9244f3633cf1420d.1405428166.git.stefan@agner.ch>
 <53C5398F.2000005@pengutronix.de> <1b8a8ca03b4a160027a79b722f697e25@agner.ch>
 <601adb6fe47279c115c1cc607365a00e@agner.ch> <53D25C9D.5080803@pengutronix.de>
 <e88108c655e2c16dc9cf6c4194547e73@agner.ch>
Message-ID: <53D67A46.3060202@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2014 06:20 PM, Stefan Agner wrote:
>>> Ping. Anything open/to do from my side?
>>
>> Please keep the printing of esr and ctrl in the interrupt handler, add a
>> #define DEBUG in the driver, but do not change anything else. Then:
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 1c31a5d..fe8b81c 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -19,6 +19,7 @@
>   *
>   */
>  
> +#define DEBUG

keep

>  #include <linux/netdevice.h>
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
> @@ -743,6 +744,9 @@ static irqreturn_t flexcan_irq(int irq, void
> *dev_id)
>  
>         reg_iflag1 = flexcan_read(&regs->iflag1);
>         reg_esr = flexcan_read(&regs->esr);
> +
> +       printk("flexcan_irq, esr=%08x\n", reg_esr);
> +       printk("flexcan_irq, ctrl=%08x\n", flexcan_read(&regs->ctrl));

keep

>         /* ACK all bus error and state change IRQ sources */
>         if (reg_esr & FLEXCAN_ESR_ALL_INT)
>                 flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT,
> &regs->esr);
> @@ -885,8 +889,8 @@ static int flexcan_chip_start(struct net_device
> *dev)
>          */
>         reg_ctrl = flexcan_read(&regs->ctrl);
>         reg_ctrl &= ~FLEXCAN_CTRL_TSYN;
> -       reg_ctrl |= FLEXCAN_CTRL_BOFF_REC | FLEXCAN_CTRL_LBUF |
> -               FLEXCAN_CTRL_ERR_STATE;
> +       reg_ctrl |= FLEXCAN_CTRL_BOFF_REC | FLEXCAN_CTRL_LBUF;// |
> +               //FLEXCAN_CTRL_ERR_STATE;
>         /*
>          * enable the "error interrupt" (FLEXCAN_CTRL_ERR_MSK),
>          * on most Flexcan cores, too. Otherwise we don't get
> 
> I'm not sure whether you really want to keep the FLEXCAN_CTRL_ERR_STATE
> commented out...

No, please remove this change and redo the test.

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/af1eab34/attachment.sig>
