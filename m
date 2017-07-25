From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 25 Jul 2017 10:47:35 +0200
Subject: [PATCH net-next 10/18] net: mvpp2: use the GoP interrupt for
 link status changes
In-Reply-To: <CAPv3WKcHtAKPKcfdC7xE-duhwMSRgSRW9_2B33Ru3KNfczZzMA@mail.gmail.com>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-11-antoine.tenart@free-electrons.com>
 <CAPv3WKcHtAKPKcfdC7xE-duhwMSRgSRW9_2B33Ru3KNfczZzMA@mail.gmail.com>
Message-ID: <20170725084735.GC2860@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,

On Tue, Jul 25, 2017 at 12:58:20AM +0200, Marcin Wojtas wrote:
> 
> This patch requires also:
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2.c
> b/drivers/net/ethernet/marvell/mvpp2.c
> index 4694d4f..369819f 100644
> --- a/drivers/net/ethernet/marvell/mvpp2.c
> +++ b/drivers/net/ethernet/marvell/mvpp2.c
> @@ -6625,6 +6625,7 @@ static int mvpp2_stop(struct net_device *dev)
>  {
>         struct mvpp2_port *port = netdev_priv(dev);
>         struct mvpp2_port_pcpu *port_pcpu;
> +       struct mvpp2 *priv = port->priv;
>         int cpu;
> 
>         mvpp2_stop_dev(port);
> @@ -6633,6 +6634,10 @@ static int mvpp2_stop(struct net_device *dev)
>         /* Mask interrupts on all CPUs */
>         on_each_cpu(mvpp2_interrupts_mask, port, 1);
> 
> +       if (priv->hw_version == MVPP22 && !port->phy_node && port->link_irq) {
> +               free_irq(port->link_irq, port);
> +       }
> +
>         free_irq(port->irq, port);
>         for_each_present_cpu(cpu) {
>                 port_pcpu = per_cpu_ptr(port->pcpu, cpu);
> 
> Otherwise a sequence: ifconfig up/down/up results in faults.

You're right, thanks for the patch! I'll squash it in v2.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/612d2885/attachment.sig>
