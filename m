From: fthain@telegraphics.com.au (Finn Thain)
Date: Fri, 16 Feb 2018 14:47:58 +1100 (AEDT)
Subject: [PATCH net v4 02/13] net/8390: Fix msg_enable patch snafu
In-Reply-To: <20180214.171558.1617880686804101923.davem@davemloft.net>
References: <alpine.LNX.2.21.1802131419540.8@nippy.intranet>
 <20180213.095820.761578588685460710.davem@davemloft.net>
 <alpine.LNX.2.21.1802150857480.8@nippy.intranet>
 <20180214.171558.1617880686804101923.davem@davemloft.net>
Message-ID: <alpine.LNX.2.21.1802161203480.8@nippy.intranet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Feb 2018, David Miller wrote:

> > Have you considered that implementing the ethtool hooks in the core 
> > driver might allow removal of all 8390 driver 'msg_enable' module 
> > parameters and msglevel ethtool hooks added by c45f812f0280, excepting 
> > those in the core driver? But even if we did that, it seems to me that 
> > we still need this patch.
> 
> No, because the module parameter lets you set the default msg level at 
> the time the driver loads, so you can control messages printed very 
> early on before it is practical to invoke ethtool and set the msg level.
> 
> This is why most drivers have this module parameter, and implement
> such a scheme.

Among the 8390 drivers, so far only ne2k-pci implements that scheme.

This patch implements that scheme for ax88796 and etherh as well, by 
making better use of the msg_enable module parameter in lib8390.c.

The axnet_cs and pcnet_cs modules lack the msglevel ethtool ops and the 
msg_enable module parameters.

The remaining nine modules lack just the ethtool ops. If you like I will 
write additional patches to implement the missing ethtool ops or module 
parameters or both (?)

This small patch already addresses the use-case in which the end-user 
needs to enable (for example) probe messages for some or all 8390 drivers.

Thoughts?

-- 
