From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 10 Aug 2018 10:40:55 +0800
Subject: [PATCH] net: mvneta: use the correct napi pointer
In-Reply-To: <20180809121308.GC16359@lunn.ch>
References: <20180809200242.1166f86c@xhacker.debian>
 <20180809121308.GC16359@lunn.ch>
Message-ID: <20180810104055.0f009ed0@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 9 Aug 2018 14:13:08 +0200 Andrew Lunn wrote:

> On Thu, Aug 09, 2018 at 08:02:42PM +0800, Jisheng Zhang wrote:
> > if neta_armada3700 is true, the mvneta_pcpu_port's napi is invalid, we
> > should use pp->napi instead. Fix mvneta_config_rss() with this method.
> > Although we can fix mvneta_rx_hwbm() and mvneta_rx_swbm() in the same
> > manner, the napi parm of mvneta_poll() is always correct, so we can
> > pass the correct napi param to mvneta_rx_hwbm() and mvneta_rx_swbm()
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>  
> 
> Hi Jisheng
> 
> How does this differ from

oops, I didn't monitor the net-next tree recently, glad to see it's fixed.
But the mvneta_config_rss() also need the fix. Since your patch is already
merged, so I will submit one separate patch to fix mvneta_config_rss().

Thanks a lot,
Jisheng

> 
> commit 7a86f05faf112463cfbbdfd222012e247de461a1
> Author: Andrew Lunn <andrew@lunn.ch>
> Date:   Wed Jul 18 18:10:50 2018 +0200
> 
>     net: ethernet: mvneta: Fix napi structure mixup on armada 3700
>     
>     The mvneta Ethernet driver is used on a few different Marvell SoCs.
>     Some SoCs have per cpu interrupts for Ethernet events. Some SoCs have
>     a single interrupt, independent of the CPU. The driver handles this by
>     having a per CPU napi structure when there are per CPU interrupts, and
>     a global napi structure when there is a single interrupt.
>     
>     When the napi core calls mvneta_poll(), it passes the napi
>     instance. This was not being propagated through the call chain, and
>     instead the per-cpu napi instance was passed to napi_gro_receive()
>     call. This breaks when there is a single global napi instance.
>     
>     Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>     Fixes: 2636ac3cc2b4 ("net: mvneta: Add network support for Armada 3700 SoC")
>     Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> which is already in net-next, and i hope net?
> 
>       Andrew
