From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 18 Dec 2013 17:39:42 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20131217195519.GD28455@sirena.org.uk>
References: <1387212565-12668-1-git-send-email-broonie@kernel.org>
 <20131217170625.GB9831@e102568-lin.cambridge.arm.com>
 <20131217195519.GD28455@sirena.org.uk>
Message-ID: <20131218173941.GA17594@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 07:55:19PM +0000, Mark Brown wrote:
> On Tue, Dec 17, 2013 at 05:06:25PM +0000, Lorenzo Pieralisi wrote:
> > On Mon, Dec 16, 2013 at 04:49:22PM +0000, Mark Brown wrote:
> 
> > > +void store_cpu_topology(unsigned int cpuid);
> 
> > I still think this function is not needed at all and therefore should
> > not be exported.
> 
> > > +static void __cpuinit smp_store_cpu_info(unsigned int cpuid)
> > > +{
> > > +	store_cpu_topology(cpuid);
> 
> > As I mentioned this need not be done here. Parse the topology from DT,
> > (cpu_logical_map or cpu-map) in one go and get rid of store_cpu_topology().
> 
> That's what we're actually doing for parsing, the parsing all happens at
> once.
> 
> I do think it's useful to to have the function there partly just as a
> hook but more for the warning it generates if we manage to boot a core
> that we didn't hook up with the topology information.  This seems like
> it'll be helpful for debugging issues - we'll actively warn if there are
> CPUs that have been omitted from the definition in the firmware.  The
> other things the function does could be done elsewhere I think, it
> didn't seem worth moving them though.

I think you have a point, the question is whether we need that function
to run the check you mention or not, we can run the check for all possible
cpus after completing the topology parsing. Actually, we might be
building topology for cores that do not come online as well, I do not think
this is a problem, but I have to cast a proper look into that before
jumping to conclusions, thanks for pointing that out.

Lorenzo
