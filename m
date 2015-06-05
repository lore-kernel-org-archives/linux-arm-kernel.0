From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 05 Jun 2015 19:03:42 +0100
Subject: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
In-Reply-To: <1433513267-24163-1-git-send-email-Dave.Martin@arm.com>
References: <1433513267-24163-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <5571E47E.5020800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/15 15:07, Dave P Martin wrote:
> pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
> sufficient to inhibit pl011_int() from being triggered by a local
> IRQ and trying to re-take the same lock.  This can lead to
> deadlocks.
>
> This patch uses the _irq() locking variants instead to ensure that
> pl011_int() handling for a given port is deferred until any
> pl011_tx_softirq() work for that port is complete.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>
> Another candidate for v4.1 if possible (sorry!) -- I thought this change
> was already in, but it went astray when I was refactoring.
>
> This patch conflicts with tty-next like the previous patch, since it
> fixes code that is removed by tty-next.  The correct resolution for
> the resulting merge conflict is to keep the code from tty-next.
>
>
> I am not 100% certain yet whether some rare deadlocks that Robin is
> seeing are caused by this issue, or whether this patch fixes them --
> he's testing atm.

FWIW, I've been running Juno in a startup/shutdown loop with a very 
noisy systemd all afternoon and haven't hit a problem yet with this 
patch applied. Testing without this patch yesterday I saw 3 or 4 lockdep 
splats in about the same amount of time. I'll leave it going over the 
weekend just to make sure, though.

Robin.

>
> The patch is straightforward and using non _irq() locking in a workitem
> that expects the lock to protect against interrupt handlers on the same
> CPU is clearly wrong.
>
>
> Cheers
> ---Dave
>
>
>   drivers/tty/serial/amba-pl011.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 763eb20..0cc622a 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1360,9 +1360,9 @@ static void pl011_tx_softirq(struct work_struct *work)
>   	struct uart_amba_port *uap =
>   		container_of(dwork, struct uart_amba_port, tx_softirq_work);
>
> -	spin_lock(&uap->port.lock);
> +	spin_lock_irq(&uap->port.lock);
>   	while (pl011_tx_chars(uap)) ;
> -	spin_unlock(&uap->port.lock);
> +	spin_unlock_irq(&uap->port.lock);
>   }
>
>   static void pl011_tx_irq_seen(struct uart_amba_port *uap)
>
