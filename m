From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 3 Jul 2014 15:56:47 +0800
Subject: [PATCH 4/5] ARM: imx: clk-gate2: Use post decrement for
 share_count
In-Reply-To: <20140703074553.GA30239@dragon>
References: <1404194129-25543-1-git-send-email-festevam@gmail.com>
 <1404194129-25543-4-git-send-email-festevam@gmail.com>
 <20140701115252.GM14471@dragon>
 <CAOMZO5BmJFmjYP9=rfR5eRKWPioPoW=UjE_h=Q3kbEAJGRixAQ@mail.gmail.com>
 <20140702152942.12768.85270@quantum>
 <CAOMZO5B=Jwodc+2hVhjXrCvERxuyKKviM+zYgH=ynvOSHLWBTw@mail.gmail.com>
 <20140703074553.GA30239@dragon>
Message-ID: <20140703075646.GA1970@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 03:46:00PM +0800, Shawn Guo wrote:
> > Scenario 2:
> > 
> > clk1 is enabled -> clock gate bit is set to 1
> > clk2 is disabled -> clock gate bit cannot be set to 0 because clk1 is enabled
> 
> This never happens.  If clk2 is disabled by clk_disable() without being
> enabled by clk_enable() beforehand, it returns from __clk_disable()
> immediately due to hitting of the WARN below.
> 
> 	if (WARN_ON(clk->enable_count == 0))
> 		return;

Well, it only happens in case that clock core calls clk->ops->disable()
directly from clk_disable_unused_subtree() in order to disable unused
clocks.

Shawn
