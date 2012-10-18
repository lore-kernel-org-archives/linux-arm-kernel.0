From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 18 Oct 2012 11:37:16 +0300
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210180644170.15666@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210180644170.15666@utopia.booyaka.com>
Message-ID: <1350549436.2143.47.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-10-18 at 06:48 +0000, Paul Walmsley wrote:
> On Thu, 18 Oct 2012, Paul Walmsley wrote:
> 
> > Here are some basic OMAP test results for Linux v3.7-rc1.
> > Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/
> 
> A few additional observations missing from the original message.
> 
> > Failing tests: needing investigation
> > ------------------------------------
> > 
> > Boot tests:
> > 
> > * 2420n800: boot hangs during UART initialization
> >   - http://lkml.org/lkml/2012/9/11/454
> >   - Various attempts at fixes posted; etiology known; issue still unresolved
> > 
> > * CM-T3517: L3 in-band error with IPSS during boot
> >   - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
> >   - Longstanding issue; does not occur on the 3517EVM
> > 
> > * 3517EVM & CM-T3517: boot hangs with NFS root
> >   - Likely some Kconfig, board file, and PM issues with EMAC
> > 
> > * CM-T3517: boot hangs with MMC boot
> >   - Due to missing MMC setup in board file
> 
> * 4430es2panda: clockevents problems early in boot
>   - boots with dummy_timer
>   - no one-shot mode so no-HZ is likely to fail

I have a fix for this problem, however I am seeing this on omap4460
panda. The root cause seems to be that local timer init for OMAP is
using wrong interrupt number. It adds a wrong offset to the interrupt
(OMAP_INTC_START) which should be omitted. Will send a patch soon along
with a new version of core ret set.

-Tero

> 
> * 4460pandaes: boot fails early
>   - Appears to be timer-related
> 
> > PM tests:
> > 
> > * 3530es3beagle, 37xxevm, 3730beaglexm: I2C fails during resume from suspend
> >   - Causes MMC to become unusable since regulators are not reenabled
> >   - Can be worked around by reverting the I2C driver conversion to
> >     threaded IRQs:
> >     - http://marc.info/?l=linux-i2c&m=135026587102887&w=2
> >   - Appears to be due to an accounting problem; under discussion:
> >     - http://marc.info/?l=linux-arm-kernel&m=135042360725821&w=2
> > 
> > * 3530es3beagle: hangs during off-mode dynamic idle test
> >   - Unknown cause; not investigated
> > 
> > * 37xx EVM: CORE not entering dynamic off-idle
> >   - Cause unknown; dynamic retention-idle seems to work; system suspend to 
> >     off works
> > 
> > * 3730 Beagle XM: does not serial wake from off-idle suspend when console
> >   UART doesn't clock gate ("debug ignore_loglevel")
> >   - Not shown in the current test logs; cause unknown
> 
> * 4430es2panda: dummy_timer warning messages during resume
>   - Unknown cause; not investigated
> 
> 
> - Paul
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
