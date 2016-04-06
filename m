From: fugang.duan@nxp.com (Fugang Duan)
Date: Wed, 6 Apr 2016 10:06:25 +0000
Subject: [PATCH net-next V3 05/16] net: fec: reduce interrupts
In-Reply-To: <1459909562-22865-6-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
 <1459909562-22865-6-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <VI1PR0401MB1855EF7033B5E1FA147A6C2FFF9F0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Troy Kisky <troy.kisky@boundarydevices.com> Sent: Wednesday, April 06, 2016 10:26 AM
> To: netdev at vger.kernel.org; davem at davemloft.net; Fugang Duan
> <fugang.duan@nxp.com>; lznuaa at gmail.com
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; l.stach at pengutronix.de;
> andrew at lunn.ch; tremyfr at gmail.com; gerg at uclinux.org; linux-arm-
> kernel at lists.infradead.org; johannes at sipsolutions.net;
> stillcompiling at gmail.com; sergei.shtylyov at cogentembedded.com;
> arnd at arndb.de; Troy Kisky <troy.kisky@boundarydevices.com>
> Subject: [PATCH net-next V3 05/16] net: fec: reduce interrupts
> 
> By clearing the NAPI interrupts in the NAPI routine and not in the interrupt
> handler, we can reduce the number of interrupts. We also don't need any status
> variables as the registers are still valid.
> 
> Also, notice that if budget pkts are received, the next call to fec_enet_rx_napi
> will now continue to receive the previously pending packets.
> 
> To test that this actually reduces interrupts, try this command before/after patch
> 
> cat /proc/interrupts |grep ether; \
> ping -s2800 192.168.0.201 -f -c1000 ; \
> cat /proc/interrupts |grep ether
> 
> For me, before this patch is 2996 interrupts.
> After patch is 2010 interrupts.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>

As my previous comments on V2, if you want to improve performance, you can try to separate tx and rx napi process like calling netif_tx_napi_add() to initialize tx NAPI context.
