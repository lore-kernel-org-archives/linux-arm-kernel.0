From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 3 Mar 2016 15:12:01 +0000
Subject: ARM64: CPU Hotplug: can't enable more cpus than maxcpus value
 (kernel 4.5)
In-Reply-To: <56D85151.9050607@arm.com>
References: <20160303141752.GA12255@localhost.localdomain>
 <20160303144215.GC19139@leverpostej> <56D85151.9050607@arm.com>
Message-ID: <20160303151200.GE19139@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 02:59:29PM +0000, Suzuki K. Poulose wrote:
> On 03/03/16 14:42, Mark Rutland wrote:
> 
> >>However for arm64 it is implemented that cpu_present_mask is
> >>explicetely set accordingly to 'maxcpus' value. Is it design intent ?
> >
> >To some extent, yes.
> >
> >Due to the possibility of a heterogeneous system, we must bring all CPUs
> >online at boot time, and cannot defer this.
> >
> >This is necessary to detect the common subset of supported features, and
> >also to detect the full set of CPUs in the system to correctly apply
> >errata workarounds which require kernel text patching.
> 
> We don't have this limitation anymore, as we can check if the booting CPU
> has any conflicting/missing features w.r.t the established set and fail the
> booting if it does.

While we do this, that's more of a last-ditch effort as opposed to a
general solution, and I'm not sure it's complete.

What happens when we online a CPU that we determine needs a new erratum
workaround applied? I didn't think we prohibited onlining in that case.

I guess maxcpus is effectively the same as physical CPU hotplug, and the
same caveats apply to both -- we can't reliably support either in the
general case.

Thanks,
Mark.
