From: fthain@telegraphics.com.au (Finn Thain)
Date: Thu, 15 Feb 2018 09:11:13 +1100 (AEDT)
Subject: [PATCH net v4 02/13] net/8390: Fix msg_enable patch snafu
In-Reply-To: <20180213.095820.761578588685460710.davem@davemloft.net>
References: <f697da2b2513e025688f6c48088536060575a249.1518397634.git.fthain@telegraphics.com.au>
 <20180212.103956.1262868827217051631.davem@davemloft.net>
 <alpine.LNX.2.21.1802131419540.8@nippy.intranet>
 <20180213.095820.761578588685460710.davem@davemloft.net>
Message-ID: <alpine.LNX.2.21.1802150857480.8@nippy.intranet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Feb 2018, David Miller wrote:

> > I think you have overlooked those modules which offer no way to set 
> > p->msg_enable, i.e. ax88796, axnet_cs, etherh, hydra, mac8390, 
> > mcf8390, pcnet_cs and zorro8390.
> 
> Then that's a bug, we have a very simple easy to implement interface for 
> setting this (ethtool).
> 
> And by adding the simple hook, you will make these older drivers easier 
> to debug for the few people still using them.

Have you considered that implementing the ethtool hooks in the core driver 
might allow removal of all 8390 driver 'msg_enable' module parameters and 
msglevel ethtool hooks added by c45f812f0280, excepting those in the core 
driver? But even if we did that, it seems to me that we still need this 
patch.

The missing set_msglevel ethtool hooks and the msg_enable bugs patched 
here are separate issues inasmuchas the lib8390.c module parameter called 
'msg_enable' presently controls only the version message whereas the 
ethtool hooks cannot control the version message logging at all.

I'm not against improving ethtool support. Would you please explain how 
doing so (one way or another) would alter this patch?

-- 
