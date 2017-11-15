From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 15 Nov 2017 11:53:23 +0100
Subject: [PATCH v3 2/4] net: nb8800: Simplify nb8800_pause_config()
In-Reply-To: <yw1xk1yt0zbp.fsf@mansr.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <dd0c2014-8ef9-749c-16d3-6a56f4161658@sigmadesigns.com>
 <yw1x1sl12fx8.fsf@mansr.com>
 <569542b1-8e56-d7da-f7a0-affd89bfed62@sigmadesigns.com>
 <yw1xk1yt0zbp.fsf@mansr.com>
Message-ID: <6f534b2b-f69a-bda5-dc5b-0281bf0df129@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/2017 14:22, M?ns Rullg?rd wrote:

> Marc Gonzalez wrote:
> 
>> On 14/11/2017 13:38, M?ns Rullg?rd wrote:
>>
>>> Marc Gonzalez writes:
>>>
>>>> The "flow control enable" bit can be tweaked, even if DMA is enabled.
>>>
>>> No, it can't.  Maybe on some of your newer chips it can, but not on the
>>> older ones.
>>
>> Again, I suppose you are referring to your SMP8642-based board.
>>
>> Are you saying you tested this patch, and it doesn't work?
>> What are the symptoms?
> 
> I didn't test that patch per se.  I did initially try simply changing
> that bit, and this didn't work.  Either it had no effect, or it locked
> up the controller, I forget which.  The manual explicitly states that
> writes are forbidden while the DMA enabled bit is set.
> 
> If shutting down the DMA really isn't possible, I would rather just
> allow changing the flow control setting only when the interface is
> stopped.  The normal case of getting the initial setting from the
> auto-negotiation will still work properly.  It just won't be possible to
> change it while the link is active.

Hello Mans,

With the default setup,

	priv->pause_aneg = true;
	priv->pause_rx = true;
	priv->pause_tx = true;

even the very first call to nb8800_pause_config() occurs with netif_running=1
as well as the RX DMA bit enabled.

buildroot login: root
# ip addr add 172.27.64.23/18 brd 172.27.127.255 dev eth0
# ip link set eth0 up
[   25.771000] ENTER nb8800_pause_config: netif_running=1
[   25.776195] CPU: 0 PID: 193 Comm: kworker/0:1 Not tainted 4.9.54-1-rc6 #18
[   25.783102] Hardware name: Sigma Tango DT
[   25.787138] Workqueue: events_power_efficient phy_state_machine
[   25.793107] [<c010f290>] (unwind_backtrace) from [<c010af34>] (show_stack+0x10/0x14)
[   25.800896] [<c010af34>] (show_stack) from [<c02d06e8>] (dump_stack+0x88/0x9c)
[   25.808160] [<c02d06e8>] (dump_stack) from [<c03967e4>] (nb8800_pause_config+0x28/0xf0)
[   25.816208] [<c03967e4>] (nb8800_pause_config) from [<c03969e0>] (nb8800_link_reconfigure+0x134/0x148)
[   25.825565] [<c03969e0>] (nb8800_link_reconfigure) from [<c0391d84>] (phy_state_machine+0x348/0x468)
[   25.834750] [<c0391d84>] (phy_state_machine) from [<c012e858>] (process_one_work+0x1d8/0x3f0)
[   25.843323] [<c012e858>] (process_one_work) from [<c012f6a4>] (worker_thread+0x4c/0x560)
[   25.851459] [<c012f6a4>] (worker_thread) from [<c0134354>] (kthread+0xec/0xf4)
[   25.858721] [<c0134354>] (kthread) from [<c01078f8>] (ret_from_fork+0x14/0x3c)
[   25.874597] nb8800 26000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx


This makes sense, since nb8800_open() calls nb8800_start_rx()
before phy_start().

Moving nb8800_start_rx() to after nb8800_pause_config() does
appear to work, but I'm not sure it is the correct action?

FWIW, this is the patch I'm testing:

diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
index da6e8bdbb77a..86081632346e 100644
--- a/drivers/net/ethernet/aurora/nb8800.c
+++ b/drivers/net/ethernet/aurora/nb8800.c
@@ -667,6 +667,7 @@ static void nb8800_link_reconfigure(struct net_device *dev)
                        nb8800_mac_config(dev);
 
                nb8800_pause_config(dev);
+               nb8800_start_rx(dev);
        }
 
        if (phydev->link != priv->link) {
@@ -918,7 +919,6 @@ static int nb8800_open(struct net_device *dev)
        napi_enable(&priv->napi);
        netif_start_queue(dev);
 
-       nb8800_start_rx(dev);
        phy_start(phydev);
 
        return 0;
