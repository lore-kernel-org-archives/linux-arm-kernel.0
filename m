From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Mar 2016 17:18:48 +0000
Subject: ARM64: CPU Hotplug: can't enable more cpus than maxcpus value
 (kernel 4.5)
In-Reply-To: <20160303151200.GE19139@leverpostej>
References: <20160303141752.GA12255@localhost.localdomain>
 <20160303144215.GC19139@leverpostej> <56D85151.9050607@arm.com>
 <20160303151200.GE19139@leverpostej>
Message-ID: <20160307171848.GA6192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 03:12:01PM +0000, Mark Rutland wrote:
> On Thu, Mar 03, 2016 at 02:59:29PM +0000, Suzuki K. Poulose wrote:
> > On 03/03/16 14:42, Mark Rutland wrote:
> > 
> > >>However for arm64 it is implemented that cpu_present_mask is
> > >>explicetely set accordingly to 'maxcpus' value. Is it design intent ?
> > >
> > >To some extent, yes.
> > >
> > >Due to the possibility of a heterogeneous system, we must bring all CPUs
> > >online at boot time, and cannot defer this.
> > >
> > >This is necessary to detect the common subset of supported features, and
> > >also to detect the full set of CPUs in the system to correctly apply
> > >errata workarounds which require kernel text patching.
> > 
> > We don't have this limitation anymore, as we can check if the booting CPU
> > has any conflicting/missing features w.r.t the established set and fail the
> > booting if it does.
> 
> While we do this, that's more of a last-ditch effort as opposed to a
> general solution, and I'm not sure it's complete.
> 
> What happens when we online a CPU that we determine needs a new erratum
> workaround applied? I didn't think we prohibited onlining in that case.
> 
> I guess maxcpus is effectively the same as physical CPU hotplug, and the
> same caveats apply to both -- we can't reliably support either in the
> general case.

While I agree that there are still issues to address, I would rather
like to have such feature in the kernel. It makes sense for some systems
with lots of (homogeneous) CPUs and we shouldn't penalise them just
because there are some big.LITTLE configurations out there.

My proposal is to block late hotplug of any CPU that the kernel was not
aware of during boot (e.g. a new MIDR). We could even simplify it and
check late CPUs against the MIDR of CPU0, I really don't care about
heterogeneous CPU systems wanting to do late hotplug (at least until
someone comes with a real use-case).

-- 
Catalin
