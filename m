From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 21 Sep 2012 18:08:59 +0000 (UTC)
Subject: rcu self-detected stall messages on OMAP3, 4 boards
In-Reply-To: <20120920232114.GO2449@linux.vnet.ibm.com>
References: <alpine.DEB.2.00.1209122237080.7275@utopia.booyaka.com>
 <20120913011208.GT4257@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209131839000.23318@utopia.booyaka.com>
 <20120920000351.GI2455@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209200753450.3801@utopia.booyaka.com>
 <F95344A7-3351-4E6B-BF61-37E591AF16A2@ti.com>
 <20120920220130.GN2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
 <20120920232114.GO2449@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cc Frederic Weisbecker - context is here: 

   http://marc.info/?l=linux-kernel&m=134749030206016&w=2

On Thu, 20 Sep 2012, Paul E. McKenney wrote:

> Fair point.  I am wondering whether there is some path into the idle
> loop that somehow avoids telling RCU that the CPU has in face entered
> idle.  There needs to be an rcu_idle_enter() call on the way to idle,
> otherwise RCU CPU stall warnings are expected behavior.

As far as I know, our only idle entry point is in 
arch/arm/common/process.c:cpu_idle().

Looking at the x86 idle entry, they call rcu_idle_{enter,exit}() inside 
{stop,start}_critical_timings().  Making that change here didn't help.

Also tried commenting out the code from the stop_critical_timings() call 
to the WARN_ON(irqs_disabled()), and adding a local_irq_enable().  That 
also didn't help, which suggests that the problem is not caused by the 
OMAP-specific PM idle code.


- Paul
