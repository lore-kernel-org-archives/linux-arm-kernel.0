From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 21 Apr 2016 17:28:52 +0100
Subject: [PATCH v7 17/16] arm64: hibernate: Refuse to hibernate if the
 boot cpu is offline
In-Reply-To: <20160421123335.GK6879@leverpostej>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1460565110-26341-1-git-send-email-james.morse@arm.com>
 <20160421114415.GJ6879@leverpostej>
 <20160421123335.GK6879@leverpostej>
Message-ID: <20160421162852.GB14030@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 01:33:35PM +0100, Mark Rutland wrote:
> On Thu, Apr 21, 2016 at 12:44:16PM +0100, Mark Rutland wrote:
> > On Wed, Apr 13, 2016 at 05:31:50PM +0100, James Morse wrote:
> > > It is important to hibernate/resume on the same CPU, otherwise we may
> > > change the cpu order or restore a big cpu's register state on a little
> > > cpu.
> > > 
> > > We know cpu 0 is the cpu the firmware booted us on last time, 
> > 
> > This assumes that we only kexec from CPU0 also, which we will have to
> > enforce. For example, disable_nonboot_cpus() does not enforce this if
> > CPU0 has been hotplugged out.
> > 
> > Otherwise, this kernel's CPU0 is not necessarily the CPU the FW booted
> > a kernel on.
> 
> A better approach might be:
> 
> * When going down for hibernate, store the physical CPU ID (e.g.
>   MPIDR_EL1.Aff*) in the header for the hibernate image.
> 
> * When restoring a hibernate image, first switch over to the CPU
>   described in the header (rather than assuming CPU0). 
> 
> I think this is a matter of adding a new disable_non_hibernate_cpus()
> function (defaulting to disable_nonboot_cpus()), and overriding that in
> the arch code. Then that can be called in resume_target_kernel.

Yes, it looks feasible at least by code inspection, given that it
requires changes in core code I wonder whether it is a restriction
that we can remove later or we want it in from the beginning (given
that the issue with kexec you mention above is not present in the
current kernel, hopefully not for long :)).

> Though there are likely caveats I've missed.

Same here, it *should* just be a matter of rescheduling on the
cpu whose MPIDR corresponds to the cpu that created the snapshot
image instead of the first cpu online, that can be done as you
said with a generalized disable_nonboot_cpus() that looks up
the MPIDR and get the corresponding cpu index, in the *current*
logical map that I expect to be identical to the one in the
hibernated kernel (actually I am not even sure that's a requirement).

Thanks,
Lorenzo
