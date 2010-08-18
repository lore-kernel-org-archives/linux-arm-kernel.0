From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 18 Aug 2010 22:44:34 +0200
Subject: [PATCH net-next-2.6] atm: remove a net_device_stats clear
In-Reply-To: <20100818.131043.226780154.davem@davemloft.net>
References: <1282061719-19645-1-git-send-email-tklauser@distanz.ch>
	<1282115064-3701-1-git-send-email-tklauser@distanz.ch>
	<20100818083304.2ef2eea4@nehalam>
	<20100818.131043.226780154.davem@davemloft.net>
Message-ID: <1282164274.2328.2.camel@edumazet-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 18 ao?t 2010 ? 13:10 -0700, David Miller a ?crit :
> From: Stephen Hemminger <shemminger@vyatta.com>
> Date: Wed, 18 Aug 2010 08:33:04 -0700
> 
> > On Wed, 18 Aug 2010 09:04:24 +0200
> > Tobias Klauser <tklauser@distanz.ch> wrote:
> > 
> >>  
> >> -	memset (&priv(dev)->stats, 0, sizeof (struct net_device_stats));
> >> +	memset(&dev->stats, 0, sizeof(struct net_device_stats));
> > 
> > This is incorrect, just remove the memset.  The stats are initialized
> > when device is created.  The Linux device driver convention is to
> > keep stats when device is set down and brought back up; that is what
> > the majority of other drivers do.
> 
> Yep, both the ether1 and ether3 patch have this problem.  Looks
> like we'll see v4 coming some :-)

To be fair, we accepted some bits like that in the past ;)

[PATCH net-next-2.6] atm: remove a net_device_stats clear

No need to clear device stats in lec_open()

Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
---
net/atm/lec.c |    1 -
1 file changed, 1 deletion(-)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index d98bde1..181d70c 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -220,7 +220,6 @@ static unsigned char *get_tr_dst(unsigned char *packet, unsigned char *rdesc)
 static int lec_open(struct net_device *dev)
 {
 	netif_start_queue(dev);
-	memset(&dev->stats, 0, sizeof(struct net_device_stats));
 
 	return 0;
 }
