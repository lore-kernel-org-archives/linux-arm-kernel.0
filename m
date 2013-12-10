From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Dec 2013 18:52:05 +0100
Subject: [PATCH] net: allwinner: emac: Add missing free_irq
In-Reply-To: <52A35361.8090608@cogentembedded.com>
References: <1386415902-32697-1-git-send-email-maxime.ripard@free-electrons.com>
 <52A35361.8090608@cogentembedded.com>
Message-ID: <20131210175205.GA3651@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 07, 2013 at 08:57:05PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 07-12-2013 15:31, Maxime Ripard wrote:
> 
> >The sun4i-emac driver uses devm_request_irq at .ndo_open time, but relies on
> >the managed device mechanism to actually free it. This causes an issue whenever
> >someone wants to restart the interface, the interrupt still being held, and not
> >yet released.
> 
> >Fall back to using the regular request_irq at .ndo_open time, and introduce a
> >free_irq during .ndo_stop.
> 
> >Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >---
> >Hi David,
> 
> >It would be great if this patch would be applied to 3.13.
> 
> >Thanks,
> >Maxime
> 
> 
> >  drivers/net/ethernet/allwinner/sun4i-emac.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> >diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
> >index 50b853a..38aba50 100644
> >--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
> >+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
> >@@ -717,8 +717,8 @@ static int emac_open(struct net_device *dev)
> >  	if (netif_msg_ifup(db))
> >  		dev_dbg(db->dev, "enabling %s\n", dev->name);
> >
> >-	if (devm_request_irq(db->dev, dev->irq, &emac_interrupt,
> >-			     0, dev->name, dev))
> >+	if (request_irq(dev->irq, &emac_interrupt,
> >+			0, dev->name, dev))
> 
>    Doesn't it fit into single line?

Hmmm, yes, probably.

I'll send a v2.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/5f75e001/attachment-0001.sig>
