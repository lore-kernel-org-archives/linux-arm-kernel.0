From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Mar 2014 15:01:18 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140321111353.GA24945@sirena.org.uk>
References: <1395252139-16239-1-git-send-email-broonie@kernel.org>
 <20140320112650.GA1408@red-moon>
 <20140320134357.GE11706@sirena.org.uk>
 <20140320171930.GA28238@arm.com>
 <20140321111353.GA24945@sirena.org.uk>
Message-ID: <20140321150118.GH13596@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 11:13:53AM +0000, Mark Brown wrote:
> On Thu, Mar 20, 2014 at 05:19:32PM +0000, Catalin Marinas wrote:
> > On Thu, Mar 20, 2014 at 01:43:57PM +0000, Mark Brown wrote:
> 
> > > Given ACPI (which really looks like it's going to happen at some point
> > > and presumably make OF optional) I'm not sure removing the handling of
> > > OF is actually constructive but whatever, it's done now...
> 
> > CONFIG_OF will always be enabled in the kernel even when we get ACPI. We
> > still use the chosen DT node to tell the kernel about ACPI.
> 
> One thing that occurs to me with this - if we've always got a DT even if
> we are booting with ACPI that might confuse code that implements
> handling for firmware idioms.

The DT presented on an ACPI-capable system only contains the chosen
node (I guess the DT will not even be unflattened) .So the topology
code would check for DT, if not it would check for ACPI (or the other
way around) and only after that fall back to hardware MPIDR. I'm not
sure whether current ACPI gives us rich enough information about
topology like DT, in which case it could simply use MPIDR.

> I was aware that there was a stub DT on ACPI systems but had expected
> that if we were booting with real ACPI support that'd get masked from
> the running system.

That's the plan. The original point was that CONFIG_OF is going to stay
even if CONFIG_ACPI is enabled. But we shouldn't mix the two, so most of
the DT information will not be available to the kernel (not even
CPU topology) if ACPI tables are provided.

-- 
Catalin
