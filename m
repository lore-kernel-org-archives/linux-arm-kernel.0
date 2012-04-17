From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Tue, 17 Apr 2012 09:15:39 +0200
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F00206987A3BFE@AUSP01VMBX24.collaborationhost.net>
References: <4F683B36.8090101@metasoft.pl>
 <20120321193836.GC3740@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48E3E@AUSP01VMBX24.collaborationhost.net>
 <20120323070446.GC5812@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48EEB@AUSP01VMBX24.collaborationhost.net>
 <20120410172853.GA25697@mwesterb-mobl>
 <ADE657CA350FB648AAC2C43247A983F00206986C01D4@AUSP01VMBX24.collaborationhost.net>
 <4F853053.7040800@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F00206987A3BFE@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4F8D189B.3010100@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-04-16 20:59, H Hartley Sweeten wrote:
> On Wednesday, April 11, 2012 12:19 AM, Rafal Prylowski wrote:
> 
> Rafal,
> 
> This patch still doesn't work on my ep93xx system.

<snip>

> It appears your patch is causing an interrupt storm on my system.
> 

Could you please apply the following patch on top of double buffering
patch? I would like to know the state of dma channel when you get
that interrupt storm.

Thanks,
RP

Index: linux-2.6/drivers/dma/ep93xx_dma.c
===================================================================
--- linux-2.6.orig/drivers/dma/ep93xx_dma.c
+++ linux-2.6/drivers/dma/ep93xx_dma.c
@@ -606,6 +606,7 @@ static int m2m_hw_interrupt(struct ep93x
 	 */
 	last = list_first_entry(edmac->active.next,
 		struct ep93xx_dma_desc, node)->txd.cookie;
+	printk("M2M: %x %s\n", status, last ? "last" : "");
 
 	/*
 	 * Use M2M DMA Buffer FSM and Control FSM to check current state of
