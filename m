From: carlo.caione@gmail.com (Carlo Caione)
Date: Wed, 29 Jan 2014 14:21:37 +0100
Subject: [PATCH v3 1/3] ARM: sun7i/sun6i: irqchip: Add irqchip driver for
 NMI controller
In-Reply-To: <20140129125818.GO3867@lukather>
References: <1389453548-10665-1-git-send-email-carlo.caione@gmail.com>
 <1389453548-10665-2-git-send-email-carlo.caione@gmail.com>
 <20140116123940.GE31779@lukather>
 <CAOQ7t2ay6UM-YAUSypRzC=_oSY=0L5RhD6FziG96j4aoK6RHsQ@mail.gmail.com>
 <20140128104044.GC3867@lukather> <52E78E3F.6080902@redhat.com>
 <20140128164142.GL3867@lukather>
 <CAOQ7t2YLv8dNF6i-X6Y1BgvvcBCNt6JhmpGuo23E057xez6+Tg@mail.gmail.com>
 <20140129125818.GO3867@lukather>
Message-ID: <CAOQ7t2Y-tnFf8AXQpmqsM+z3htFO4E91jybpSVrgqmC4LnOEAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 1:58 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

>
> So, to sum things up, what you see is something like:
>
>         handle_level_irq
>                |              device    device
>                | mask ack     handler irq acked unmask
>                |  |    |         |         |       |
>                v  v    v         v         v       v
>
> NMI -> GIC:
>                +--------+     +---------------------
> ---------------+        +-----+
>
> PMIC -> NMI:
>             +-------------------------+
> ------------+                         +-------------
>
> And you get a "rogue" retrigger because the NMI -> GIC level went up
> again.

I'd say something like:

         handle_level_irq
                |              device    device
                | mask ack     handler irq acked unmask
                |  |    |         |         |       |
                v  v    v         v         v       v

 NMI -> GIC:
                +-----------------------------+
 ---------------+                             +------

 PMIC -> NMI:
             +-------------------------+
 ------------+                         +-------------


> I'm not exactly sure on how to fix this. Maybe by adding a call to the
> irqchip's ack just before the unmask in irq_finalize_oneshot?

That is exactly what the unmask callback in the NMI controller driver does.
The unmask_irq() in irq_finalize_oneshot() calls the unmask callback
in the driver (sunxi_sc_nmi_ack_and_unmask()) that ACKs the line
before unmasking it again.

Best,

-- 
Carlo Caione
