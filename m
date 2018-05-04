From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 4 May 2018 12:28:56 +0200
Subject: [PATCH v2] tty/serial: atmel: use port->name as name in
 request_irq()
In-Reply-To: <20180504081447.enontsm6jod4xa6g@linutronix.de>
References: <20180426150625.q5tqcb7fzchvkb5d@linutronix.de>
 <20180426151222.6vw67lwqmu6ffgnw@linutronix.de>
 <0dbf4a4c-71d4-6456-67b9-d4d202acffb7@sorico.fr>
 <20180502191632.tgda4g5v3rhncx7c@linutronix.de>
 <4f3f6e7c-2806-1749-1523-72d5c8eb8229@sorico.fr>
 <20180503124410.n6ze2ngwv6ekjhdr@linutronix.de>
 <921729c6-7c3f-11cd-8634-044a5c52f810@sorico.fr>
 <80203f75-f38e-6214-e9b6-8512c5941647@sorico.fr>
 <20180504081447.enontsm6jod4xa6g@linutronix.de>
Message-ID: <d62a945c-f81e-d7e5-8431-a7948a0b833c@sorico.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2018 10:14, Sebastian Andrzej Siewior wrote:
> I was puzzled while looking at /proc/interrupts and random things showed
> up between reboots. This occurred more often but I realised it later. The
> "correct" output should be:
> |38:      11861  atmel-aic5   2 Level     ttyS0
> 
> but I saw sometimes
> |38:       6426  atmel-aic5   2 Level     tty1
> 
> and accounted it wrongly as correct. This is use after free and the
> former example randomly got the "old" pointer which pointed to the same
> content. With SLAB_FREELIST_RANDOM and HARDENED I even got
> |38:       7067  atmel-aic5   2 Level     E=Started User Manager for UID 0
> 
> or other nonsense.
> As it turns out the tty, pointer that is accessed in atmel_startup(), is
> freed() before atmel_shutdown(). It seems to happen quite often that the
> tty for ttyS0 is allocated and freed while ->shutdown is not invoked. I
> don't do anything special - just a systemd boot :)
> 
> Use port->name as the IRQ name for request_irq(). This exists as long as
> the driver is loaded so no use-after-free here.
> For backports before v4.12 I suggest to use `"atmel_serial"' instead
> `port->name' (that member was introduced in f7048b15900f ("tty: serial_core:
> Add name field to uart_port struct").
> 
> Cc: stable at vger.kernel.org
I think it's safer to use:
Cc: stable at vger.kernel.org # 4.14
Because the stable team may miss your comment, and even if they don't, I
think it's not their role to adapt the patch to 4.9.x (and test it !)
IMHO, the best way is to add # 4.14 and when it's applied on 4.14.x,
send a tested backport for 4.9.x

Besides that, you can add my:
Acked-by: Richard Genoud <richard.genoud@gmail.com>

Rob, do you agree with this fix ?


> Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1?v2: - Bisected and added a Fixes tag
>        - added a note for backporters to v4.9 ? v4.12 (pointed out by
> 	 Richard Genoud)
> 
>  drivers/tty/serial/atmel_serial.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index e287fe8f10fc..d3189816740e 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1757,7 +1757,6 @@ static int atmel_startup(struct uart_port *port)
>  {
>  	struct platform_device *pdev = to_platform_device(port->dev);
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> -	struct tty_struct *tty = port->state->port.tty;
>  	int retval;
>  
>  	/*
> @@ -1772,8 +1771,7 @@ static int atmel_startup(struct uart_port *port)
>  	 * Allocate the IRQ
>  	 */
>  	retval = request_irq(port->irq, atmel_interrupt,
> -			IRQF_SHARED | IRQF_COND_SUSPEND,
> -			tty ? tty->name : "atmel_serial", port);
> +			     IRQF_SHARED | IRQF_COND_SUSPEND, port->name, port);
>  	if (retval) {
>  		dev_err(port->dev, "atmel_startup - Can't get irq\n");
>  		return retval;
> 

Thanks !
