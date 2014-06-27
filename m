From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Jun 2014 17:34:11 +0100
Subject: [PATCHv3 2/5] arm64: cpuinfo: record cpu system register values
In-Reply-To: <20140627153444.GB15775@arm.com>
References: <1403795926-17139-1-git-send-email-mark.rutland@arm.com>
 <1403795926-17139-3-git-send-email-mark.rutland@arm.com>
 <20140627153444.GB15775@arm.com>
Message-ID: <20140627163411.GL7262@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 04:34:44PM +0100, Will Deacon wrote:
> Hi Mark,

Hi Will,

> On Thu, Jun 26, 2014 at 04:18:43PM +0100, Mark Rutland wrote:
> > Several kernel subsystems need to know details about CPU system register
> > values, sometimes for CPUs other than that they are executing on. Rather
> > than hard-coding system register accesses and cross-calls for these
> > cases, this patch adds logic to record various system register values at
> > boot-time. This may be used for feature reporting, firmware bug
> > detection, etc.
> > 
> > Separate hooks are added for the boot and hotplug paths to enable
> > one-time intialisation and cold/warm boot value mismatch detection in
> > later patches.
> 
> [...]
> 
> > +void cpuinfo_store_cpu(void)
> > +{
> > +	unsigned int cpu = smp_processor_id();
> > +	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
> 
> this_cpu_ptr?

Sure.

> 
> > +	__cpuinfo_store_cpu(info);
> > +}
> > +
> > +void __init cpuinfo_store_boot_cpu(void)
> > +{
> > +	unsigned int cpu = smp_processor_id();
> > +	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
> > +	__cpuinfo_store_cpu(info);
> 
> This looks familiar. Can you just call cpuinfo_store_cpu here, or even move
> that code into __cpu_info_store_cpu, which will only work if it runs on the
> CPU owning that data anyway.

I can't call cpuinfo_store_cpu() here, as in patch 5 I'll end up doing
erroneous validation of cpu0 against the (not yet initialised) boot cpu
data.

Given the use of this_cpu_ptr, I can get rid of the smp_processor_id()
calls for now, as they're only necessary when reporting to the user. For
patches 4 and 5 I've moved them to cpuinfo_detect_icache_policy() and
cpuinfo_sanity_check().

Thanks,
Mark.
