From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 25 Jul 2013 12:06:51 -0400 (EDT)
Subject: [PATCH 01/13] ARM: suspend: use hash of cpu_logical_map value
 to index into save array
In-Reply-To: <20130725105528.GA2546@localhost.localdomain>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
 <1374550289-25305-2-git-send-email-nicolas.pitre@linaro.org>
 <20130724164717.GA4610@localhost.localdomain>
 <alpine.LFD.2.03.1307241437460.15022@syhkavp.arg>
 <20130725105528.GA2546@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1307251203550.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Jul 2013, Dave Martin wrote:

> On Wed, Jul 24, 2013 at 02:55:00PM -0400, Nicolas Pitre wrote:
> > On Wed, 24 Jul 2013, Dave Martin wrote:
> > 
> > > But this patch commits us to requiring that on the suspend path 
> > > specifically -- I think that ought to be mentioned somewhere. A 
> > > comment in the preamble for __cpu_suspend would be enough, I think.
> > 
> > What comment would you suggest?  I want to make sure the possible 
> > confusion you see is properly addressed.
> 
> I think we just need to state that the value of
> cpu_logical_map(smp_processor_id()) must be the MPIDR of the physical
> CPU the suspending logical CPU will resume on.  Consequently, if doing a
> migration, cpu_logical_map() must be updated appropriately somewhere
> between cpu_pm_enter() and cpu_suspend().

Excellent.  I've amended the patch with this:

diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 2835d35234..caf938db62 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -17,6 +17,11 @@ extern void cpu_resume_mmu(void);
 /*
  * Hide the first two arguments to __cpu_suspend - these are an implementation
  * detail which platform code shouldn't have to know about.
+ *
+ * On SMP systems, the value of cpu_logical_map(smp_processor_id()) must be
+ * the MPIDR of the physical CPU the suspending logical CPU will resume on.
+ * Consequently, if doing a physical CPU migration, cpu_logical_map() must be
+ * updated appropriately somewhere between cpu_pm_enter() and cpu_suspend().
  */
 int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 {

I've put it against cpu_suspend() rather than __cpu_suspend(() as this 
is what users should care about.

ACK?


Nicolas
