From: jslaby@suse.cz (Jiri Slaby)
Date: Thu, 16 Mar 2017 13:46:49 +0100
Subject: [PATCH] serial: 8250: 8250_core: Fix irq name for 8250 serial irq
In-Reply-To: <20170316122653.19930-1-vigneshr@ti.com>
References: <20170316122653.19930-1-vigneshr@ti.com>
Message-ID: <051d7223-84d4-b120-f757-abded9c738cb@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2017, 01:26 PM, Vignesh R wrote:
> Using dev_name() as irq name during request_irq() might be misleading in
> case of serial over PCI. Therefore use a better alternative name for
> identifying serial port irqs as "serial" appended with serial_index of
> the port. This ensures that "serial" string is always present in irq
> name while port index will help in distinguishing b/w different ports.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> 
> Based on top of tty-next.
> 
>  drivers/tty/serial/8250/8250_core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index f83b69f30987..78bf621d6827 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -213,12 +213,20 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
>  
>  		ret = 0;
>  	} else {
> +		char *irqname = kmalloc(20, GFP_KERNEL);
> +		if (!irqname) {
> +			spin_unlock_irq(&i->lock);

GFP_KERNEL and spin_lock won't play well together.

-- 
js
suse labs
