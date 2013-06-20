From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Jun 2013 12:16:55 +0200
Subject: [PATCH] ARM: EXYNOS: Fix incorrect usage of S5P_ARM_CORE1_*
 registers
In-Reply-To: <alpine.LFD.2.03.1306191110130.18597@syhkavp.arg>
References: <1371569191-2364-1-git-send-email-t.figa@samsung.com>
 <24503071.R7UT57fHdP@amdc1227>
 <alpine.LFD.2.03.1306191110130.18597@syhkavp.arg>
Message-ID: <1550511.tLVEbtuIcN@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 of June 2013 11:19:30 Nicolas Pitre wrote:
> On Wed, 19 Jun 2013, Tomasz Figa wrote:
> > On Wednesday 19 of June 2013 20:26:50 Chander Kashyap wrote:
> > > On 19 June 2013 19:58, Tomasz Figa <t.figa@samsung.com> wrote:
> > > > I mean, calculate register offset based on two parameters - cluster
> > > > ID
> > > > and>
> > > > 
> > > > CPU ID, like:
> > > >         ...
> > > >         
> > > >         u32 mpidr = cpu_logical_map(cpu);
> > > >         u32 phys_cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> > > >         
> > > >         if (soc_is_exynosXXXX()) {
> > > >         
> > > >                 u32 cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> > > >                 
> > > >                 phys_cpu += EXYNOSXXXX_CPUS_PER_CLUSTER * cluster;
> > > >         
> > > >         }
> > > >         
> > > >         reg_base = S5P_ARM_CORE_CONFIGURATION(phys_cpu);
> > > >         __raw_writel(0, reg_base);
> > > 
> > > This does not seems to viable solution, as eg. clusterID for
> > > exynos4210 is 0x9 and exynos 4412 is 0xa.
> > 
> > We don't need to consider cluster ID for any SoC that has just one
> > cluster. That's why there is the if (soc_is_exynosXXXX()) clause,
> > where exynosXXXX is the SoC that we support and has more clusters.
> > 
> > > But if we wass the cpu nodes
> > > thru DT, the we can comfortably rely on the logical cpu number. Also
> > > EXYNOSXXXX_CPUS_PER_CLUSTER can vary from cluster to cluster.
> > 
> > There is nothing that prevents you from specifying the CPUs in DT in
> > different order. Moreover, even if you specify them in correct order,
> > there is nothing that prevents you from using any of the listed CPUs
> > as boot CPU, which will get the logical ID of 0.
> 
> Relying on the logical CPU number to index into hardware related
> register space is wrong, please don't do that.
> 
> If the MPIDR allocation isn't linear then this cannot be used either.
> 
> The best solution is probably to add this reg_base as a property of each
> CPU node in DT, and extract it at boot time to stash it into an array
> which can be indexed with the logical CPU number afterwards.

Currently we don't specify the cpu node in DT at all for Exynos 4210, 4212 
and 4412. It's sure that their device tree sources need to be modified to 
correct his, but since DT is considered an ABI, we should keep 
compatibility with old device tree blobs. 

This means that we can't strictly require this property to be present in 
device tree, because it will break existing boards with older device trees. 
So my suggestion is to user cluster ID and CPU ID to calculate the offset by 
default and add possibility to override it with a property in device tree 
if such need shows up.

What do you think?

Best regards,
Tomasz

> Nicolas
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
