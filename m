From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 4 Feb 2013 15:59:48 -0500 (EST)
Subject: [PATCH v3 00/15] multi-cluster power management
In-Reply-To: <20130204142417.GE28975@mudshark.cambridge.arm.com>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <20130204142417.GE28975@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1302041510200.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Feb 2013, Will Deacon wrote:

> Hi Nicolas,
> 
> On Tue, Jan 29, 2013 at 07:50:55AM +0000, Nicolas Pitre wrote:
> > This is version 3 of the patch series required to safely power up
> > and down CPUs in a cluster as can be found in b.L systems.  Also
> > included are the needed patches to allow CPU hotplug on RTSM configured
> > for big.LITTLE.
> 
> [...]
> 
> For patches 1-6 and 8:
> 
>   Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks.

> Please keep me posted when you have a crack at removing the compile-time
> cluster/cpu limits!

The trick would entail standard memory allocation from the boot CPU, and 
the physical address for those allocations passed to the assembly code.  

Then we have this code:

	mrc     p15, 0, r0, c0, c0, 5           @ MPIDR
	ubfx    r9, r0, #0, #8                  @ r9 = cpu
	ubfx    r10, r0, #8, #8                 @ r10 = cluster
	mov     r3, #MAX_CPUS_PER_CLUSTER
	mla     r4, r3, r10, r9                 @ r4 = canonical CPU index
	cmp     r4, #(MAX_CPUS_PER_CLUSTER * MAX_NR_CLUSTERS)
	blo     2f
	... out-of-bound code here

Those constants just need to be turned into global variables as well.  
Or if we want to be really fancy, we could do some trivial instruction 
rewriting.

Still, for the foreseeable future, going with dynamic allocation isn't 
going to provide much of a gain while the compile-time limits keep the 
code simple while people get familiar with it.


Nicolas
