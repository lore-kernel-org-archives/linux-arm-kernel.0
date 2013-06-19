From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 19 Jun 2013 11:19:30 -0400 (EDT)
Subject: [PATCH] ARM: EXYNOS: Fix incorrect usage of S5P_ARM_CORE1_*
 registers
In-Reply-To: <24503071.R7UT57fHdP@amdc1227>
References: <1371569191-2364-1-git-send-email-t.figa@samsung.com>
 <1933024.UCR4mQ7fzS@amdc1227>
 <CANuQgHEXHgYm1-fzLfrsk66q4T-==ka0dnSKNuBVAq1kLWOOvg@mail.gmail.com>
 <24503071.R7UT57fHdP@amdc1227>
Message-ID: <alpine.LFD.2.03.1306191110130.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Jun 2013, Tomasz Figa wrote:
> On Wednesday 19 of June 2013 20:26:50 Chander Kashyap wrote:
> > On 19 June 2013 19:58, Tomasz Figa <t.figa@samsung.com> wrote:
> > > I mean, calculate register offset based on two parameters - cluster ID
> > > and> 
> > > CPU ID, like:
> > >         ...
> > >         
> > >         u32 mpidr = cpu_logical_map(cpu);
> > >         u32 phys_cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> > >         
> > >         if (soc_is_exynosXXXX()) {
> > >         
> > >                 u32 cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> > >                 
> > >                 phys_cpu += EXYNOSXXXX_CPUS_PER_CLUSTER * cluster;
> > >         
> > >         }
> > >         
> > >         reg_base = S5P_ARM_CORE_CONFIGURATION(phys_cpu);
> > >         __raw_writel(0, reg_base);
> > 
> > This does not seems to viable solution, as eg. clusterID for
> > exynos4210 is 0x9 and exynos 4412 is 0xa.
> 
> We don't need to consider cluster ID for any SoC that has just one cluster. 
> That's why there is the if (soc_is_exynosXXXX()) clause, where exynosXXXX 
> is the SoC that we support and has more clusters.
> 
> > But if we wass the cpu nodes
> > thru DT, the we can comfortably rely on the logical cpu number. Also
> > EXYNOSXXXX_CPUS_PER_CLUSTER can vary from cluster to cluster.
> 
> There is nothing that prevents you from specifying the CPUs in DT in 
> different order. Moreover, even if you specify them in correct order, there 
> is nothing that prevents you from using any of the listed CPUs as boot CPU, 
> which will get the logical ID of 0.

Relying on the logical CPU number to index into hardware related 
register space is wrong, please don't do that.

If the MPIDR allocation isn't linear then this cannot be used either.

The best solution is probably to add this reg_base as a property of each 
CPU node in DT, and extract it at boot time to stash it into an array 
which can be indexed with the logical CPU number afterwards.


Nicolas
