From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 9 Aug 2014 09:41:24 -0300
Subject: OMAP baseline test results for v3.16-rc4
In-Reply-To: <alpine.DEB.2.02.1408072210300.5770@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com>
 <alpine.DEB.2.02.1407291256270.13035@utopia.booyaka.com>
 <20140729145312.GT29045@atomide.com>
 <alpine.DEB.2.02.1407291922370.13035@utopia.booyaka.com>
 <20140730053940.GX29045@atomide.com>
 <alpine.DEB.2.02.1407300725290.4477@utopia.booyaka.com>
 <20140731131107.GB29045@atomide.com>
 <alpine.DEB.2.02.1407311922350.1845@utopia.booyaka.com>
 <20140801071056.GD29045@atomide.com>
 <alpine.DEB.2.02.1408072210300.5770@utopia.booyaka.com>
Message-ID: <20140809124124.GA1201@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07 Aug 10:21 PM, Paul Walmsley wrote:
> On Fri, 1 Aug 2014, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [140731 12:29]:
> > > On Thu, 31 Jul 2014, Tony Lindgren wrote:
> > > 
> > > > * Paul Walmsley <paul@pwsan.com> [140730 00:55]:
> > > > > On Tue, 29 Jul 2014, Tony Lindgren wrote:
> > > > > 
> > > > > > The following patch should fix the tests above for 3530es3beagle.
> > > > > > Care to test and ack as I don't have one?
> > > > > 
> > > > > 3530es3beagle retention dynamic idle tests hang on next-20140729.  (Maybe 
> > > > > other boards fail too - haven't tested any others).  
> > > > 
> > > > I just checked that today's linux next works for off-idle and
> > > > wake-up events for at least 37xx evm.
> > > 
> > > I ran the full set of tests across all boards.  The only board that passed 
> > > the dynamic idle testing on next-20140729 was the 3730beaglexm.
> > > 
> > > http://www.pwsan.com/omap/testlogs/next_20140729/20140730124836/README.txt
> > > 
> > > 37xxevm hangs on the first suspend entry:
> > > 
> > > http://www.pwsan.com/omap/testlogs/next_20140729/20140730124836/pm/37xxevm/37xxevm_log.txt
> > > 
> > > If I find some extra time, I'll set up a bisection run.
> > 
> > OK that sounds like some driver suspend regression that needs
> > to be tracked down. I'm seeing it on my 37xx evm also with
> > linux next too.
> 
> It's commit a71e3c37960ce5f9c6a519bc1215e3ba9fa83e75:
> 
> Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date:   Wed Jul 23 16:47:31 2014 -0300
> 
>     net: phy: Set the driver when registering an MDIO bus device
>     
>     mdiobus_register() registers a device which is already bound to a driver.
>     Hence, the driver pointer should be set properly in order to track down
>     the driver associated to the MDIO bus.
>     
>     This will be used to allow ethernet driver to pin down a MDIO bus driver,
>     preventing it from being unloaded while the PHY device is running.
>     
>     Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>     Tested-by: Florian Fainelli <f.fainelli@gmail.com>
>     Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> 
> What's bad is that this went in late during v3.16-rc fixes.  So now v3.16 
> itself is broken, and there's no way to fix it.
> 
> As far as I can tell, this patch doesn't fix a regression.  So no way it 
> should have gone in during late -rc kernels.
> 

Indeed, the commit shouldn't have landed as a v3.16-rc fix. FWIW, it was
originally intended for v3.17, but I wasn't clear enough about this when it
was submitted.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
