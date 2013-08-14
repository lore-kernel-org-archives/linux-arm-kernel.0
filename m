From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 14 Aug 2013 14:21:13 -0400 (EDT)
Subject: [PATCHv3 2/5] arm64: factor out spin-table boot method
In-Reply-To: <520BC88A.5080207@ti.com>
References: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
 <1376497228-20543-3-git-send-email-mark.rutland@arm.com>
 <520BC88A.5080207@ti.com>
Message-ID: <alpine.LFD.2.03.1308141416580.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Aug 2013, Santosh Shilimkar wrote:

> On Wednesday 14 August 2013 12:20 PM, Mark Rutland wrote:
> > The arm64 kernel has an internal holding pen, which is necessary for
> > some systems where we can't bring CPUs online individually and must hold
> > multiple CPUs in a safe area until the kernel is able to handle them.
> > The current SMP infrastructure for arm64 is closely coupled to this
> > holding pen, and alternative boot methods must launch CPUs into the pen,
> > where they sit before they are launched into the kernel proper.
> > 
> > With PSCI (and possibly other future boot methods), we can bring CPUs
> > online individually, and need not perform the secondary_holding_pen
> > dance. Instead, this patch factors the holding pen management code out
> > to the spin-table boot method code, as it is the only boot method
> > requiring the pen.
> > 
> > A new entry point for secondaries, secondary_entry is added for other
> > boot methods to use, which bypasses the holding pen and its associated
> > overhead when bringing CPUs online. The smp.pen.text section is also
> > removed, as the pen can live in head.text without problem.
> > 
> > The smp_operations structure is extended with two new functions,
> > cpu_boot and cpu_postboot, for bringing a cpu into the kernel and
> > performing any post-boot cleanup required by a bootmethod (e.g.
> > resetting the secondary_holding_pen_release to INVALID_HWID).
> > Documentation is added for smp_operations.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> 
> [..]
> > diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
> > index 5fecffc..87af6bb 100644
> > --- a/arch/arm64/kernel/smp_spin_table.c
> > +++ b/arch/arm64/kernel/smp_spin_table.c
> > @@ -16,13 +16,36 @@
> >   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> >   */
> >  
> > +#include <linux/delay.h>
> >  #include <linux/init.h>
> >  #include <linux/of.h>
> >  #include <linux/smp.h>
> >  
> >  #include <asm/cacheflush.h>
> > +#include <asm/cputype.h>
> > +#include <asm/smp_plat.h>
> > +
> > +extern void secondary_holding_pen(void);
> > +volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
> >  
> >  static phys_addr_t cpu_release_addr[NR_CPUS];
> > +static DEFINE_RAW_SPINLOCK(boot_lock);
> > +
> > +/*
> > + * Write secondary_holding_pen_release in a way that is guaranteed to be
> > + * visible to all observers, irrespective of whether they're taking part
> > + * in coherency or not.  This is necessary for the hotplug code to work
> > + * reliably.
> > + */
> > +static void write_pen_release(u64 val)
> > +{
> > +	void *start = (void *)&secondary_holding_pen_release;
> > +	unsigned long size = sizeof(secondary_holding_pen_release);
> > +
> > +	secondary_holding_pen_release = val;
> > +	__flush_dcache_area(start, size);
> > +}
> > +
> >  
> >  static int smp_spin_table_cpu_init(struct device_node *dn, unsigned int cpu)
> >  {
> > @@ -59,8 +82,60 @@ static int smp_spin_table_cpu_prepare(unsigned int cpu)
> >  	return 0;
> >  }
> >  
> > +static int smp_spin_table_cpu_boot(unsigned int cpu)
> > +{
> > +	unsigned long timeout;
> > +
> > +	/*
> > +	 * Set synchronisation state between this boot processor
> > +	 * and the secondary one
> > +	 */
> > +	raw_spin_lock(&boot_lock);
> > +
> > +	/*
> > +	 * Update the pen release flag.
> > +	 */
> > +	write_pen_release(cpu_logical_map(cpu));
> > +
> > +	/*
> > +	 * Send an event, causing the secondaries to read pen_release.
> > +	 */
> > +	sev();
> > +
> > +	timeout = jiffies + (1 * HZ);
> > +	while (time_before(jiffies, timeout)) {
> > +		if (secondary_holding_pen_release == INVALID_HWID)
> > +			break;
> > +		udelay(10);
> > +	}
> > +
> > +	/*
> > +	 * Now the secondary core is starting up let it run its
> > +	 * calibrations, then wait for it to finish
> > +	 */
> > +	raw_spin_unlock(&boot_lock);
> > +
> > +	return secondary_holding_pen_release != INVALID_HWID ? -ENOSYS : 0;
> > +}
> > +
> > +void smp_spin_table_cpu_postboot(void)
> > +{
> > +	/*
> > +	 * Let the primary processor know we're out of the pen.
> > +	 */
> > +	write_pen_release(INVALID_HWID);
> > +
> > +	/*
> > +	 * Synchronise with the boot thread.
> > +	 */
> > +	raw_spin_lock(&boot_lock);
> > +	raw_spin_unlock(&boot_lock);
> > +}
> > +
> I was just wonderring whether we can absrtact the synchronization
> further out of spin_table and psci method. At least the lock
> synchronization is common and needed in both cases.

Why?  This synchronization looks rather useless to me.


Nicolas
