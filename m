From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 21 Apr 2016 13:33:35 +0100
Subject: [PATCH v7 17/16] arm64: hibernate: Refuse to hibernate if the
 boot cpu is offline
In-Reply-To: <20160421114415.GJ6879@leverpostej>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1460565110-26341-1-git-send-email-james.morse@arm.com>
 <20160421114415.GJ6879@leverpostej>
Message-ID: <20160421123335.GK6879@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 12:44:16PM +0100, Mark Rutland wrote:
> On Wed, Apr 13, 2016 at 05:31:50PM +0100, James Morse wrote:
> > It is important to hibernate/resume on the same CPU, otherwise we may
> > change the cpu order or restore a big cpu's register state on a little
> > cpu.
> > 
> > We know cpu 0 is the cpu the firmware booted us on last time, 
> 
> This assumes that we only kexec from CPU0 also, which we will have to
> enforce. For example, disable_nonboot_cpus() does not enforce this if
> CPU0 has been hotplugged out.
> 
> Otherwise, this kernel's CPU0 is not necessarily the CPU the FW booted
> a kernel on.

A better approach might be:

* When going down for hibernate, store the physical CPU ID (e.g.
  MPIDR_EL1.Aff*) in the header for the hibernate image.

* When restoring a hibernate image, first switch over to the CPU
  described in the header (rather than assuming CPU0). 

I think this is a matter of adding a new disable_non_hibernate_cpus()
function (defaulting to disable_nonboot_cpus()), and overriding that in
the arch code. Then that can be called in resume_target_kernel.

Though there are likely caveats I've missed.

Thanks,
Mark.
